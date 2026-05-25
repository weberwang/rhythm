import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../app/bootstrap/supabase_bootstrap.dart';
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

/// 提供阶段八同步服务实例，统一编排账号状态、队列上传和冲突统计。
final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(
    queueRepository: ref.watch(syncQueueRepositoryProvider),
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
  }) : _bootstrapState = bootstrapState;

  final SupabaseBootstrapState _bootstrapState;

  @override
  bool get isConfigured => _bootstrapState.configured;

  @override
  bool get isSignedIn {
    if (!_bootstrapState.initialized) {
      return false;
    }
    return Supabase.instance.client.auth.currentSession != null ||
        Supabase.instance.client.auth.currentUser != null;
  }

  @override
  bool get supportsSync => _bootstrapState.syncEnabled && isSignedIn;

  @override
  String? get email {
    if (!_bootstrapState.initialized) {
      return null;
    }
    return Supabase.instance.client.auth.currentUser?.email;
  }

  @override
  Future<List<SyncQueueItem>> pullChanges() async {
    return const <SyncQueueItem>[];
  }

  @override
  Future<void> pushChanges(List<SyncQueueItem> items) async {}
}

/// 统一编排阶段八最小同步流程，确保未登录、冲突和失败场景都能返回稳定摘要。
class SyncService {
  /// 创建同步服务。
  SyncService({
    required SyncQueueRepository queueRepository,
    required SyncRemoteDataSource remoteDataSource,
    required SyncConflictPolicy conflictPolicy,
    required DateTime Function() now,
  }) : _queueRepository = queueRepository,
       _remoteDataSource = remoteDataSource,
       _conflictPolicy = conflictPolicy,
       _now = now;

  final SyncQueueRepository _queueRepository;
  final SyncRemoteDataSource _remoteDataSource;
  final SyncConflictPolicy _conflictPolicy;
  final DateTime Function() _now;
  SyncRunSummary? _lastSummary;

  /// 读取当前同步摘要，供账号与同步页在首次进入时展示本地优先或登录提示状态。
  Future<SyncRunSummary> inspect() async {
    final pendingItems = await _queueRepository.readPendingItems();
    return _lastSummary ??
        SyncRunSummary(
          configured: _remoteDataSource.isConfigured,
          signedIn: _remoteDataSource.isSignedIn,
          supportsRemoteSync: _remoteDataSource.supportsSync,
          email: _remoteDataSource.email,
          pendingCount: pendingItems.length,
        );
  }

  /// 执行一次最小同步流程；当环境未配置或未登录时，直接退回本地优先模式。
  Future<SyncRunSummary> sync() async {
    final pendingItems = await _queueRepository.readPendingItems();
    final baseSummary = SyncRunSummary(
      configured: _remoteDataSource.isConfigured,
      signedIn: _remoteDataSource.isSignedIn,
      supportsRemoteSync: _remoteDataSource.supportsSync,
      email: _remoteDataSource.email,
      pendingCount: pendingItems.length,
    );
    if (!_remoteDataSource.isConfigured ||
        !_remoteDataSource.isSignedIn ||
        !_remoteDataSource.supportsSync) {
      _lastSummary = baseSummary;
      return baseSummary;
    }

    try {
      await _remoteDataSource.pushChanges(pendingItems);
      final remoteItems = await _remoteDataSource.pullChanges();
      final localByKey = <String, SyncQueueItem>{
        for (final item in pendingItems) _entityKey(item): item,
      };
      var downloadedCount = 0;
      var conflictCount = 0;
      for (final remoteItem in remoteItems) {
        final localItem = localByKey[_entityKey(remoteItem)];
        if (localItem == null) {
          downloadedCount += 1;
          continue;
        }

        final resolution = _conflictPolicy.resolve(
          local: localItem,
          remote: remoteItem,
        );
        conflictCount += 1;
        if (!resolution.isDuplicate &&
            resolution.winner == SyncConflictWinner.remote) {
          downloadedCount += 1;
        }
      }
      await _queueRepository.removeItemsByIds(
        pendingItems.map((item) => item.id).toList(growable: false),
      );
      final summary = SyncRunSummary(
        configured: _remoteDataSource.isConfigured,
        signedIn: _remoteDataSource.isSignedIn,
        supportsRemoteSync: _remoteDataSource.supportsSync,
        email: _remoteDataSource.email,
        pendingCount: 0,
        uploadedCount: pendingItems.length,
        downloadedCount: downloadedCount,
        conflictCount: conflictCount,
        lastSyncedAt: _now(),
      );
      _lastSummary = summary;
      return summary;
    } catch (_) {
      final failedItems = pendingItems
          .map(
            (item) => item.copyWith(
              status: SyncQueueStatus.failed,
              retryCount: item.retryCount + 1,
              lastErrorMessage: 'sync_failed',
            ),
          )
          .toList(growable: false);
      await _queueRepository.savePendingItems(failedItems);
      final summary = SyncRunSummary(
        configured: _remoteDataSource.isConfigured,
        signedIn: _remoteDataSource.isSignedIn,
        supportsRemoteSync: _remoteDataSource.supportsSync,
        email: _remoteDataSource.email,
        pendingCount: failedItems.length,
        failureReason: 'sync_failed',
      );
      _lastSummary = summary;
      return summary;
    }
  }

  String _entityKey(SyncQueueItem item) {
    return '${item.entityType.name}:${item.entityId}';
  }
}
