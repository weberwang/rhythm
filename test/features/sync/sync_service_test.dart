import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/bootstrap/supabase_bootstrap.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/goal_schedule/domain/repositories/goal_schedule_settings_repository.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/sleep_delay_tag_repository.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/sleep_record_repository.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_snapshot.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';
import 'package:rhythm/features/sync/application/sync_service.dart';
import 'package:rhythm/features/sync/data/sync_queue_repository.dart';
import 'package:rhythm/features/sync/domain/sync_conflict_policy.dart';
import 'package:rhythm/features/sync/domain/sync_queue_item.dart';

/// 验证同步服务会按正式 Supabase 接入方案执行匿名身份、远端映射与快照对账。
void main() {
  test('已登录且远端支持同步时会上传队列并清空本地待同步项', () async {
    final repository = _FakeSyncQueueRepository([
      _queueItem(
        id: 'goal-1',
        entityType: SyncEntityType.goalSettings,
        entityId: 'goal',
        updatedAt: DateTime.utc(2026, 5, 24, 21),
        payload: const <String, Object?>{'bedtime': '23:30'},
      ),
    ]);
    final remote = _FakeSyncRemoteDataSource(
      isConfigured: true,
      isSignedIn: true,
      supportsSync: true,
      email: 'user@example.com',
    );
    final service = SyncService(
      goalSettingsRepository: _FakeGoalScheduleSettingsRepository(
        GoalScheduleSettings(
          targetBedtimeMinutes: 23 * 60 + 30,
          targetWakeMinutes: 7 * 60 + 30,
          lateThresholdMinutes: 30,
          dayStartMinutes: 4 * 60,
          updatedAt: DateTime.utc(2026, 5, 24, 21),
        ),
      ),
      sleepRecordRepository: _FakeSleepRecordRepository(),
      sleepDelayTagRepository: _FakeSleepDelayTagRepository(),
      queueRepository: repository,
      remoteDataSource: remote,
      conflictPolicy: const SyncConflictPolicy(),
      now: () => DateTime.utc(2026, 5, 24, 22),
    );

    final summary = await service.sync();

    expect(summary.uploadedCount, 1);
    expect(summary.pendingCount, 0);
    expect(summary.hadFailure, isFalse);
    expect(remote.pushedItems.single.entityId, 'user-1');
    expect(repository.items, isEmpty);
  });

  test('未登录时不会触发云同步并保留待同步队列', () async {
    final repository = _FakeSyncQueueRepository([
      _queueItem(
        id: 'tag-1',
        entityType: SyncEntityType.sleepDelayTag,
        entityId: '2026-05-24',
        updatedAt: DateTime.utc(2026, 5, 24, 20),
        payload: const <String, Object?>{'tags': <String>['加班']},
      ),
    ]);
    final remote = _FakeSyncRemoteDataSource(
      isConfigured: true,
      isSignedIn: false,
      supportsSync: true,
    );
    final service = SyncService(
      goalSettingsRepository: _FakeGoalScheduleSettingsRepository(null),
      sleepRecordRepository: _FakeSleepRecordRepository(),
      sleepDelayTagRepository: _FakeSleepDelayTagRepository(),
      queueRepository: repository,
      remoteDataSource: remote,
      conflictPolicy: const SyncConflictPolicy(),
      now: () => DateTime.utc(2026, 5, 24, 22),
    );

    final summary = await service.sync();

    expect(summary.requiresSignIn, isTrue);
    expect(summary.uploadedCount, 0);
    expect(remote.pushCallCount, 0);
    expect(repository.items, hasLength(1));
  });

  test('远端较新的同实体更新会计入冲突并采用远端结果', () async {
    final repository = _FakeSyncQueueRepository(const []);
    final remote = _FakeSyncRemoteDataSource(
      isConfigured: true,
      isSignedIn: true,
      supportsSync: true,
      pulledItems: [
        _queueItem(
          id: 'record-1',
          entityType: SyncEntityType.sleepRecord,
          entityId: 'record-1',
          updatedAt: DateTime.utc(2026, 5, 24, 8),
          payload: _sleepRecordRemoteMap(),
        ),
      ],
    );
    final service = SyncService(
      goalSettingsRepository: _FakeGoalScheduleSettingsRepository(null),
      sleepRecordRepository: _FakeSleepRecordRepository([
        SleepRecord(
          id: 'record-1',
          recordDate: DateTime.utc(2026, 5, 25),
          fellAsleepAt: DateTime.utc(2026, 5, 24, 15),
          wokeUpAt: DateTime.utc(2026, 5, 24, 22),
          durationMinutes: 420,
          source: SleepRecordSource.healthConnect,
          confidence: SleepRecordConfidence.medium,
          timezone: 'Asia/Shanghai',
          isUserEdited: false,
          sourceRecordId: null,
          createdAt: DateTime.utc(2026, 5, 24, 7),
          updatedAt: DateTime.utc(2026, 5, 24, 7),
        ),
      ]),
      sleepDelayTagRepository: _FakeSleepDelayTagRepository(),
      queueRepository: repository,
      remoteDataSource: remote,
      conflictPolicy: const SyncConflictPolicy(),
      now: () => DateTime.utc(2026, 5, 24, 22),
    );

    final summary = await service.sync();

    expect(summary.conflictCount, 1);
    expect(summary.downloadedCount, 1);
    expect(summary.hadFailure, isFalse);
    expect(repository.items, isEmpty);
  });

  test('网络失败时保留队列并累加重试次数', () async {
    final repository = _FakeSyncQueueRepository([
      _queueItem(
        id: 'record-1',
        entityType: SyncEntityType.sleepRecord,
        entityId: 'record-1',
        updatedAt: DateTime.utc(2026, 5, 24, 6),
        payload: const <String, Object?>{'duration': 410},
      ),
    ]);
    final remote = _FakeSyncRemoteDataSource(
      isConfigured: true,
      isSignedIn: true,
      supportsSync: true,
      throwOnPush: true,
    );
    final service = SyncService(
      goalSettingsRepository: _FakeGoalScheduleSettingsRepository(null),
      sleepRecordRepository: _FakeSleepRecordRepository(),
      sleepDelayTagRepository: _FakeSleepDelayTagRepository(),
      queueRepository: repository,
      remoteDataSource: remote,
      conflictPolicy: const SyncConflictPolicy(),
      now: () => DateTime.utc(2026, 5, 24, 22),
    );

    final summary = await service.sync();

    expect(summary.hadFailure, isTrue);
    expect(summary.pendingCount, 1);
    expect(repository.items.single.retryCount, 1);
    expect(repository.items.single.status, SyncQueueStatus.failed);
  });

  test('未持有会话且允许同步时会尝试匿名登录', () async {
    final auth = _FakeSupabaseAuth(
      currentSession: null,
      currentUser: null,
    );

    final bootstrap = await initializeSupabaseBootstrapForTest(
      url: 'https://example.supabase.co',
      publishableKey: 'pk-test',
      syncEnabled: true,
      auth: auth,
    );

    expect(auth.signInAnonymouslyCalled, isTrue);
    expect(bootstrap.signedIn, isTrue);
    expect(bootstrap.isAnonymous, isTrue);
    expect(bootstrap.userId, 'anon-user-1');
  });

  test('保存目标作息时会同步写入 updatedAt 元数据', () async {
    expect(
      _FakeGoalScheduleSnapshot(
        updatedAt: DateTime.utc(2026, 5, 25, 7),
      ).updatedAt,
      isNotNull,
    );
  });

  test('远端数据源会把睡眠记录 upsert 到 sync_sleep_records', () async {
    final client = _FakeSupabaseClient();
    final dataSource = SupabaseSyncRemoteDataSource.forTest(
      client: client,
      bootstrapState: const SupabaseBootstrapState(
        configured: true,
        initialized: true,
        syncEnabled: true,
        signedIn: true,
        isAnonymous: true,
        userId: 'user-1',
      ),
    );

    await dataSource.pushSleepRecords([
      _sleepRecordRemoteMap(),
    ]);

    expect(client.upserts.single.table, 'sync_sleep_records');
  });

  test('本地 isUserEdited 睡眠记录优先于远端普通记录', () async {
    final service = _buildSyncServiceForConflict(
      localRecordUpdatedAt: DateTime.utc(2026, 5, 25, 8),
      localUserEdited: true,
      remoteRecordUpdatedAt: DateTime.utc(2026, 5, 25, 9),
    );

    final summary = await service.sync();

    expect(summary.conflictCount, 1);
    expect(summary.uploadedCount, 1);
  });
}

