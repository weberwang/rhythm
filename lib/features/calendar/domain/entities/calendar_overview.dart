import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../sleep_data_core/domain/entities/sleep_record.dart';

part 'calendar_overview.freezed.dart';

/// 标记 calendar 月视图当前是正常展示还是需要优先解释无记录状态。
enum CalendarOverviewState {
  /// 当前月份已有可解释记录，页面应展示热力图和详情入口。
  ready,

  /// 当前月份尚无记录，页面应保留月视图骨架并解释待补录语义。
  noData,
}

/// 统一约束日历页可切换的筛选模式，避免显示层自行拼装业务状态。
enum CalendarFilterMode {
  /// 显示当前月份全部已知记录。
  all,

  /// 只突出明显偏离目标的晚睡记录。
  delayed,

  /// 只突出被手动修正过的记录。
  adjusted,

  /// 更深历史与原因分布属于后续洞察能力，这里只承接锁定态。
  lockedInsights,
}

/// 标记当前筛选是否允许直接展示全部历史能力。
enum CalendarHistoryAccessState {
  /// 当前筛选可以直接消费现有月视图数据。
  available,

  /// 当前筛选命中了升级边界，应显示锁定说明但保留热力图主体。
  locked,
}

/// 统一映射热力图的视觉语义，保持“相对目标偏移”优先于原始数字。
enum CalendarDayVisualState {
  /// 当天没有可用记录，仅保留弱化占位。
  noData,

  /// 当天记录可信且基本准点。
  onTarget,

  /// 当天记录显示轻微偏移，但仍不是严重失控。
  slightDelay,

  /// 当天记录显示明显偏移，需要更强提醒。
  majorDelay,

  /// 当天记录仍属部分样本，页面要保留谨慎提示。
  partial,
}

/// 月度摘要承接 calendar 首屏需要的统计锚点，避免页面层重复计数。
@freezed
abstract class CalendarMonthlySummary with _$CalendarMonthlySummary {
  /// 创建月度摘要。
  const factory CalendarMonthlySummary({
    required int recordedNights,
    required int onTargetNights,
    required int delayedNights,
    required int adjustedNights,
    required int partialNights,
  }) = _CalendarMonthlySummary;
}

/// 单日详情快照承接 bottom sheet 所需的结构化数据。
@freezed
abstract class CalendarDayDetail with _$CalendarDayDetail {
  /// 创建单日详情快照。
  const factory CalendarDayDetail({
    required DateTime sleepDate,
    required int bedtimeMinutes,
    required int wakeTimeMinutes,
    required int delayMinutes,
    required int sleepDurationMinutes,
    required SleepRecordSource source,
    required SleepRecordConfidence confidence,
    required bool isManuallyAdjusted,
    required String? note,
  }) = _CalendarDayDetail;
}

/// 单日热力图格子既承接视觉状态，也承接点击后的详情数据。
@freezed
abstract class CalendarDayCell with _$CalendarDayCell {
  /// 创建单日格子快照。
  const factory CalendarDayCell({
    required DateTime date,
    required int dayOfMonth,
    required bool hasRecord,
    required CalendarDayVisualState visualState,
    CalendarDayDetail? detail,
  }) = _CalendarDayCell;
}

/// Calendar 聚合结果是页面唯一上游输入，确保显示层只负责结构与交互。
@freezed
abstract class CalendarOverview with _$CalendarOverview {
  /// 创建 calendar 聚合结果。
  const factory CalendarOverview({
    required DateTime month,
    required CalendarOverviewState state,
    required CalendarFilterMode selectedFilter,
    required CalendarHistoryAccessState accessState,
    required CalendarMonthlySummary summary,
    required List<CalendarDayCell> days,
  }) = _CalendarOverview;
}
