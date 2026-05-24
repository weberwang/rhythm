import 'package:flutter_test/flutter_test.dart';
import 'package:health/health.dart';
import 'package:rhythm/features/sleep_records/data/health_sleep_data_source.dart';
import 'package:rhythm/features/sleep_records/data/sleep_health_client.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';

/// 验证健康数据源的平台状态映射与近 30 天读取逻辑。
void main() {
  group('HealthSleepDataSource', () {
    test('Android Health Connect SDK 状态映射为平台状态', () {
      expect(
        HealthSleepDataSource.mapAndroidSdkStatus(
          HealthConnectSdkStatus.sdkUnavailable,
        ),
        HealthPlatformState.androidInstallRequired(),
      );
      expect(
        HealthSleepDataSource.mapAndroidSdkStatus(
          HealthConnectSdkStatus.sdkUnavailableProviderUpdateRequired,
        ),
        HealthPlatformState.androidUnavailable(),
      );
      expect(
        HealthSleepDataSource.mapAndroidSdkStatus(
          HealthConnectSdkStatus.sdkAvailable,
        ),
        HealthPlatformState.androidAvailable(),
      );
    });

    test('HealthDataPoint 可映射为项目内部睡眠记录', () {
      final point = HealthDataPoint(
        uuid: 'hc-1',
        value: NumericHealthValue(numericValue: 390),
        type: HealthDataType.SLEEP_ASLEEP,
        unit: HealthDataUnit.MINUTE,
        dateFrom: DateTime.utc(2026, 5, 23, 2, 30),
        dateTo: DateTime.utc(2026, 5, 23, 9, 0),
        sourcePlatform: HealthPlatformType.googleHealthConnect,
        sourceDeviceId: 'device-1',
        sourceId: 'source-1',
        sourceName: 'Health Connect',
        recordingMethod: RecordingMethod.automatic,
      );

      final record = HealthSleepDataSource.mapHealthPointToSleepRecord(
        point: point,
        timezone: 'Asia/Shanghai',
        dayStartMinutes: 4 * 60,
        createdAt: DateTime.utc(2026, 5, 23, 9, 1),
      );

      expect(record.id, 'hc-1');
      expect(record.source, SleepRecordSource.healthConnect);
      expect(record.recordDate, DateTime.utc(2026, 5, 22));
      expect(record.durationMinutes, 390);
      expect(record.isUserEdited, isFalse);
    });

    test('读取最近 30 天时会拉取睡眠点并去重过滤无效区间', () async {
      final duplicatedPoint = HealthDataPoint(
        uuid: 'ios-1',
        value: NumericHealthValue(numericValue: 405),
        type: HealthDataType.SLEEP_ASLEEP,
        unit: HealthDataUnit.MINUTE,
        dateFrom: DateTime.utc(2026, 5, 20, 16, 48),
        dateTo: DateTime.utc(2026, 5, 20, 23, 33),
        sourcePlatform: HealthPlatformType.appleHealth,
        sourceDeviceId: 'device-2',
        sourceId: 'source-2',
        sourceName: 'Apple Health',
        recordingMethod: RecordingMethod.manual,
      );
      final invalidPoint = HealthDataPoint(
        uuid: 'invalid',
        value: NumericHealthValue(numericValue: 0),
        type: HealthDataType.SLEEP_ASLEEP,
        unit: HealthDataUnit.MINUTE,
        dateFrom: DateTime.utc(2026, 5, 22, 1, 0),
        dateTo: DateTime.utc(2026, 5, 22, 1, 0),
        sourcePlatform: HealthPlatformType.googleHealthConnect,
        sourceDeviceId: 'device-3',
        sourceId: 'source-3',
        sourceName: 'Health Connect',
        recordingMethod: RecordingMethod.automatic,
      );
      final source = HealthSleepDataSource(
        client: _FakeSleepHealthClient(
          points: <HealthDataPoint>[duplicatedPoint, duplicatedPoint, invalidPoint],
        ),
        nowProvider: () => DateTime.utc(2026, 5, 24, 8, 0),
      );

      final records = await source.readRecentSleepRecords(
        dayStartMinutes: 4 * 60,
        timezone: 'Asia/Shanghai',
      );

      expect(records, hasLength(1));
      expect(records.single.id, 'ios-1');
      expect(records.single.source, SleepRecordSource.healthKit);
      expect(records.single.durationMinutes, 405);
    });
  });
}

class _FakeSleepHealthClient implements SleepHealthClient {
  _FakeSleepHealthClient({this.points = const <HealthDataPoint>[]});

  final List<HealthDataPoint> points;

  @override
  Future<void> configure() async {}

  @override
  Future<HealthConnectSdkStatus?> getHealthConnectSdkStatus() async =>
      HealthConnectSdkStatus.sdkAvailable;

  @override
  Future<List<HealthDataPoint>> getHealthDataFromTypes({
    required List<HealthDataType> types,
    required DateTime startTime,
    required DateTime endTime,
    List<RecordingMethod> recordingMethodsToFilter = const [],
  }) async {
    return points;
  }

  @override
  Future<bool?> hasPermissions(
    List<HealthDataType> types, {
    List<HealthDataAccess>? permissions,
  }) async {
    return true;
  }

  @override
  Future<void> installHealthConnect() async {}

  @override
  Future<bool> isHealthDataHistoryAuthorized() async => true;

  @override
  Future<bool> isHealthDataHistoryAvailable() async => true;

  @override
  Future<bool> requestAuthorization(
    List<HealthDataType> types, {
    List<HealthDataAccess>? permissions,
  }) async {
    return true;
  }

  @override
  Future<bool> requestHealthDataHistoryAuthorization() async => true;
}
