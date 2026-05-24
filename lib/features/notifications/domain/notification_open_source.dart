/// 定义通知打开来源，避免业务层散落解析 payload 字符串。
enum NotificationOpenSource {
  /// 由柔性提醒打开。
  softReminder,

  /// 由到点提醒打开。
  targetReminder,

  /// 未识别来源。
  unknown,
}
