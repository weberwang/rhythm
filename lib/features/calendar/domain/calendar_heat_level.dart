/// 表示日历热力图的颜色等级，统一约束页面和规则层语义。
enum CalendarHeatLevel {
  /// 当天没有可展示记录。
  noRecord,

  /// 与目标时间偏差仍在阈值内。
  onTarget,

  /// 略晚于目标时间，但还未达到明显晚睡阈值。
  slightlyLate,

  /// 已超过明显晚睡阈值。
  late,

  /// 与目标时间严重偏离，需要高强调提示。
  severelyLate,
}