/// 提供测试使用的内存队列仓储，便于直接断言同步后队列残留情况。
class _FakeSyncQueueRepository implements SyncQueueRepository {
  _FakeSyncQueueRepository(List<SyncQueueItem> initialItems)
      : items = [...initialItems];

  final List<SyncQueueItem> items;

  @override
  Future<List<SyncQueueItem>> readPendingItems() async {
    return items
        .where((item) => item.status != SyncQueueStatus.completed)
        .toList();
  }

  @override
  Future<void> removeItemsByIds(List<String> ids) async {
    items.removeWhere((item) => ids.contains(item.id));
  }

  @override
  Future<void> savePendingItems(List<SyncQueueItem> pendingItems) async {
    for (final pendingItem in pendingItems) {
      final index = items.indexWhere((item) => item.id == pendingItem.id);
      if (index == -1) {
        items.add(pendingItem);
        continue;
      }
      items[index] = pendingItem;
    }
  }
}

/// 提供测试使用的远端数据源，覆盖已登录、冲突拉取和网络失败等场景。
class _FakeSyncRemoteDataSource implements SyncRemoteDataSource {
  _FakeSyncRemoteDataSource({
    required this.isConfigured,
    required this.isSignedIn,
    required this.supportsSync,
    this.email,
    this.pulledItems = const <SyncQueueItem>[],
    this.throwOnPush = false,
  });

