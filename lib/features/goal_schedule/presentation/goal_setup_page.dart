import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_form_controller.dart';
import 'package:rhythm/features/goal_schedule/presentation/widgets/goal_schedule_form_section.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../app/router/app_router.dart';

/// 承载首次引导中的目标作息设置页，当前以 MVP 摘要表单完成链路闭环。
class GoalSetupPage extends HookConsumerWidget {
  /// 创建目标作息设置页实例。
  const GoalSetupPage({super.key});

  /// 渲染目标作息设置页。
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final form = ref.watch(goalScheduleFormControllerProvider);
    final controller = ref.read(goalScheduleFormControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.goalSetupEyebrow,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.goalSetupPageTitle,
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.goalSetupPageDescription,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                // 目标设置表单后续还会继续扩展，先确保窄视口和测试窗口都能滚动浏览。
                child: SingleChildScrollView(
                  child: GoalScheduleFormSection(form: form),
                ),
              ),
              const SizedBox(height: 24),
              RhythmPrimaryButton(
                label: l10n.goalSetupContinueButton,
                onPressed: () {
                  final success = controller.submit();
                  if (success) {
                    context.go(onboardingReminderSetupPath);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
