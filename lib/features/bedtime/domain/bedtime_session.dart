/// 睡前模式入口来源，后续用于分析用户从哪里进入干预流程。
enum BedtimeEntryPoint { notification, widget, todayCard, bottomTab }

/// 睡前状态，用来区分今晚的主观准备程度。
enum BedtimeStatus { readyToSleep, needMoreTime, likelyLate }

/// 睡前会话实体，记录某次睡前干预的行为上下文。
class BedtimeSession {
  const BedtimeSession({
    required this.id,
    required this.startedAt,
    required this.entryPoint,
    required this.minutesToTarget,
    required this.status,
    this.completedAt,
  });

  /// 会话唯一标识。
  final String id;

  /// 进入睡前模式的时间。
  final DateTime startedAt;

  /// 进入睡前模式的触发入口。
  final BedtimeEntryPoint entryPoint;

  /// 距离目标入睡时间的分钟差。
  final int minutesToTarget;

  /// 用户在睡前模式中选择的状态。
  final BedtimeStatus status;

  /// 会话完成时间，便于后续统计完成率。
  final DateTime? completedAt;
}