  @override
  final bool isConfigured;

  @override
  final bool isSignedIn;

  @override
  final bool supportsSync;

  @override
  final String? email;

  @override
  String? get userId => isSignedIn ? 'user-1' : null;

  final List<SyncQueueItem> pulledItems;
  final bool throwOnPush;
  final List<SyncQueueItem> pushedItems = <SyncQueueItem>[];
  int pushCallCount = 0;

  @override
  Future<List<SyncQueueItem>> pullChanges() async {
    return pulledItems;
  }

  @override
  Future<void> pushChanges(List<SyncQueueItem> items) async {
    pushCallCount += 1;
    if (throwOnPush) {
      throw Exception('push failed');
    }
    pushedItems.addAll(items);
  }
}

/// 快速构造测试用同步项，避免用例内重复拼装字段。
SyncQueueItem _queueItem({
  required String id,
  required SyncEntityType entityType,
  required String entityId,
  required DateTime updatedAt,
  required Map<String, Object?> payload,
}) {
  return SyncQueueItem(
    id: id,
    entityType: entityType,
    entityId: entityId,
    operation: SyncOperation.upsert,
    payload: payload,
    updatedAt: updatedAt,
  );
}

/// 提供测试使用的 Supabase 鉴权假实现，用于验证启动阶段的匿名登录决策。
class _FakeSupabaseAuth implements SupabaseBootstrapAuth {
  /// 创建一个可控制当前会话与用户状态的假鉴权对象。
  _FakeSupabaseAuth({
    required this.currentSession,
    required this.currentUser,
  });

  Object? currentSession;
  _FakeSupabaseUser? currentUser;
  bool signInAnonymouslyCalled = false;

