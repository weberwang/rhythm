import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/bootstrap/launch_state_repository.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/features/notifications/application/reminder_settings_controller.dart';
import 'package:rhythm/features/notifications/presentation/widgets/reminder_strategy_form_section.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../app/router/app_router.dart';

/// 承载首次引导中的提醒策略设置页，并在完成时关闭首启分发链路。
class ReminderSetupPage extends HookConsumerWidget {
  /// 创建提醒策略设置页实例。
  const ReminderSetupPage({
    super.key,
    required this.launchStateRepository,
  });

  /// 用于标记首次引导已完成的持久化仓储。
  final LaunchStateRepository launchStateRepository;

  /// 标记首次引导完成并跳转到今日页。
  Future<void> _completeOnboarding(BuildContext context) async {
    await launchStateRepository.setOnboardingCompleted(true);
    if (!context.mounted) {
      return;
    }
    context.go(RhythmTab.today.path);
  }

  /// 渲染提醒策略设置页。
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(reminderSettingsControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.reminderSetupEyebrow,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.reminderSetupPageTitle,
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.reminderSetupPageDescription,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                // 提醒策略摘要会随真实通知能力接入继续增长，这里先保证小视口下可滚动。
                child: SingleChildScrollView(
                  child: ReminderStrategyFormSection(state: state),
                ),
              ),
              const SizedBox(height: 24),
              RhythmPrimaryButton(
                label: l10n.reminderSetupCompleteButton,
                onPressed: () => _completeOnboarding(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
