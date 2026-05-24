/// App 内部埋点事件名，集中约束避免页面散落字符串。
enum AnalyticsEventName {
  /// 用户进入睡前模式。
  bedtimeModeEntered('bedtime_mode_entered'),

  /// 用户在睡前模式中选择今晚状态。
  bedtimeStatusSelected('bedtime_status_selected'),

  /// 用户点击了睡前建议动作。
  bedtimeActionClicked('bedtime_action_clicked'),

  /// 用户通过通知打开了 App。
  notificationOpened('notification_opened');

  const AnalyticsEventName(this.value);

  /// 上报到分析系统的稳定事件名。
  final String value;
}

/// 承载一次埋点事件，隔离业务层与具体分析 SDK 的耦合。
class AnalyticsEvent {
  /// 创建埋点事件实例。
  const AnalyticsEvent({
    required this.name,
    this.parameters = const <String, Object?>{},
  });

  /// 事件名。
  final AnalyticsEventName name;

  /// 事件参数。
  final Map<String, Object?> parameters;
}