  @override
  bool get hasSession => currentSession != null;

  @override
  bool get isSignedIn => currentSession != null || currentUser != null;

  @override
  bool get isAnonymous => currentUser?.isAnonymous ?? false;

  @override
  String? get userId => currentUser?.id;

  @override
  Future<void> signInAnonymously() async {
    signInAnonymouslyCalled = true;
    currentSession = Object();
    currentUser = const _FakeSupabaseUser(
      id: 'anon-user-1',
      isAnonymous: true,
    );
  }
}

/// 表示测试中的最小用户快照，只保留启动状态需要的身份字段。
class _FakeSupabaseUser {
  /// 创建测试用户快照。
  const _FakeSupabaseUser({
    required this.id,
    required this.isAnonymous,
  });

  final String id;
  final bool isAnonymous;
}

/// 表示目标作息同步快照，供失败测试先约束 `updatedAt` 语义。
class _FakeGoalScheduleSnapshot {
  /// 创建目标作息同步快照。
  const _FakeGoalScheduleSnapshot({required this.updatedAt});

  final DateTime updatedAt;
}

/// 提供测试使用的目标作息仓储假实现，供同步服务组装本地快照。
class _FakeGoalScheduleSettingsRepository
    implements GoalScheduleSettingsRepository {
  _FakeGoalScheduleSettingsRepository(this._settings);

  GoalScheduleSettings? _settings;

  @override
  Future<GoalScheduleSettings?> read() async => _settings;

  @override
  Future<void> save(GoalScheduleSettings settings) async {
    _settings = settings;
  }
}

/// 提供测试使用的睡眠记录仓储假实现，支持全量快照读取。
class _FakeSleepRecordRepository implements SleepRecordRepository {
  _FakeSleepRecordRepository([List<SleepRecord> initialRecords = const []])
      : _records = [...initialRecords];

  final List<SleepRecord> _records;

  @override
  Future<List<SleepRecord>> readAllRecords() async {
    return List<SleepRecord>.from(_records);
  }

  @override
  Future<SleepRecord?> readRecordById(String id) async {
    for (final record in _records) {
      if (record.id == id) {
        return record;
      }
    }
    return null;
  }

  @override
  Future<List<SleepRecord>> readRecords({
    required DateTime startRecordDate,
    required DateTime endRecordDate,
  }) async {
    return _records
        .where(
          (record) =>
              !record.recordDate.isBefore(startRecordDate) &&
              !record.recordDate.isAfter(endRecordDate),
        )
        .toList(growable: false);
  }

  @override
  Future<void> saveRecord(SleepRecord record) async {
    final index = _records.indexWhere((item) => item.id == record.id);
    if (index == -1) {
      _records.add(record);
      return;
    }
    _records[index] = record;
  }
}

/// 提供测试使用的晚睡标签仓储假实现，支持全量快照读取与回写。
class _FakeSleepDelayTagRepository implements SleepDelayTagRepository {
  _FakeSleepDelayTagRepository([
    List<SleepDelayTagSnapshot> initialSnapshots = const [],
  ]) : _snapshots = {
         for (final snapshot in initialSnapshots) snapshot.recordDate: snapshot,
       };

  final Map<DateTime, SleepDelayTagSnapshot> _snapshots;

  @override
  Future<List<SleepDelayTagSnapshot>> readAllTags() async {
    return _snapshots.values.toList(growable: false);
  }

  @override
  Future<List<String>> readTags({required DateTime recordDate}) async {
    return List<String>.from(
      _snapshots[DateTime.utc(
            recordDate.year,
            recordDate.month,
            recordDate.day,
          )]
              ?.tags ??
          const <String>[],
    );
  }

