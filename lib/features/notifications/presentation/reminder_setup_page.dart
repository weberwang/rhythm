import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/bootstrap/launch_state_repository.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/notifications/application/bedtime_reminder_scheduler.dart';
import 'package:rhythm/features/notifications/application/reminder_settings_controller.dart';
import 'package:rhythm/features/notifications/presentation/widgets/reminder_strategy_form_section.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../app/router/app_router.dart';

/// 提醒策略设置页，完成首启闭环并进入今日页。
class ReminderSetupPage extends HookConsumerWidget {
  /// 创建提醒策略设置页。
  const ReminderSetupPage({
    super.key,
    required this.launchStateRepository,
  });

  /// 首启状态仓储。
  final LaunchStateRepository launchStateRepository;

  Future<void> _completeOnboarding(BuildContext context, WidgetRef ref) async {
    final settings = ref.read(reminderSettingsControllerProvider);
    final goalSettings = await ref.read(savedGoalScheduleSettingsProvider.future);
    final timeContext = ref.read(timeContextProvider);
    await ref
        .read(bedtimeReminderSchedulerProvider)
        .scheduleForCurrentSettings(
          settings: settings,
          goalSettings: goalSettings,
          now: timeContext.now,
        );
    await launchStateRepository.markOnboardingCompleted();
    if (context.mounted) {
      context.go(RhythmTab.today.path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 62),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HeaderPill(text: l10n.reminderSetupEyebrow),
                      const SizedBox(height: 8),
                      Text(
                        l10n.reminderSetupPageTitle,
                        style: textTheme.headlineMedium?.copyWith(
                          fontFamily: 'Funnel Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.08,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.reminderSetupPageDescription,
                        style: textTheme.bodyLarge?.copyWith(
                          fontFamily: 'Geist',
                          color: colorScheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const ReminderStrategyFormSection(),
                      const SizedBox(height: 12),
                      const _LeadTimeHintCard(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              RhythmPrimaryButton(
                label: l10n.reminderSetupCompleteButton,
                onPressed: () => _completeOnboarding(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 顶部胶囊。
class _HeaderPill extends StatelessWidget {
  /// 创建胶囊。
  const _HeaderPill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        text,
        style: textTheme.labelLarge?.copyWith(
          color: colorScheme.primary,
          fontFamily: 'Geist',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// 提前量建议卡。
class _LeadTimeHintCard extends StatelessWidget {
  const _LeadTimeHintCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).reminderLeadHintTitle,
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Chip(text: AppLocalizations.of(context).reminderLeadHintEarly),
              _Chip(
                text: AppLocalizations.of(context).reminderLeadHintRecommended,
              ),
              _Chip(text: AppLocalizations.of(context).reminderLeadHintMinimal),
            ],
          ),
        ],
      ),
    );
  }
}

/// 标签。
class _Chip extends StatelessWidget {
  const _Chip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        text,
        style: textTheme.labelLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}
