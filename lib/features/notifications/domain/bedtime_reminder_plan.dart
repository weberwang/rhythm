/// 定义睡前提醒类型，区分柔性提醒和到点提醒。
enum BedtimeReminderType {
  /// 目标前的低压力柔性提醒。
  soft,

  /// 到目标时间时的明确收尾提醒。
  targetTime,
}

/// 定义提醒打扰级别，约束阶段五默认走温和提醒。
enum BedtimeReminderInterruptionLevel {
  /// 默认温和提醒。
  gentle,
}

/// 承载单条睡前提醒计划，隔离业务规则与插件参数。
class BedtimeReminderPlan {
  /// 创建提醒计划实例。
  const BedtimeReminderPlan({
    required this.id,
    required this.scheduledAt,
    required this.type,
    required this.titleKey,
    required this.bodyKey,
    required this.payload,
    this.interruptionLevel = BedtimeReminderInterruptionLevel.gentle,
  });

  /// 计划主键。
  final int id;

  /// 实际调度时间。
  final DateTime scheduledAt;

  /// 提醒类型。
  final BedtimeReminderType type;

  /// 标题文案键。
  final String titleKey;

  /// 内容文案键。
  final String bodyKey;

  /// 点击通知后的稳定 payload。
  final String payload;

  /// 提醒打扰级别。
  final BedtimeReminderInterruptionLevel interruptionLevel;
}
