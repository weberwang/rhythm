import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../app/bootstrap/supabase_bootstrap.dart';
import '../../goal_schedule/application/goal_schedule_providers.dart';
import '../../goal_schedule/domain/goal_schedule_settings.dart';
import '../../goal_schedule/domain/repositories/goal_schedule_settings_repository.dart';
import '../../sleep_records/application/sleep_delay_tag_providers.dart';
import '../../sleep_records/application/sleep_record_providers.dart';
import '../../sleep_records/domain/repositories/sleep_delay_tag_repository.dart';
import '../../sleep_records/domain/repositories/sleep_record_repository.dart';
import '../../sleep_records/domain/sleep_delay_tag_snapshot.dart';
import '../../sleep_records/domain/sleep_record.dart';
import '../data/supabase_sync_models.dart';
import '../data/sync_queue_repository.dart';
import '../domain/sync_conflict_policy.dart';
import '../domain/sync_queue_item.dart';

/// 定义远端同步边界，便于测试通过假实现覆盖已登录、冲突和失败等场景。
abstract class SyncRemoteDataSource {
  /// 当前环境是否已具备 Supabase 基础配置。
  bool get isConfigured;

  /// 当前是否存在可用登录态。
  bool get isSignedIn;

  /// 当前环境是否允许真正执行远端读写。
  bool get supportsSync;

  /// 当前登录用户邮箱；未登录时返回空。
  String? get email;

  /// 当前同步身份对应的用户 ID。
  String? get userId;

  /// 将本地待同步项推送到远端。
  Future<void> pushChanges(List<SyncQueueItem> items);

  /// 拉取远端最新变更。
  Future<List<SyncQueueItem>> pullChanges();
}

/// 提供远端同步边界默认实现；当 Supabase 未配置或未开启同步开关时，自动退回本地优先模式。
final syncRemoteDataSourceProvider = Provider<SyncRemoteDataSource>((ref) {
  final bootstrapState = ref.watch(supabaseBootstrapStateProvider);
  return SupabaseSyncRemoteDataSource(bootstrapState: bootstrapState);
});

/// 提供同步冲突策略实例，避免页面和服务层自行判断本地优先逻辑。
final syncConflictPolicyProvider = Provider<SyncConflictPolicy>((ref) {
  return const SyncConflictPolicy();
});

/// 提供阶段八同步服务实例，统一编排账号状态、快照对账和冲突统计。
final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(
    goalSettingsRepository: ref.watch(goalScheduleSettingsRepositoryProvider),
    sleepRecordRepository: ref.watch(sleepRecordRepositoryProvider),
    sleepDelayTagRepository: ref.watch(sleepDelayTagRepositoryProvider),
    remoteDataSource: ref.watch(syncRemoteDataSourceProvider),
    conflictPolicy: ref.watch(syncConflictPolicyProvider),
    now: DateTime.now,
  );
});

/// 使用 Supabase 启动状态读取当前登录态；在未开启远端同步时只保留会话判断，不发起真实读写。
class SupabaseSyncRemoteDataSource implements SyncRemoteDataSource {
  /// 创建 Supabase 远端同步边界实例。
  SupabaseSyncRemoteDataSource({
    required SupabaseBootstrapState bootstrapState,
    SupabaseClient? client,
  }) : _bootstrapState = bootstrapState,
       _client = client;

  final SupabaseBootstrapState _bootstrapState;
  final SupabaseClient? _client;

  /// 提供测试专用构造入口，便于注入假客户端并绕开全局单例。
  factory SupabaseSyncRemoteDataSource.forTest({
    required SupabaseBootstrapState bootstrapState,
    required dynamic client,
  }) {
    return _FakeSupabaseSyncRemoteDataSource(
      bootstrapState: bootstrapState,
      client: client,
    );
  }

  SupabaseClient get _resolvedClient => _client ?? Supabase.instance.client;

  @override
  bool get isConfigured => _bootstrapState.configured;

  @override
  bool get isSignedIn {
    if (!_bootstrapState.initialized) {
      return false;
    }
    return _resolvedClient.auth.currentSession != null ||
        _resolvedClient.auth.currentUser != null;
  }

  @override
  bool get supportsSync => _bootstrapState.syncEnabled && isSignedIn;

  @override
  String? get email {
    if (!_bootstrapState.initialized) {
      return null;
    }
    return _resolvedClient.auth.currentUser?.email;
  }

  @override
  String? get userId => _bootstrapState.userId;

