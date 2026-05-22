import 'package:flutter/foundation.dart';

import '../domain/onboarding_draft.dart';
import '../domain/onboarding_flow_state.dart';

/// 管理首次引导三步状态推进和草稿收集。
class OnboardingFlowController extends ChangeNotifier {
  /// 创建首次引导流程控制器实例。
  OnboardingFlowController();

  OnboardingFlowState _state = const OnboardingFlowState();

  /// 当前首次引导聚合状态。
  OnboardingFlowState get state => _state;

  /// 从欢迎页推进到登录选择页。
  void continueFromWelcome() {
    _state = _state.copyWith(currentStep: OnboardingFlowStep.authEntry);
    notifyListeners();
  }

  /// 记录登录选择并推进到健康权限说明页。
  void selectAuthOption(OnboardingAuthOption option) {
    _state = _state.copyWith(
      currentStep: OnboardingFlowStep.healthPermission,
      draft: _state.draft.copyWith(authOption: option),
    );
    notifyListeners();
  }

  /// 记录用户点击授权入口，供外层统一处理跳转。
  void authorizeHealthPermission() {
    _state = _state.copyWith(
      draft: _state.draft.copyWith(
        healthPermissionAction: OnboardingHealthPermissionAction.authorize,
      ),
    );
    notifyListeners();
  }

  /// 记录用户暂时跳过健康权限，供外层统一处理跳转。
  void skipHealthPermission() {
    _state = _state.copyWith(
      draft: _state.draft.copyWith(
        healthPermissionAction: OnboardingHealthPermissionAction.skip,
      ),
    );
    notifyListeners();
  }
}
