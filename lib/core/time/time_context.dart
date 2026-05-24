/// 承载当前设备时间上下文，给同步、补录和统计统一提供“现在”和时区信息。
class TimeContext {
  /// 创建时间上下文实例。
  const TimeContext({
    required this.now,
    required this.timezoneName,
  });

  /// 当前时间。
  final DateTime now;

  /// 当前系统时区名称。
  final String timezoneName;
}
