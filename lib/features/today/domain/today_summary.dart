/// 今日页摘要实体，负责把页面首屏需要的文本信息收敛到领域对象里。
class TodaySummary {
  const TodaySummary({this.latestRecordLabel});

  /// 没有任何记录时的空摘要。
  const TodaySummary.empty() : latestRecordLabel = null;

  /// 最近一条记录的展示文案。
  final String? latestRecordLabel;

  /// 基于时间文本构造页面要展示的记录摘要。
  factory TodaySummary.fromRecordTimes({
    required String fellAsleepLabel,
    required String wokeUpLabel,
  }) {
    return TodaySummary(
      latestRecordLabel: '最近一条记录：$fellAsleepLabel - $wokeUpLabel',
    );
  }
}
