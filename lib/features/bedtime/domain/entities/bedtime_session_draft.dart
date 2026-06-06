import 'package:freezed_annotation/freezed_annotation.dart';

part 'bedtime_session_draft.freezed.dart';

/// 描述当前睡前会话的大状态，确保页面始终围绕单任务焦点表达。
enum BedtimeSessionState {
  /// 当前距离目标还有时间，页面应优先给出收尾动作。
  beforeTarget,

  /// 当前已经明显晚于目标，页面应优先给出止损式恢复提示。
  likelyDelay,

  /// 当前用户已经执行当晚动作，页面应给出简短完成态。
  sessionCompleted,
}

/// 描述用户对今晚状态的三态判断，严格保持不超过三个选项。
enum BedtimeStatusChoice {
  /// 用户已经准备睡觉，只需要开始最小收尾动作。
  readyToSleep,

  /// 用户还需要一点收尾时间，页面应帮助其快速降刺激。
  needWindDown,

  /// 用户预判今晚会明显晚睡，页面应转入止损建议。
  likelyDelay,
}

/// 描述当前页面该给出的单一行动类型，避免应用层直接拼展示文案。
enum BedtimeActionKind {
  /// 开始最小收尾动作。
  startWindDown,

  /// 先把手机等刺激源放远。
  putPhoneAway,

  /// 优先保护明早起床时间。
  protectWakeUp,

  /// 当前动作已经完成，页面进入完成态。
  completed,
}

/// 描述当前入口来源，供页面展示轻量上下文。
enum BedtimeEntrySource {
  /// 从 today 常规进入。
  appOpen,

  /// 从通知进入。
  notification,

  /// 从小组件进入。
  homeWidget,
}

/// 定义睡前页最小会话草稿，供显示层一次消费。
@freezed
abstract class BedtimeSessionDraft with _$BedtimeSessionDraft {
  /// 创建睡前会话草稿。
  const factory BedtimeSessionDraft({
    required BedtimeSessionState currentState,
    required String targetBedtimeLabel,
    required String wakeTimeLabel,
    required int minutesToTarget,
    required BedtimeEntrySource entrySource,
    required BedtimeStatusChoice? selectedChoice,
    required BedtimeActionKind actionKind,
    required bool reminderEnabled,
  }) = _BedtimeSessionDraft;
}
