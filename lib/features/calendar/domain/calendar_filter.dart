/// 表示日历页当前应用的筛选条件。
class CalendarFilter {
  /// 创建筛选条件实例。
  const CalendarFilter({
    this.onlyRecordedDays = false,
    this.lateOnly = false,
  });

  /// 是否只展示有有效记录的日期。
  final bool onlyRecordedDays;

  /// 是否只展示晚睡日期。
  final bool lateOnly;
}
