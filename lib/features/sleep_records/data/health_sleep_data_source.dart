import 'package:health/health.dart';
import 'package:rhythm/core/time/sleep_record_day_resolver.dart';
import 'package:rhythm/features/sleep_records/data/sleep_health_client.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';

/// 封装健康插件数据映射，统一把平台数据点转换为项目内部睡眠记录。
class HealthSleepDataSource {
  /// 创建健康睡眠数据源实例。
  HealthSleepDataSource({
    SleepHealthClient? client,
    DateTime Function()? nowProvider,
  })  : _client = client ?? PluginSleepHealthClient(),
        _nowProvider = nowProvider ?? DateTime.now;

  final SleepHealthClient _client;
  final DateTime Function() _nowProvider;

  static const List<HealthDataType> _sleepTypes = <HealthDataType>[
    HealthDataType.SLEEP_ASLEEP,
  ];

  /// 将 Android SDK 状态映射为阶段三使用的平台状态。
  static HealthPlatformState mapAndroidSdkStatus(
    HealthConnectSdkStatus status,
  ) {
    switch (status) {
      case HealthConnectSdkStatus.sdkAvailable:
        return HealthPlatformState.androidAvailable();
      case HealthConnectSdkStatus.sdkUnavailable:
        return HealthPlatformState.androidInstallRequired();
      case HealthConnectSdkStatus.sdkUnavailableProviderUpdateRequired:
        return HealthPlatformState.androidUnavailable();
    }
  }

  /// 将健康插件返回的数据点映射为项目内部睡眠记录。
  static SleepRecord mapHealthPointToSleepRecord({
    required HealthDataPoint point,
    required String timezone,
    required int dayStartMinutes,
    required DateTime createdAt,
  }) {
    final source = switch (point.sourcePlatform) {
      HealthPlatformType.appleHealth => SleepRecordSource.healthKit,
      HealthPlatformType.googleHealthConnect => SleepRecordSource.healthConnect,
    };

    final confidence = switch (point.recordingMethod) {
      RecordingMethod.manual => SleepRecordConfidence.medium,
      RecordingMethod.automatic => SleepRecordConfidence.high,
      RecordingMethod.active => SleepRecordConfidence.medium,
      RecordingMethod.unknown => SleepRecordConfidence.unknown,
    };

    return SleepRecord(
      id: point.uuid.isEmpty
          ? '${point.sourceId}:${point.dateFrom.millisecondsSinceEpoch}'
          : point.uuid,
      recordDate: SleepRecordDayResolver.resolveRecordDate(
        fellAsleepAt: point.dateFrom,
        dayStartMinutes: dayStartMinutes,
      ),
      fellAsleepAt: point.dateFrom,
      wokeUpAt: point.dateTo,
      durationMinutes: point.dateTo.difference(point.dateFrom).inMinutes,
      source: source,
      confidence: confidence,
      timezone: timezone,
      isUserEdited: false,
      sourceRecordId: null,
      createdAt: createdAt,
      updatedAt: createdAt,
    );
  }

  /// 读取最近 30 天睡眠记录，并统一映射到项目内部睡眠记录模型。
  Future<List<SleepRecord>> readRecentSleepRecords({
    required int dayStartMinutes,
    required String timezone,
  }) async {
    await _client.configure();
    final endTime = _nowProvider();
    final startTime = endTime.subtract(const Duration(days: 30));
    final points = await _client.getHealthDataFromTypes(
      types: _sleepTypes,
      startTime: startTime,
      endTime: endTime,
    );

    final seenKeys = <String>{};
    final records = <SleepRecord>[];
    for (final point in points) {
      if (!point.dateTo.isAfter(point.dateFrom)) {
        continue;
      }

      final key = point.uuid.isNotEmpty
          ? point.uuid
          : '${point.type.name}:${point.sourceId}:${point.dateFrom.millisecondsSinceEpoch}:${point.dateTo.millisecondsSinceEpoch}';
      if (!seenKeys.add(key)) {
        continue;
      }

      records.add(
        mapHealthPointToSleepRecord(
          point: point,
          timezone: timezone,
          dayStartMinutes: dayStartMinutes,
          createdAt: endTime,
        ),
      );
    }

    records.sort(
      (left, right) => right.fellAsleepAt.compareTo(left.fellAsleepAt),
    );
    return records;
  }
}