  @override
  Future<void> saveTags({
    required DateTime recordDate,
    required List<String> tags,
  }) async {
    await saveTagsSnapshot(
      recordDate: recordDate,
      tags: tags,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  @override
  Future<void> saveTagsSnapshot({
    required DateTime recordDate,
    required List<String> tags,
    required DateTime updatedAt,
  }) async {
    final normalizedDate = DateTime.utc(
      recordDate.year,
      recordDate.month,
      recordDate.day,
    );
    _snapshots[normalizedDate] = SleepDelayTagSnapshot(
      recordDate: normalizedDate,
      tags: List<String>.from(tags),
      updatedAt: updatedAt,
    );
  }
}

/// 伪造的 Supabase 客户端，供远端 DTO 测试约束 upsert 目标表名。
class _FakeSupabaseClient {
  final List<_FakeUpsertCall> upserts = <_FakeUpsertCall>[];

  _FakeUpsertCall createUpsertCall({
    required String table,
    required List<Map<String, Object?>> payload,
  }) {
    return _FakeUpsertCall(table: table, payload: payload);
  }
}

/// 记录一次 upsert 调用的目标表名与载荷。
class _FakeUpsertCall {
  /// 创建 upsert 调用记录。
  const _FakeUpsertCall({
    required this.table,
    required this.payload,
  });

  final String table;
  final List<Map<String, Object?>> payload;
}

/// 构造测试用远端睡眠记录映射，供 DTO 测试复用。
Map<String, Object?> _sleepRecordRemoteMap() {
  return <String, Object?>{
    'id': 'record-1',
    'user_id': 'user-1',
    'record_date': '2026-05-25',
    'fell_asleep_at': DateTime.utc(2026, 5, 25, 15).toIso8601String(),
    'woke_up_at': DateTime.utc(2026, 5, 25, 23).toIso8601String(),
    'duration_minutes': 480,
    'source': 'manual',
    'confidence': 'high',
    'timezone': 'Asia/Shanghai',
    'is_user_edited': true,
    'source_record_id': null,
    'created_at': DateTime.utc(2026, 5, 25, 23, 5).toIso8601String(),
    'updated_at': DateTime.utc(2026, 5, 25, 23, 5).toIso8601String(),
  };
}

/// 构造冲突用同步服务，先用失败测试约束本地用户编辑优先规则。
SyncService _buildSyncServiceForConflict({
  required DateTime localRecordUpdatedAt,
  required bool localUserEdited,
  required DateTime remoteRecordUpdatedAt,
}) {
  final repository = _FakeSyncQueueRepository(const []);
  final remote = _FakeSyncRemoteDataSource(
    isConfigured: true,
    isSignedIn: true,
    supportsSync: true,
    pulledItems: [
      SyncQueueItem(
        id: 'remote-record',
        entityType: SyncEntityType.sleepRecord,
        entityId: 'record-1',
        operation: SyncOperation.upsert,
        payload: const <String, Object?>{
          'id': 'record-1',
          'isUserEdited': false,
        },
        updatedAt: remoteRecordUpdatedAt,
      ),
    ],
  );

  return SyncService(
    goalSettingsRepository: _FakeGoalScheduleSettingsRepository(null),
    sleepRecordRepository: _FakeSleepRecordRepository([
      SleepRecord(
        id: 'record-1',
        recordDate: DateTime.utc(2026, 5, 25),
        fellAsleepAt: DateTime.utc(2026, 5, 25, 15),
        wokeUpAt: DateTime.utc(2026, 5, 25, 23),
        durationMinutes: 480,
        source: SleepRecordSource.manual,
        confidence: SleepRecordConfidence.high,
        timezone: 'Asia/Shanghai',
        isUserEdited: localUserEdited,
        sourceRecordId: null,
        createdAt: localRecordUpdatedAt,
        updatedAt: localRecordUpdatedAt,
      ),
    ]),
    sleepDelayTagRepository: _FakeSleepDelayTagRepository(),
    queueRepository: repository,
    remoteDataSource: remote,
    conflictPolicy: const SyncConflictPolicy(),
    now: () => DateTime.utc(2026, 5, 25, 10),
  );
}
