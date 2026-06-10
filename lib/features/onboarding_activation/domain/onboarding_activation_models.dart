import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rhythm/core/permissions/app_permission_models.dart';

part 'onboarding_activation_models.freezed.dart';

/// 首次激活步骤。
enum OnboardingActivationStep {
  /// 欢迎与进入方式。
  welcome,

  /// 健康权限选择。
  healthAccess,

  /// 目标睡眠窗口设置。
  sleepWindow,

  /// 提醒策略设置。
  reminders,
}

/// 首次激活进入方式。
enum OnboardingEntryMode {
  /// 匿名本地继续。
  anonymous,

  /// 稍后绑定账号。
  connectLater,
}

/// 健康数据路径选择。
enum OnboardingHealthChoice {
  /// 允许稍后接入健康数据。
  connectHealth,

  /// 先走手动路径。
  manualOnly,
}

/// 提醒策略选择。
enum OnboardingReminderChoice {
  /// 开启提醒。
  enabled,

  /// 暂时关闭提醒。
  disabled,
}

/// 首次激活状态。
@freezed
abstract class OnboardingActivationState with _$OnboardingActivationState {
  /// 创建首次激活状态。
  const factory OnboardingActivationState({
    @Default(OnboardingActivationStep.welcome)
    OnboardingActivationStep currentStep,
    OnboardingEntryMode? entryMode,
    OnboardingHealthChoice? healthChoice,
    @Default(23) int bedtimeHour,
    @Default(7) int wakeHour,
    @Default(OnboardingReminderChoice.enabled)
    OnboardingReminderChoice reminderChoice,
    @Default(30) int reminderLeadMinutes,
    @Default(AppPermissionStatus.unknown)
    AppPermissionStatus healthPermissionStatus,
    @Default(false) bool reminderScheduled,
    @Default(false) bool isSubmitting,
    String? submissionErrorMessage,
  }) = _OnboardingActivationState;
}