  @override
  Future<List<SyncQueueItem>> pullChanges() async {
    final currentUserId = userId;
    if (!supportsSync || currentUserId == null) {
      return const <SyncQueueItem>[];
    }

    final goalRows = await _resolvedClient
        .from('sync_goal_settings')
        .select()
        .eq('user_id', currentUserId) as List<dynamic>;
    final recordRows = await _resolvedClient
        .from('sync_sleep_records')
        .select()
        .eq('user_id', currentUserId) as List<dynamic>;
    final tagRows = await _resolvedClient
        .from('sync_sleep_delay_tags')
        .select()
        .eq('user_id', currentUserId) as List<dynamic>;

    return <SyncQueueItem>[
      ...goalRows.map(
        (row) => _goalSettingsToQueueItem(
          SyncGoalSettingsRemoteModel.fromJson(
            Map<String, Object?>.from(row as Map),
          ),
        ),
      ),
      ...recordRows.map(
        (row) => _sleepRecordToQueueItem(
          SyncSleepRecordRemoteModel.fromJson(
            Map<String, Object?>.from(row as Map),
          ),
        ),
      ),
      ...tagRows.map(
        (row) => _sleepDelayTagToQueueItem(
          SyncSleepDelayTagRemoteModel.fromJson(
            Map<String, Object?>.from(row as Map),
          ),
        ),
      ),
    ];
  }

  @override
  Future<void> pushChanges(List<SyncQueueItem> items) async {
    if (!supportsSync) {
      return;
    }

    final goalRows = <Map<String, Object?>>[];
    final sleepRecordRows = <Map<String, Object?>>[];
    final tagRows = <Map<String, Object?>>[];

    for (final item in items) {
      if (item.operation != SyncOperation.upsert) {
        continue;
      }
      switch (item.entityType) {
        case SyncEntityType.goalSettings:
          goalRows.add(Map<String, Object?>.from(item.payload));
        case SyncEntityType.sleepRecord:
          sleepRecordRows.add(Map<String, Object?>.from(item.payload));
        case SyncEntityType.sleepDelayTag:
          tagRows.add(Map<String, Object?>.from(item.payload));
        case SyncEntityType.weeklyReportSummary:
          break;
      }
    }

    if (goalRows.isNotEmpty) {
      await _resolvedClient.from('sync_goal_settings').upsert(goalRows);
    }
    if (sleepRecordRows.isNotEmpty) {
      await _resolvedClient.from('sync_sleep_records').upsert(sleepRecordRows);
    }
    if (tagRows.isNotEmpty) {
      await _resolvedClient.from('sync_sleep_delay_tags').upsert(tagRows);
    }
  }

  /// 推送睡眠记录行，供测试直接约束目标表名与映射结构。
  Future<void> pushSleepRecords(List<Map<String, Object?>> rows) async {
    await _resolvedClient.from('sync_sleep_records').upsert(rows);
  }

  SyncQueueItem _goalSettingsToQueueItem(SyncGoalSettingsRemoteModel model) {
    return SyncQueueItem(
      id: 'goal:${model.userId}',
      entityType: SyncEntityType.goalSettings,
      entityId: model.userId,
      operation: SyncOperation.upsert,
      payload: model.toJson(),
      updatedAt: model.updatedAt,
    );
  }

  SyncQueueItem _sleepRecordToQueueItem(SyncSleepRecordRemoteModel model) {
    return SyncQueueItem(
      id: model.id,
      entityType: SyncEntityType.sleepRecord,
      entityId: model.id,
      operation: SyncOperation.upsert,
      payload: model.toJson(),
      updatedAt: model.updatedAt,
      userEdited: model.isUserEdited,
    );
  }

  SyncQueueItem _sleepDelayTagToQueueItem(SyncSleepDelayTagRemoteModel model) {
    final entityId =
        '${model.recordDate.year.toString().padLeft(4, '0')}-'
        '${model.recordDate.month.toString().padLeft(2, '0')}-'
        '${model.recordDate.day.toString().padLeft(2, '0')}';
    return SyncQueueItem(
      id: 'tag:$entityId',
      entityType: SyncEntityType.sleepDelayTag,
      entityId: entityId,
      operation: SyncOperation.upsert,
      payload: model.toJson(),
      updatedAt: model.updatedAt,
    );
  }
}

/// 测试专用远端实现，允许使用动态假客户端约束 upsert 行为而不依赖官方 SDK。
class _FakeSupabaseSyncRemoteDataSource extends SupabaseSyncRemoteDataSource {
  _FakeSupabaseSyncRemoteDataSource({
    required super.bootstrapState,
    required this.client,
  });

  final dynamic client;

