import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sync/domain/sync_conflict_policy.dart';
import 'package:rhythm/features/sync/domain/sync_queue_item.dart';

/// 验证同步冲突策略会按阶段八约定处理本地优先、远端优先和删除冲突。
void main() {
  final policy = SyncConflictPolicy();

  test('用户手动修改优先于远端较新的更新', () {
    final local = _queueItem(
      id: 'local-goal',
      entityType: SyncEntityType.goalSettings,
      entityId: 'goal',
      updatedAt: DateTime.utc(2026, 5, 24, 22),
      payload: const <String, Object?>{'bedtime': '23:30'},
      userEdited: true,
    );
    final remote = _queueItem(
      id: 'remote-goal',
      entityType: SyncEntityType.goalSettings,
      entityId: 'goal',
      updatedAt: DateTime.utc(2026, 5, 24, 23),
      payload: const <String, Object?>{'bedtime': '23:45'},
    );

    final resolution = policy.resolve(local: local, remote: remote);

    expect(resolution.winner, SyncConflictWinner.local);
    expect(resolution.mergedItem.payload['bedtime'], '23:30');
  });

  test('本地未手动编辑时采用远端较新的更新', () {
    final local = _queueItem(
      id: 'local-report',
      entityType: SyncEntityType.weeklyReportSummary,
      entityId: '2026-05-24',
      updatedAt: DateTime.utc(2026, 5, 24, 8),
      payload: const <String, Object?>{'stability': 72},
    );
    final remote = _queueItem(
      id: 'remote-report',
      entityType: SyncEntityType.weeklyReportSummary,
      entityId: '2026-05-24',
      updatedAt: DateTime.utc(2026, 5, 24, 9),
      payload: const <String, Object?>{'stability': 78},
    );

    final resolution = policy.resolve(local: local, remote: remote);

    expect(resolution.winner, SyncConflictWinner.remote);
    expect(resolution.mergedItem.payload['stability'], 78);
  });

  test('删除与更新冲突时保留本地删除结果', () {
    final local = _queueItem(
      id: 'local-delete',
      entityType: SyncEntityType.sleepDelayTag,
      entityId: '2026-05-24',
      operation: SyncOperation.delete,
      updatedAt: DateTime.utc(2026, 5, 24, 10),
      payload: const <String, Object?>{},
      userEdited: true,
    );
    final remote = _queueItem(
      id: 'remote-update',
      entityType: SyncEntityType.sleepDelayTag,
      entityId: '2026-05-24',
      updatedAt: DateTime.utc(2026, 5, 24, 9),
      payload: const <String, Object?>{
        'tags': <String>['加班'],
      },
    );

    final resolution = policy.resolve(local: local, remote: remote);

    expect(resolution.winner, SyncConflictWinner.local);
    expect(resolution.mergedItem.operation, SyncOperation.delete);
  });

  test('相同载荷的重复同步项会被识别为重复', () {
    final local = _queueItem(
      id: 'local-record',
      entityType: SyncEntityType.sleepRecord,
      entityId: 'record-1',
      updatedAt: DateTime.utc(2026, 5, 24, 7),
      payload: const <String, Object?>{'duration': 420},
    );
    final remote = _queueItem(
      id: 'remote-record',
      entityType: SyncEntityType.sleepRecord,
      entityId: 'record-1',
      updatedAt: DateTime.utc(2026, 5, 24, 7, 30),
      payload: const <String, Object?>{'duration': 420},
    );

    final resolution = policy.resolve(local: local, remote: remote);

    expect(resolution.isDuplicate, isTrue);
    expect(resolution.winner, SyncConflictWinner.local);
    expect(resolution.mergedItem.updatedAt, DateTime.utc(2026, 5, 24, 7, 30));
  });
}

/// 快速构造测试使用的同步队列项，避免每个用例重复拼装样板字段。
SyncQueueItem _queueItem({
  required String id,
  required SyncEntityType entityType,
  required String entityId,
  required DateTime updatedAt,
  required Map<String, Object?> payload,
  SyncOperation operation = SyncOperation.upsert,
  bool userEdited = false,
}) {
  return SyncQueueItem(
    id: id,
    entityType: entityType,
    entityId: entityId,
    operation: operation,
    payload: payload,
    updatedAt: updatedAt,
    userEdited: userEdited,
  );
}
