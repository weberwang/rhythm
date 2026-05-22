import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/onboarding/application/onboarding_flow_controller.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_draft.dart';
import 'package:rhythm/features/onboarding/domain/onboarding_flow_state.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/auth_entry_step.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/health_permission_step.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_welcome_step.dart';

/// 承载三步首次引导流的页面入口，统一管理步骤切换和最终路由跳转。
class OnboardingFlowPage extends StatefulWidget {
  /// 创建首次引导流页面实例。
  const OnboardingFlowPage({super.key});

  /// 创建页面状态对象。
  @override
  State<OnboardingFlowPage> createState() => _OnboardingFlowPageState();
}

/// 管理首次引导页面的局部流程状态，避免把临时导流逻辑扩散到全局状态层。
class _OnboardingFlowPageState extends State<OnboardingFlowPage> {
  late final OnboardingFlowController _controller;

  /// 初始化流程控制器并监听步骤变化。
  @override
  void initState() {
    super.initState();
    _controller = OnboardingFlowController()..addListener(_handleFlowChanged);
  }

  /// 释放控制器监听，避免页面销毁后仍持有回调。
  @override
  void dispose() {
    _controller
      ..removeListener(_handleFlowChanged)
      ..dispose();
    super.dispose();
  }

  /// 根据当前草稿结果决定是否跳转到下一个业务路由。
  void _handleFlowChanged() {
    final action = _controller.state.draft.healthPermissionAction;
    if (action == OnboardingHealthPermissionAction.none || !mounted) {
      return;
    }

    // 当前任务只要求把权限步骤统一导向目标设置入口，真实授权将在后续任务接入。
    context.go(onboardingGoalSetupPath);
  }

  /// 根据当前步骤渲染对应页面内容。
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        switch (_controller.state.currentStep) {
          case OnboardingFlowStep.welcome:
            return OnboardingWelcomeStep(
              onContinue: _controller.continueFromWelcome,
            );
          case OnboardingFlowStep.authEntry:
            return AuthEntryStep(
              onSelectAuthOption: _controller.selectAuthOption,
            );
          case OnboardingFlowStep.healthPermission:
            return HealthPermissionStep(
              selectedAuthOption: _controller.state.draft.authOption,
              onAuthorize: _controller.authorizeHealthPermission,
              onSkip: _controller.skipHealthPermission,
            );
        }
      },
    );
  }
}
