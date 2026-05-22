import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/onboarding/application/onboarding_flow_controller.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_flow_state.dart';

/// 验证首次引导控制器以单一状态对象暴露步骤与草稿，减少页面层手动同步。
void main() {
  test('选择登录方式后聚合状态同时更新步骤与草稿', () {
    final controller = OnboardingFlowController();

    controller.selectAuthOption(OnboardingAuthOption.google);

    expect(controller.state.currentStep, OnboardingFlowStep.healthPermission);
    expect(controller.state.draft.authOption, OnboardingAuthOption.google);
  });
}
