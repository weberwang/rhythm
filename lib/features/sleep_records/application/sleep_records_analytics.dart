/// 阶段三睡眠记录行为埋点事件定义。
class SleepRecordsAnalyticsEvent {
  /// 创建睡眠记录事件实例。
  const SleepRecordsAnalyticsEvent({
    required this.name,
    this.parameters = const <String, Object?>{},
  });

  /// 事件名称。
  final String name;

  /// 事件参数。
  final Map<String, Object?> parameters;
}

/// 阶段三埋点接口，便于后续替换成正式分析平台实现。
abstract class SleepRecordsAnalytics {
  /// 记录一个睡眠记录相关事件。
  Future<void> track(SleepRecordsAnalyticsEvent event);
}

/// 默认空实现，避免当前阶段强绑具体分析 SDK。
class NoopSleepRecordsAnalytics implements SleepRecordsAnalytics {
  /// 创建空埋点实例。
  const NoopSleepRecordsAnalytics();

  @override
  Future<void> track(SleepRecordsAnalyticsEvent event) async {}
}
