import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/onboarding/application/onboarding_flow_controller.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/health_permission_step.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_welcome_step.dart';

/// 首次引导流页面，按步骤切换欢迎页与增强设置页。
class OnboardingFlowPage extends HookConsumerWidget {
  /// 创建首次引导流页面。
  const OnboardingFlowPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingFlowControllerProvider);
    final controller = ref.read(onboardingFlowControllerProvider.notifier);

    return switch (state.step) {
      OnboardingFlowStep.welcome => OnboardingWelcomeStep(
          onContinue: () => context.go(onboardingGoalSetupPath),
        ),
      OnboardingFlowStep.enhancement => HealthPermissionStep(
          onAuthorize: () {
            controller.authorizeHealthPermission();
            context.go(RhythmTab.today.path);
          },
          onSkip: () {
            controller.skipHealthPermission();
            context.go(RhythmTab.today.path);
          },
        ),
    };
  }
}
