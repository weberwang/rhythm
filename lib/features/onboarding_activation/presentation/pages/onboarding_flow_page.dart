import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../application/providers/onboarding_capability_gateways.dart';
import '../../application/providers/onboarding_flow_controller.dart';
import '../../domain/entities/onboarding_draft.dart';
import '../../../today/presentation/pages/today_page.dart';
import '../widgets/onboarding_flow_sections.dart';

/// 承接真实首启激活漏斗的页面，实现 7 步最小 onboarding 流程。
class OnboardingFlowPage extends HookConsumerWidget {
  /// 创建引导页面。
  const OnboardingFlowPage({super.key});

  /// 引导页面路由路径。
  static const String routePath = '/onboarding';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    final draft = ref.watch(onboardingFlowControllerProvider);
    final widgetGuideAsync = ref.watch(onboardingWidgetGuideProvider);
    final controller = ref.read(onboardingFlowControllerProvider.notifier);
    final isSubmitting = useState(false);

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFCF7), Color(0xFFF4EEE4)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              const Positioned(
                left: -40,
                bottom: 110,
                child: OnboardingSoftOrb(
                  size: 220,
                  color: Color(0x1A8AA8B0),
                ),
              ),
              const Positioned(
                right: -20,
                top: 120,
                child: OnboardingSoftOrb(
                  size: 160,
                  color: Color(0x14E6BBA7),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OnboardingHeaderSection(
                            stepLabel: localization.onboardingStepCounter(
                              _stepNumber(draft.step),
                              7,
                            ),
                            title: _titleForStep(localization, draft.step),
                            body: _bodyForStep(localization, draft.step),
                          ),
                          const SizedBox(height: 28),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 220),
                            child: OnboardingStepSection(
                              key: ValueKey(draft.step),
                              draft: draft,
                              widgetGuideAsync: widgetGuideAsync,
                              onEntryModeSelected: controller.selectEntryMode,
                              onAccountProviderSelected:
                                  controller.selectAccountProvider,
                              onReminderStrategySelected:
                                  controller.selectReminderStrategy,
                              onPickBedtime: () => _pickTime(
                                context: context,
                                initialMinutes: draft.bedtimeMinutes,
                                onSelected: controller.updateBedtimeMinutes,
                              ),
                              onPickWakeTime: () => _pickTime(
                                context: context,
                                initialMinutes: draft.wakeTimeMinutes,
                                onSelected: controller.updateWakeTimeMinutes,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  OnboardingBottomActionBar(
                    showBack: draft.step != OnboardingStep.welcome,
                    backLabel: localization.onboardingBack,
                    primaryLabel: _primaryActionLabel(localization, draft.step),
                    onBack: controller.goToPreviousStep,
                    onPrimary: _canContinue(draft)
                        ? () async {
                            if (isSubmitting.value) {
                              return;
                            }

                            if (draft.step == OnboardingStep.permissionValue) {
                              isSubmitting.value = true;
                              try {
                                await controller.requestHealthPermissionAndContinue();
                              } finally {
                                isSubmitting.value = false;
                              }
                              return;
                            }

                            if (draft.step == OnboardingStep.entryMode &&
                                draft.entryMode == OnboardingEntryMode.account &&
                                draft.selectedAccountProvider != null) {
                              isSubmitting.value = true;
                              try {
                                await controller.authenticateSelectedAccountAndContinue();
                              } finally {
                                isSubmitting.value = false;
                              }
                              return;
                            }

                            if (draft.step != OnboardingStep.completion) {
                              controller.goToNextStep();
                              return;
                            }

                            isSubmitting.value = true;
                            try {
                              await controller.complete();
                              if (context.mounted) {
                                // onboarding 完成后的主路径应固定进入今日页，而不是复用首启前的外部入口意图。
                                context.go(TodayPage.routePath);
                              }
                            } finally {
                              isSubmitting.value = false;
                            }
                          }
                        : null,
                    isLoading: isSubmitting.value,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 将步骤枚举转换成展示序号，保证显示层与状态机始终一致。
  int _stepNumber(OnboardingStep step) {
    return switch (step) {
      OnboardingStep.welcome => 1,
      OnboardingStep.entryMode => 2,
      OnboardingStep.permissionValue => 3,
      OnboardingStep.goalSchedule => 4,
      OnboardingStep.reminderStrategy => 5,
      OnboardingStep.widgetGuide => 6,
      OnboardingStep.completion => 7,
    };
  }

  /// 为每一步返回冻结后的标题文案，避免页面树散落文案选择逻辑。
  String _titleForStep(AppLocalizations localization, OnboardingStep step) {
    return switch (step) {
      OnboardingStep.welcome => localization.onboardingWelcomeTitle,
      OnboardingStep.entryMode => localization.onboardingEntryTitle,
      OnboardingStep.permissionValue => localization.onboardingPermissionTitle,
      OnboardingStep.goalSchedule => localization.onboardingGoalTitle,
      OnboardingStep.reminderStrategy => localization.onboardingReminderTitle,
      OnboardingStep.widgetGuide => localization.onboardingWidgetGuideTitle,
      OnboardingStep.completion => localization.onboardingCompletionTitle,
    };
  }

  /// 为每一步返回说明文案，保持单页单目标叙事。
  String _bodyForStep(AppLocalizations localization, OnboardingStep step) {
    return switch (step) {
      OnboardingStep.welcome => localization.onboardingWelcomeBody,
      OnboardingStep.entryMode => localization.onboardingEntryBody,
      OnboardingStep.permissionValue => localization.onboardingPermissionBody,
      OnboardingStep.goalSchedule => localization.onboardingGoalBody,
      OnboardingStep.reminderStrategy => localization.onboardingReminderBody,
      OnboardingStep.widgetGuide => localization.onboardingWidgetGuideBody,
      OnboardingStep.completion => localization.onboardingCompletionBody,
    };
  }

  /// 根据当前步骤决定主按钮文案，维持线性漏斗的节奏感。
  String _primaryActionLabel(
    AppLocalizations localization,
    OnboardingStep step,
  ) {
    return switch (step) {
      OnboardingStep.welcome => localization.onboardingStartSetup,
      OnboardingStep.entryMode => localization.onboardingContinueSetup,
      OnboardingStep.permissionValue => localization.onboardingContinueSetup,
      OnboardingStep.goalSchedule => localization.onboardingContinueSetup,
      OnboardingStep.reminderStrategy => localization.onboardingContinueSetup,
      OnboardingStep.widgetGuide => localization.onboardingContinueSetup,
      OnboardingStep.completion => localization.onboardingFinishSetup,
    };
  }

  /// 约束每一步的可继续条件，避免关键选择为空时被跳过。
  bool _canContinue(OnboardingDraft draft) {
    return switch (draft.step) {
      OnboardingStep.welcome => true,
      OnboardingStep.entryMode => draft.entryMode != null,
      OnboardingStep.permissionValue => true,
      OnboardingStep.goalSchedule =>
        draft.bedtimeMinutes != draft.wakeTimeMinutes,
      OnboardingStep.reminderStrategy => draft.reminderStrategy != null,
      OnboardingStep.widgetGuide => true,
      OnboardingStep.completion => true,
    };
  }

  /// 统一弹出时间选择器，并把结果转换成共享作息实体使用的分钟偏移。
  Future<void> _pickTime({
    required BuildContext context,
    required int initialMinutes,
    required ValueChanged<int> onSelected,
  }) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: initialMinutes ~/ 60 % 24,
        minute: initialMinutes % 60,
      ),
    );

    if (picked != null) {
      onSelected(picked.hour * 60 + picked.minute);
    }
  }
}
