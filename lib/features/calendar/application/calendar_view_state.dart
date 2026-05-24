import 'package:rhythm/features/calendar/domain/calendar_filter.dart';
import 'package:rhythm/features/calendar/domain/calendar_month_summary.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag.dart';

/// 表示日历页的首屏状态，统一页面空态与可渲染月份摘要。
enum CalendarViewStatus {
  /// 缺少目标作息，无法计算热力规则。
  goalMissing,

  /// 已准备好月份摘要，可包含无记录日期。
  ready,
}

/// 承载日历页首屏所需的最小可渲染状态。
class CalendarViewState {
  /// 创建日历页状态实例。
  const CalendarViewState({
    required this.status,
    this.monthSummary,
    this.availableTags = const <SleepDelayTag>[],
    this.savedTagsByDate = const <DateTime, List<String>>{},
    this.activeFilter = const CalendarFilter(),
  });

  /// 页面主状态。
  final CalendarViewStatus status;

  /// 当前月份摘要；仅在 ready 状态下存在。
  final CalendarMonthSummary? monthSummary;

  /// 默认可选标签，供后续弹层复用。
  final List<SleepDelayTag> availableTags;

  /// 当前月份内已保存的标签集合，按归属日索引。
  final Map<DateTime, List<String>> savedTagsByDate;

  /// 当前已应用的筛选条件。
  final CalendarFilter activeFilter;
}
