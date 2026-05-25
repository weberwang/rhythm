/// 目标作息实体，统一定义达标判断依赖的全局时间基准。
class GoalSchedule {
  const GoalSchedule({
    required this.id,
    required this.targetBedtimeMinutes,
    required this.targetWakeMinutes,
    required this.lateThresholdMinutes,
    required this.dayStartMinutes,
  });

  /// 目标配置唯一标识。
  final String id;

  /// 目标入睡时间，使用当天 0 点起的分钟数表示。
  final int targetBedtimeMinutes;

  /// 目标起床时间，使用当天 0 点起的分钟数表示。
  final int targetWakeMinutes;

  /// 允许仍视为达标的晚睡阈值。
  final int lateThresholdMinutes;

  /// 一天的起始时间，凌晨前后的记录需要靠这个字段归属到正确日期。
  final int dayStartMinutes;

  /// 根据一天起始时间解析某个时间点所属的记录日期。
  DateTime resolveRecordDate(DateTime moment) {
    final minutes = moment.hour * 60 + moment.minute;
    final normalized = DateTime(moment.year, moment.month, moment.day);
    if (minutes < dayStartMinutes) {
      return normalized.subtract(const Duration(days: 1));
    }
    return normalized;
  }

  /// 计算某条记录对应日期上的目标入睡时间。
  DateTime bedtimeFor(DateTime recordDate) {
    final hours = targetBedtimeMinutes ~/ 60;
    final minutes = targetBedtimeMinutes % 60;
    return DateTime(
      recordDate.year,
      recordDate.month,
      recordDate.day,
      hours,
      minutes,
    );
  }
}
