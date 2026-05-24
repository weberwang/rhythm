/// 表示洞察页和详情页共用的一周洞察周报。
class WeeklyReport {
  /// 创建周报实体。
  const WeeklyReport({
    required this.startDate,
    required this.endDate,
    required this.days,
    required this.summary,
    required this.reasonDistribution,
    required this.recommendations,
    this.isLocked = false,
  });

  /// 周报起始业务归属日。
  final DateTime startDate;

  /// 周报结束业务归属日。
  final DateTime endDate;

  /// 最近 7 天快照，缺失记录的日期也保留占位。
  final List<WeeklyReportDaySnapshot> days;

  /// 周报摘要信息。
  final WeeklyReportSummary summary;

  /// 本周原因分布。
  final List<ReasonDistributionItem> reasonDistribution;

  /// 下周建议列表。
  final List<WeeklyRecommendation> recommendations;

  /// 是否属于免费范围外的历史周报。
  final bool isLocked;
}

/// 表示周报中的单日快照，用于详情页和历史页摘要复用。
class WeeklyReportDaySnapshot {
  /// 创建单日快照。
  const WeeklyReportDaySnapshot({
    required this.date,
    required this.sleepOffsetMinutes,
    required this.qualified,
    required this.tags,
  });

  /// 业务归属日。
  final DateTime date;

  /// 相对目标入睡时间的偏差；为空代表当天无有效记录。
  final int? sleepOffsetMinutes;

  /// 当天是否达标。
  final bool qualified;

  /// 当天已确认的原因标签。
  final List<String> tags;
}

/// 表示一周周报顶部摘要，避免显示层重复拼装口径文案。
class WeeklyReportSummary {
  /// 创建周报摘要。
  const WeeklyReportSummary({
    required this.qualifiedDayCount,
    required this.totalRecordedDays,
    required this.onTrackRate,
    required this.stabilityScore,
    required this.latestLateDayWeekday,
    required this.latestLateSleepMinutesOfDay,
    required this.latestLateOffsetMinutes,
    this.primaryReasonLabel,
  });

  /// 达标天数。
  final int qualifiedDayCount;

  /// 有效记录天数。
  final int totalRecordedDays;

  /// 达标率，取整数百分比。
  final int onTrackRate;

  /// 稳定度分数，供首页摘要直接展示。
  final int stabilityScore;

  /// 最晚入睡日是周几，使用 `DateTime.weekday` 口径。
  final int latestLateDayWeekday;

  /// 最晚入睡时刻对应的分钟值，供显示层按语言格式化。
  final int latestLateSleepMinutesOfDay;

  /// 最晚入睡偏差分钟数。
  final int latestLateOffsetMinutes;

  /// 本周最高频的拖延原因标签；为空代表没有确认原因。
  final String? primaryReasonLabel;
}

/// 定义周报建议类型，供显示层映射为本地化文案。
enum WeeklyRecommendationType {
  /// 睡前最后一项工作需要更早收尾。
  finishWorkEarlier,

  /// 晚睡高风险日优先开启柔性提醒。
  enableSoftReminder,

  /// 连续偏晚时直接回到恢复计划。
  openRecoveryPlan,
}

/// 表示一条结构化周报建议，避免领域层直接输出展示文案。
class WeeklyRecommendation {
  /// 创建结构化建议。
  const WeeklyRecommendation({
    required this.type,
    this.relatedLabel,
  });

  /// 建议类型。
  final WeeklyRecommendationType type;

  /// 建议所依赖的业务标签，例如主要拖延原因。
  final String? relatedLabel;
}

/// 表示本周主要晚睡原因分布项。
class ReasonDistributionItem {
  /// 创建原因分布项。
  const ReasonDistributionItem({
    required this.label,
    required this.count,
    required this.ratio,
  });

  /// 原因名称。
  final String label;

  /// 出现次数。
  final int count;

  /// 占比，范围 0 到 1。
  final double ratio;
}
