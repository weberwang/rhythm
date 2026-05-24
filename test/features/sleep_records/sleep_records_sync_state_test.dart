import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_sync_controller.dart';

/// 验证同步状态摘要会保留阶段三管理页需要的核心字段。
void main() {
  test('copyWith 可更新同步状态与数量', () {
    const state = SleepRecordSyncState();

    final updated = state.copyWith(
      status: SleepRecordSyncStatus.success,
      syncedCount: 3,
      lastSyncedAt: DateTime.utc(2026, 5, 24, 20),
      failureReason: 'none',
    );

    expect(updated.status, SleepRecordSyncStatus.success);
    expect(updated.syncedCount, 3);
    expect(updated.lastSyncedAt, DateTime.utc(2026, 5, 24, 20));
    expect(updated.failureReason, 'none');
  });
}
