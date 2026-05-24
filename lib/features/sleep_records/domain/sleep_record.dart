import 'sleep_record_confidence.dart';
import 'sleep_record_source.dart';

/// 表示一条底层睡眠记录，可来自系统同步、手动补录或用户修正。
class SleepRecord {
  /// 创建睡眠记录实例。
  const SleepRecord({
    required this.id,
    required this.recordDate,
    required this.fellAsleepAt,
    required this.wokeUpAt,
    required this.durationMinutes,
    required this.source,
    required this.confidence,
    required this.timezone,
    required this.isUserEdited,
    required this.sourceRecordId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 记录唯一标识。
  final String id;

  /// 业务归属日，按项目的一天起始时间计算。
  final DateTime recordDate;

  /// 入睡时间。
  final DateTime fellAsleepAt;

  /// 起床时间。
  final DateTime wokeUpAt;

  /// 睡眠时长，单位为分钟。
  final int durationMinutes;

  /// 记录来源。
  final SleepRecordSource source;

  /// 记录可信度。
  final SleepRecordConfidence confidence;

  /// 记录发生时所处时区标识。
  final String timezone;

  /// 是否属于用户手动编辑或手动补录结果。
  final bool isUserEdited;

  /// 若当前记录源自对系统记录的修正，则保留被修正记录的主键。
  final String? sourceRecordId;

  /// 记录创建时间。
  final DateTime createdAt;

  /// 记录最后更新时间。
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) {
    return other is SleepRecord &&
        id == other.id &&
        recordDate == other.recordDate &&
        fellAsleepAt == other.fellAsleepAt &&
        wokeUpAt == other.wokeUpAt &&
        durationMinutes == other.durationMinutes &&
        source == other.source &&
        confidence == other.confidence &&
        timezone == other.timezone &&
        isUserEdited == other.isUserEdited &&
        sourceRecordId == other.sourceRecordId &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => Object.hash(
        id,
        recordDate,
        fellAsleepAt,
        wokeUpAt,
        durationMinutes,
        source,
        confidence,
        timezone,
        isUserEdited,
        sourceRecordId,
        createdAt,
        updatedAt,
      );
}
