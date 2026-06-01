import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/onboarding_draft.dart';

part 'onboarding_flow_controller.freezed.dart';
part 'onboarding_flow_controller.g.dart';

/// 定义首次引导的固定步骤，避免页面层依赖裸索引导致语义不清。
enum OnboardingFlowStep {
  /// 欢迎用户进入产品价值说明。
  welcome,

  /// 说明健康权限价值。
  enhancement,
}

/// 承载首次引导的步骤与草稿快照，保持流程状态具备值语义。
@freezed
abstract class OnboardingFlowState with _$OnboardingFlowState {
  /// 创建首次引导流程状态实例。
  const factory OnboardingFlowState({
    @Default(OnboardingFlowStep.welcome) OnboardingFlowStep step,
    @Default(OnboardingDraft()) OnboardingDraft draft,
  }) = _OnboardingFlowState;
}

/// 管理首次引导精简链路的步骤推进和草稿收集。
@riverpod
class OnboardingFlowController extends _$OnboardingFlowController {
  /// 初始化首次引导流程状态。
  @override
  OnboardingFlowState build() {
    return const OnboardingFlowState();
  }

  /// 从欢迎页直接推进到后续目标设置页。
  void continueFromWelcome() {
    state = state.copyWith(
      step: OnboardingFlowStep.enhancement,
    );
  }

  /// 记录用户点击授权入口，供外层统一处理跳转。
  void authorizeHealthPermission() {
    state = state.copyWith(
      draft: state.draft.copyWith(
        healthPermissionAction: OnboardingHealthPermissionAction.authorize,
      ),
    );
  }

  /// 记录用户暂时跳过健康权限，供外层统一处理跳转。
  void skipHealthPermission() {
    state = state.copyWith(
      draft: state.draft.copyWith(
        healthPermissionAction: OnboardingHealthPermissionAction.skip,
      ),
    );
  }
}
