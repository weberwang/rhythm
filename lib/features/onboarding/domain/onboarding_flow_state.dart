import 'package:freezed_annotation/freezed_annotation.dart';

import 'onboarding_draft.dart';

part 'onboarding_flow_state.freezed.dart';

/// 定义首次引导流程的聚合状态，统一承载当前步骤和累计草稿。
@freezed
abstract class OnboardingFlowState with _$OnboardingFlowState {
  /// 创建首次引导流程状态实例。
  const factory OnboardingFlowState({
    @Default(OnboardingFlowStep.welcome) OnboardingFlowStep currentStep,
    @Default(OnboardingDraft()) OnboardingDraft draft,
  }) = _OnboardingFlowState;
}

/// 定义首次引导的固定步骤，避免页面层直接依赖裸索引造成状态含义不清。
enum OnboardingFlowStep {
  /// 欢迎用户进入产品价值说明。
  welcome,

  /// 选择登录方式。
  authEntry,

  /// 说明健康权限价值。
  healthPermission,
}
