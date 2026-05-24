import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_sync_controller.dart';
import 'package:rhythm/features/sleep_records/data/health_permission_gateway.dart';
import 'package:rhythm/features/sleep_records/data/health_sleep_data_source.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/sleep_record_repository.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';

/// 验证同步控制器会根据平台状态执行同步或降级。
void main() {
  test('平台不可读取数据时进入失败降级状态', () async {
    final controller = SleepRecordSyncController(
      permissionGateway: _FakeHealthPermissionGateway(
        platformState: HealthPlatformState.androidInstallRequired(),
      ),
      dataSource: _FakeHealthSleepDataSource(records: const []),
      repository: _FakeSleepRecordRepository(),
    );

    await controller.syncRecentRecords(
      dayStartMinutes: 4 * 60,
      timezone: 'Asia/Shanghai',
    );

    expect(controller.state.status, SleepRecordSyncStatus.installRequired);
    expect(controller.state.syncedCount, 0);
  });

  test('读取成功后保存记录并产出同步成功状态', () async {
    final record = SleepRecord(
      id: 'raw-1',
      recordDate: DateTime.utc(2026, 5, 22),
      fellAsleepAt: DateTime.utc(2026, 5, 23, 1, 0),
      wokeUpAt: DateTime.utc(2026, 5, 23, 8, 0),
      durationMinutes: 420,
      source: SleepRecordSource.healthConnect,
      confidence: SleepRecordConfidence.high,
      timezone: 'Asia/Shanghai',
      isUserEdited: false,
      sourceRecordId: null,
      createdAt: DateTime.utc(2026, 5, 23, 8, 5),
      updatedAt: DateTime.utc(2026, 5, 23, 8, 5),
    );
    final repository = _FakeSleepRecordRepository();
    final controller = SleepRecordSyncController(
      permissionGateway: _FakeHealthPermissionGateway(
        platformState: HealthPlatformState.androidAvailable(),
      ),
      dataSource: _FakeHealthSleepDataSource(records: [record]),
      repository: repository,
    );

    await controller.syncRecentRecords(
      dayStartMinutes: 4 * 60,
      timezone: 'Asia/Shanghai',
    );

    expect(controller.state.status, SleepRecordSyncStatus.success);
    expect(controller.state.syncedCount, 1);
    expect(repository.savedRecords, [record]);
  });
}

class _FakeHealthPermissionGateway extends HealthPermissionGateway {
  _FakeHealthPermissionGateway({required this.platformState});

  final HealthPlatformState platformState;

  @override
  Future<HealthPlatformState> getCurrentPlatformState() async => platformState;
}

class _FakeHealthSleepDataSource extends HealthSleepDataSource {
  _FakeHealthSleepDataSource({required this.records});

  final List<SleepRecord> records;

  @override
  Future<List<SleepRecord>> readRecentSleepRecords({
    required int dayStartMinutes,
    required String timezone,
  }) async {
    return records;
  }
}

class _FakeSleepRecordRepository implements SleepRecordRepository {
  final List<SleepRecord> savedRecords = <SleepRecord>[];

  @override
  Future<List<SleepRecord>> readRecords({
    required DateTime startRecordDate,
    required DateTime endRecordDate,
  }) async {
    return savedRecords;
  }

  @override
  Future<void> saveRecord(SleepRecord record) async {
    savedRecords.add(record);
  }
}
