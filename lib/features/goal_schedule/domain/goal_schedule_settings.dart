/// 表示已保存的目标作息设置，供今日页、日历和后续统计统一读取。
class GoalScheduleSettings {
  /// 创建目标作息设置实例。
  const GoalScheduleSettings({
    required this.targetBedtimeMinutes,
    required this.targetWakeMinutes,
    required this.lateThresholdMinutes,
    required this.dayStartMinutes,
  });

  /// 目标入睡时间，使用分钟表达，避免页面重复换算。
  final int targetBedtimeMinutes;

  /// 目标起床时间，使用分钟表达。
  final int targetWakeMinutes;

  /// 明显晚睡阈值。
  final int lateThresholdMinutes;

  /// 一天起始时间，供跨午夜统计口径复用。
  final int dayStartMinutes;

  /// 将设置序列化为持久化键值对。
  Map<String, int> toPreferenceMap() {
    return <String, int>{
      'target_bedtime_minutes': targetBedtimeMinutes,
      'target_wake_minutes': targetWakeMinutes,
      'late_threshold_minutes': lateThresholdMinutes,
      'day_start_minutes': dayStartMinutes,
    };
  }

  /// 从持久化值恢复目标作息设置；若任一核心字段缺失，则视为未完成保存。
  static GoalScheduleSettings? fromPreferenceMap(Map<String, Object> map) {
    final bedtime = map['target_bedtime_minutes'];
    final wake = map['target_wake_minutes'];
    final lateThreshold = map['late_threshold_minutes'];
    final dayStart = map['day_start_minutes'];
    if (bedtime is! int ||
        wake is! int ||
        lateThreshold is! int ||
        dayStart is! int ||
        bedtime < 0 ||
        wake < 0 ||
        lateThreshold < 0 ||
        dayStart < 0) {
      return null;
    }

    return GoalScheduleSettings(
      targetBedtimeMinutes: bedtime,
      targetWakeMinutes: wake,
      lateThresholdMinutes: lateThreshold,
      dayStartMinutes: dayStart,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GoalScheduleSettings &&
        targetBedtimeMinutes == other.targetBedtimeMinutes &&
        targetWakeMinutes == other.targetWakeMinutes &&
        lateThresholdMinutes == other.lateThresholdMinutes &&
        dayStartMinutes == other.dayStartMinutes;
  }

  @override
  int get hashCode => Object.hash(
        targetBedtimeMinutes,
        targetWakeMinutes,
        lateThresholdMinutes,
        dayStartMinutes,
      );
}
