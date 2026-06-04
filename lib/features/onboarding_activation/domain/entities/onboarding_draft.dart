import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_draft.freezed.dart';

/// 定义当前激活漏斗所处步骤，确保回流时仍能回到上次未完成位置。
enum OnboardingStep {
  /// 欢迎价值页。
  welcome,

  /// 进入方式选择页。
  entryMode,

  /// 健康权限价值说明页。
  permissionValue,

  /// 目标作息设置页。
  goalSchedule,

  /// 提醒策略选择页。
  reminderStrategy,

  /// 完成交接页。
  completion,
}

/// 定义当前激活阶段的进入方式选择。
enum OnboardingEntryMode {
  /// 先以本地优先模式开始使用。
  localFirst,

  /// 先完成基础设置，稍后再接账号同步。
  syncLater,
}

/// 定义当前激活阶段的提醒策略草稿。
enum OnboardingReminderStrategy {
  /// 以轻提醒起步，优先降低心理负担。
  gentle,

  /// 先不打开主动提醒，后续再在设置里补齐。
  none,
}

/// 聚合 onboarding 最小草稿状态，避免页面层分散保存步骤与作息数据。
@freezed
abstract class OnboardingDraft with _$OnboardingDraft {
  /// 创建激活草稿。
  const factory OnboardingDraft({
    required OnboardingStep step,
    required int bedtimeMinutes,
    required int wakeTimeMinutes,
    OnboardingEntryMode? entryMode,
    OnboardingReminderStrategy? reminderStrategy,
  }) = _OnboardingDraft;
}
