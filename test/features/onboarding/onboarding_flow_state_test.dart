import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_flow_state.dart';

/// 验证首次引导流程状态使用值语义，便于控制器稳定比较与复制。
void main() {
  test('相同字段值的流程状态应视为同一状态', () {
    final first = OnboardingFlowState(
      currentStep: OnboardingFlowStep.authEntry,
      draft: const OnboardingDraft(authOption: OnboardingAuthOption.apple),
    );
    final second = OnboardingFlowState(
      currentStep: OnboardingFlowStep.authEntry,
      draft: const OnboardingDraft(authOption: OnboardingAuthOption.apple),
    );

    expect(first, equals(second));
  });
}
