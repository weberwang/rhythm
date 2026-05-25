import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sync/application/sync_service.dart';
import 'package:rhythm/features/sync/data/sync_queue_repository.dart';
import 'package:rhythm/features/sync/domain/sync_conflict_policy.dart';
import 'package:rhythm/features/sync/domain/sync_queue_item.dart';

/// 验证同步服务会在成功、未登录、冲突和失败场景下保持阶段八约定的最小同步行为。
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
      queueRepository: repository,
      remoteDataSource: remote,
      conflictPolicy: const SyncConflictPolicy(),
      now: () => DateTime.utc(2026, 5, 24, 22),
    );

    final summary = await service.sync();

    expect(summary.uploadedCount, 1);
    expect(summary.pendingCount, 0);
    expect(summary.hadFailure, isFalse);
    expect(remote.pushedItems.single.entityId, 'goal');
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
    final repository = _FakeSyncQueueRepository([
      _queueItem(
        id: 'report-local',
        entityType: SyncEntityType.weeklyReportSummary,
        entityId: '2026-05-24',
        updatedAt: DateTime.utc(2026, 5, 24, 7),
        payload: const <String, Object?>{'score': 72},
      ),
    ]);
    final remote = _FakeSyncRemoteDataSource(
      isConfigured: true,
      isSignedIn: true,
      supportsSync: true,
      pulledItems: [
        _queueItem(
          id: 'report-remote',
          entityType: SyncEntityType.weeklyReportSummary,
          entityId: '2026-05-24',
          updatedAt: DateTime.utc(2026, 5, 24, 8),
          payload: const <String, Object?>{'score': 78},
        ),
      ],
    );
    final service = SyncService(
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
