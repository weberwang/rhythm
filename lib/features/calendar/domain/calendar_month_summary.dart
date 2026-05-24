import 'calendar_day_summary.dart';

/// 表示一个月日历反馈所需的聚合结果。
class CalendarMonthSummary {
  /// 创建月份摘要实例。
  const CalendarMonthSummary({
    required this.month,
    required this.days,
    required this.onTargetDays,
    required this.recordedDays,
    required this.latestLateDay,
  });

  /// 当前月份的任意一天，统一用月初表达。
  final DateTime month;

  /// 当月所有日摘要。
  final List<CalendarDaySummary> days;

  /// 达标天数。
  final int onTargetDays;

  /// 有效记录天数。
  final int recordedDays;

  /// 最近一次晚睡的日摘要；若无晚睡则为空。
  final CalendarDaySummary? latestLateDay;
}
