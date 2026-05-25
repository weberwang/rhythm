import '../../goal_schedule/domain/goal_schedule.dart';

/// 睡眠记录来源，区分系统同步和用户手动修正场景。
enum SleepRecordSource { healthKit, healthConnect, manual, imported }

/// 睡眠记录可信度，用于后续在 UI 中表达数据质量。
enum SleepRecordConfidence { high, medium, low, unknown }

/// 睡眠记录实体，承载入睡、起床和来源等核心信息。
class SleepRecord {
  const SleepRecord({
    required this.id,
    required this.recordDate,
    required this.fellAsleepAt,
    required this.wokeUpAt,
    required this.source,
    required this.confidence,
    required this.timezone,
    this.isUserEdited = false,
  });

  /// 记录唯一标识。
  final String id;

  /// 业务归属日期，受一天起始时间影响。
  final DateTime recordDate;

  /// 实际入睡时间。
  final DateTime fellAsleepAt;

  /// 实际起床时间。
  final DateTime wokeUpAt;

  /// 数据来源。
  final SleepRecordSource source;

  /// 数据可信度。
  final SleepRecordConfidence confidence;

  /// 记录时区。
  final String timezone;

  /// 是否经过用户手动修正。
  final bool isUserEdited;

  /// 计算当前记录相对于目标时间的偏移分钟数。
  int delayMinutes(GoalSchedule schedule) {
    final target = schedule.bedtimeFor(recordDate);
    return fellAsleepAt.difference(target).inMinutes;
  }

  /// 判断当前记录是否仍在达标范围内。
  bool isWithinSchedule(GoalSchedule schedule) {
    return delayMinutes(schedule) <= schedule.lateThresholdMinutes;
  }
}
