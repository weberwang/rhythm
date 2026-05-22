import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';

/// 验证首次引导草稿具备稳定的值语义，便于后续状态比较和持久化扩展。
void main() {
  test('相同字段值的引导草稿应视为同一状态', () {
    final first = OnboardingDraft(
      authOption: OnboardingAuthOption.apple,
      healthPermissionAction: OnboardingHealthPermissionAction.authorize,
    );
    final second = OnboardingDraft(
      authOption: OnboardingAuthOption.apple,
      healthPermissionAction: OnboardingHealthPermissionAction.authorize,
    );

    expect(first, equals(second));
  });
}
