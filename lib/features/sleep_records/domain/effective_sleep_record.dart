import 'sleep_record_confidence.dart';
import 'sleep_record_source.dart';

/// 表示最终提供给页面消费的有效睡眠记录。
class EffectiveSleepRecord {
  /// 创建有效睡眠记录实例。
  const EffectiveSleepRecord({
    required this.recordId,
    required this.recordDate,
    required this.fellAsleepAt,
    required this.wokeUpAt,
    required this.durationMinutes,
    required this.source,
    required this.confidence,
    required this.timezone,
    required this.isUserConfirmed,
    required this.sourceRecordId,
  });

  /// 当前作为展示基准的记录主键。
  final String recordId;

  /// 业务归属日。
  final DateTime recordDate;

  /// 入睡时间。
  final DateTime fellAsleepAt;

  /// 起床时间。
  final DateTime wokeUpAt;

  /// 睡眠时长，单位为分钟。
  final int durationMinutes;

  /// 展示记录来源。
  final SleepRecordSource source;

  /// 展示记录可信度。
  final SleepRecordConfidence confidence;

  /// 记录时区。
  final String timezone;

  /// 当前记录是否来自用户确认结果。
  final bool isUserConfirmed;

  /// 若该记录是对原始系统记录的覆盖，则保留原始记录主键。
  final String? sourceRecordId;

  @override
  bool operator ==(Object other) {
    return other is EffectiveSleepRecord &&
        recordId == other.recordId &&
        recordDate == other.recordDate &&
        fellAsleepAt == other.fellAsleepAt &&
        wokeUpAt == other.wokeUpAt &&
        durationMinutes == other.durationMinutes &&
        source == other.source &&
        confidence == other.confidence &&
        timezone == other.timezone &&
        isUserConfirmed == other.isUserConfirmed &&
        sourceRecordId == other.sourceRecordId;
  }

  @override
  int get hashCode => Object.hash(
        recordId,
        recordDate,
        fellAsleepAt,
        wokeUpAt,
        durationMinutes,
        source,
        confidence,
        timezone,
        isUserConfirmed,
        sourceRecordId,
      );
}