  @override
  bool get isSignedIn => super._bootstrapState.signedIn;

  @override
  bool get supportsSync =>
      super._bootstrapState.syncEnabled && super._bootstrapState.signedIn;

  @override
  Future<void> pushSleepRecords(List<Map<String, Object?>> rows) async {
    client.upserts.add(
      client.createUpsertCall(
        table: 'sync_sleep_records',
        payload: rows,
      ),
    );
  }
}

/// 统一编排阶段八正式同步流程，使用本地与远端快照对账替代临时队列骨架。
class SyncService {
  /// 创建同步服务。
  SyncService({
    required GoalScheduleSettingsRepository goalSettingsRepository,
    required SleepRecordRepository sleepRecordRepository,
    required SleepDelayTagRepository sleepDelayTagRepository,
    required SyncRemoteDataSource remoteDataSource,
    required SyncConflictPolicy conflictPolicy,
    required DateTime Function() now,
    SyncQueueRepository? queueRepository,
  }) : _goalSettingsRepository = goalSettingsRepository,
       _sleepRecordRepository = sleepRecordRepository,
       _sleepDelayTagRepository = sleepDelayTagRepository,
       _remoteDataSource = remoteDataSource,
       _conflictPolicy = conflictPolicy,
       _now = now,
       _queueRepository = queueRepository;

  final GoalScheduleSettingsRepository _goalSettingsRepository;
  final SleepRecordRepository _sleepRecordRepository;
  final SleepDelayTagRepository _sleepDelayTagRepository;
  final SyncRemoteDataSource _remoteDataSource;
  final SyncConflictPolicy _conflictPolicy;
  final DateTime Function() _now;
  final SyncQueueRepository? _queueRepository;
  SyncRunSummary? _lastSummary;

  /// 读取当前同步摘要，供账号与同步页在首次进入时展示本地优先或登录提示状态。
  Future<SyncRunSummary> inspect() async {
    final pendingCount = _queueRepository == null
        ? 0
        : (await _queueRepository.readPendingItems()).length;
    return _lastSummary ??
        SyncRunSummary(
          configured: _remoteDataSource.isConfigured,
          signedIn: _remoteDataSource.isSignedIn,
          supportsRemoteSync: _remoteDataSource.supportsSync,
          email: _remoteDataSource.email,
          pendingCount: pendingCount,
        );
  }

  /// 执行一次正式同步流程；当环境未配置或未登录时，直接退回本地优先模式。
  Future<SyncRunSummary> sync() async {
    final pendingCount = _queueRepository == null
        ? 0
        : (await _queueRepository.readPendingItems()).length;
    final baseSummary = SyncRunSummary(
      configured: _remoteDataSource.isConfigured,
      signedIn: _remoteDataSource.isSignedIn,
      supportsRemoteSync: _remoteDataSource.supportsSync,
      email: _remoteDataSource.email,
      pendingCount: pendingCount,
    );
    if (!_remoteDataSource.isConfigured ||
        !_remoteDataSource.isSignedIn ||
        !_remoteDataSource.supportsSync) {
      _lastSummary = baseSummary;
      return baseSummary;
    }

    try {
      final localSnapshot = await _readLocalSnapshot();
      final remoteSnapshot = await _remoteDataSource.pullChanges();
      final remoteByKey = <String, SyncQueueItem>{
        for (final item in remoteSnapshot) _entityKey(item): item,
      };

      final remoteWinners = <SyncQueueItem>[];
      final localWinners = <SyncQueueItem>[];
      var conflictCount = 0;

      for (final localItem in localSnapshot) {
        final key = _entityKey(localItem);
        final remoteItem = remoteByKey.remove(key);
        if (remoteItem == null) {
          remoteWinners.add(localItem);
          continue;
        }

        final resolution = _conflictPolicy.resolve(
          local: localItem,
          remote: remoteItem,
        );
        if (!resolution.isDuplicate) {
          conflictCount += 1;
        }
        if (resolution.winner == SyncConflictWinner.local) {
          remoteWinners.add(resolution.mergedItem);
        } else {
          localWinners.add(resolution.mergedItem);
        }
      }

      localWinners.addAll(remoteByKey.values);
      await _remoteDataSource.pushChanges(remoteWinners);
      await _writeLocalWinners(localWinners);
      if (_queueRepository != null) {
        final pendingItems = await _queueRepository.readPendingItems();
        await _queueRepository.removeItemsByIds(
          pendingItems.map((item) => item.id).toList(growable: false),
        );
      }

      final summary = SyncRunSummary(
        configured: _remoteDataSource.isConfigured,
        signedIn: _remoteDataSource.isSignedIn,
        supportsRemoteSync: _remoteDataSource.supportsSync,
        email: _remoteDataSource.email,
        pendingCount: 0,
        uploadedCount: remoteWinners.length,
        downloadedCount: localWinners.length,
        conflictCount: conflictCount,
        lastSyncedAt: _now(),
      );
      _lastSummary = summary;
      return summary;
    } catch (_) {
      if (_queueRepository != null) {
        final failedItems = (await _queueRepository.readPendingItems())
            .map(
              (item) => item.copyWith(
                status: SyncQueueStatus.failed,
                retryCount: item.retryCount + 1,
                lastErrorMessage: 'sync_failed',
              ),
            )
            .toList(growable: false);
        await _queueRepository.savePendingItems(failedItems);
      }
      final summary = SyncRunSummary(
        configured: _remoteDataSource.isConfigured,
        signedIn: _remoteDataSource.isSignedIn,
        supportsRemoteSync: _remoteDataSource.supportsSync,
        email: _remoteDataSource.email,
        pendingCount: pendingCount,
        failureReason: 'sync_failed',
      );
      _lastSummary = summary;
      return summary;
    }
  }

