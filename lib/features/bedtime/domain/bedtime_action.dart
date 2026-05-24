/// 定义睡前页可展示的轻量动作类型，避免展示层硬编码文案和埋点名。
enum BedtimeActionType {
  /// 先把环境收暗，降低继续拖延的刺激。
  dimLights,

  /// 先放下手机，减少继续停留在高刺激内容里的概率。
  putPhoneAway,

  /// 给自己一个明确的短收尾窗口，而不是无限拖延。
  tenMinuteWrapUp,

  /// 接受今晚会偏晚，但仍然尽快结束今天。
  closeTonight,

  /// 为明早留一个补救动作，降低“今晚已经坏掉”的失控感。
  planRecoveryTomorrow,
}

/// 承载睡前模式中的单条动作建议。
class BedtimeAction {
  /// 创建动作建议实例。
  const BedtimeAction({
    required this.type,
    required this.analyticsName,
    required this.priority,
  });

  /// 动作建议类型。
  final BedtimeActionType type;

  /// 埋点使用的稳定动作名。
  final String analyticsName;

  /// 建议优先级，数值越小越优先。
  final int priority;
}
