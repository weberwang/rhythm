import 'package:freezed_annotation/freezed_annotation.dart';

import 'onboarding_account_connection_result.dart';

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

  /// 小组件价值与平台降级说明页。
  widgetGuide,

  /// 完成交接页。
  completion,
}

/// 定义当前激活阶段的进入方式选择。
enum OnboardingEntryMode {
  /// 先以本地优先模式开始使用。
  localFirst,

  /// 先连接账号入口，再接后续同步语义。
  account,
}

/// 定义当前激活阶段的提醒策略草稿。
enum OnboardingReminderStrategy {
  /// 以轻提醒起步，优先降低心理负担。
  gentle,

  /// 先不打开主动提醒，后续再在设置里补齐。
  none,
}

/// 记录健康权限在引导中的最新结果，避免页面直接保存平台返回值。
enum OnboardingHealthPermissionStatus {
  /// 还没有触发过真实权限请求。
  notRequested,

  /// 用户已同意读取最小健康数据。
  granted,

  /// 用户拒绝或取消了本轮授权。
  denied,

  /// 当前平台或设备环境暂时无法提供该权限能力。
  unavailable,
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
    @Default(OnboardingHealthPermissionStatus.notRequested)
    OnboardingHealthPermissionStatus permissionStatus,
    OnboardingAccountProvider? selectedAccountProvider,
    OnboardingAccountConnectionResult? accountConnection,
  }) = _OnboardingDraft;
}