  /// 读取本地正式同步快照，并统一映射为最小同步项。
  Future<List<SyncQueueItem>> _readLocalSnapshot() async {
    final items = <SyncQueueItem>[];
    final currentUserId = _remoteDataSource.userId;
    if (currentUserId == null) {
      return items;
    }

    final goalSettings = await _goalSettingsRepository.read();
    if (goalSettings != null) {
      final model = SyncGoalSettingsRemoteModel.fromDomain(
        userId: currentUserId,
        settings: goalSettings,
      );
      items.add(
        SyncQueueItem(
          id: 'goal:$currentUserId',
          entityType: SyncEntityType.goalSettings,
          entityId: currentUserId,
          operation: SyncOperation.upsert,
          payload: model.toJson(),
          updatedAt: model.updatedAt,
        ),
      );
    }

    final sleepRecords = await _sleepRecordRepository.readAllRecords();
    for (final record in sleepRecords) {
      final model = SyncSleepRecordRemoteModel.fromDomain(
        userId: currentUserId,
        record: record,
      );
      items.add(
        SyncQueueItem(
          id: record.id,
          entityType: SyncEntityType.sleepRecord,
          entityId: record.id,
          operation: SyncOperation.upsert,
          payload: model.toJson(),
          updatedAt: model.updatedAt,
          userEdited: record.isUserEdited,
        ),
      );
    }

    final tagSnapshots = await _sleepDelayTagRepository.readAllTags();
    for (final snapshot in tagSnapshots) {
      final model = SyncSleepDelayTagRemoteModel.fromDomain(
        userId: currentUserId,
        snapshot: snapshot,
      );
      final entityId = _dateKey(snapshot.recordDate);
      items.add(
        SyncQueueItem(
          id: 'tag:$entityId',
          entityType: SyncEntityType.sleepDelayTag,
          entityId: entityId,
          operation: SyncOperation.upsert,
          payload: model.toJson(),
          updatedAt: model.updatedAt,
        ),
      );
    }
    return items;
  }

  /// 将远端胜出的快照写回本地，统一落到既有仓储边界中。
  Future<void> _writeLocalWinners(List<SyncQueueItem> items) async {
    for (final item in items) {
      switch (item.entityType) {
        case SyncEntityType.goalSettings:
          final model = SyncGoalSettingsRemoteModel.fromJson(item.payload);
          await _goalSettingsRepository.save(model.toDomain());
        case SyncEntityType.sleepRecord:
          final model = SyncSleepRecordRemoteModel.fromJson(item.payload);
          await _sleepRecordRepository.saveRecord(model.toDomain());
        case SyncEntityType.sleepDelayTag:
          final model = SyncSleepDelayTagRemoteModel.fromJson(item.payload);
          final snapshot = model.toDomain();
          await _sleepDelayTagRepository.saveTagsSnapshot(
            recordDate: snapshot.recordDate,
            tags: snapshot.tags,
            updatedAt: snapshot.updatedAt,
          );
        case SyncEntityType.weeklyReportSummary:
          break;
      }
    }
  }

  String _entityKey(SyncQueueItem item) {
    return '${item.entityType.name}:${item.entityId}';
  }

  String _dateKey(DateTime value) {
    return '${value.year.toString().padLeft(4, '0')}-'
        '${value.month.toString().padLeft(2, '0')}-'
        '${value.day.toString().padLeft(2, '0')}';
  }
}
