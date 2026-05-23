import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/onboarding/application/onboarding_flow_controller.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/auth_entry_step.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/health_permission_step.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_welcome_step.dart';

/// 承载三步首次引导流的页面入口，统一管理步骤切换和最终路由跳转。
class OnboardingFlowPage extends HookConsumerWidget {
  /// 创建首次引导流页面实例。
  const OnboardingFlowPage({super.key});

  /// 根据当前流程状态渲染步骤页，并在权限步骤完成时推进业务路由。
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingFlowControllerProvider);
    final healthPermissionAction = useValueChanged(
      state.draft.healthPermissionAction,
      (_, __) => state.draft.healthPermissionAction,
    );

    useEffect(() {
      if (healthPermissionAction == null ||
          healthPermissionAction == OnboardingHealthPermissionAction.none) {
        return null;
      }

      // 当前任务只要求把权限步骤统一导向目标设置入口，真实授权将在后续任务接入。
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.go(onboardingGoalSetupPath);
        }
      });
      return null;
    }, [healthPermissionAction, context]);

    final controller = ref.read(onboardingFlowControllerProvider.notifier);

    switch (state.step) {
      case OnboardingFlowStep.welcome:
        return OnboardingWelcomeStep(
          onContinue: controller.continueFromWelcome,
        );
      case OnboardingFlowStep.authEntry:
        return AuthEntryStep(
          onSelectAuthOption: controller.selectAuthOption,
        );
      case OnboardingFlowStep.healthPermission:
        return HealthPermissionStep(
          selectedAuthOption: state.draft.authOption,
          onAuthorize: controller.authorizeHealthPermission,
          onSkip: controller.skipHealthPermission,
        );
    }
  }
}
