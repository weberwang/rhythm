import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/bootstrap/launch_state_repository.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/notifications/application/bedtime_reminder_scheduler.dart';
import 'package:rhythm/features/notifications/application/reminder_settings_controller.dart';
import 'package:rhythm/features/notifications/domain/reminder_settings_state.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';
import 'package:rhythm/shared/presentation/widgets/composites/rhythm_onboarding_action_card.dart';

import '../../../app/router/app_router.dart';

/// 提醒策略设置页，首启阶段只让用户先选一种不打扰的提醒方式。
class ReminderSetupPage extends HookConsumerWidget {
  /// 创建提醒策略设置页。
  const ReminderSetupPage({super.key, required this.launchStateRepository});

  /// 首启状态仓储。
  final LaunchStateRepository launchStateRepository;

  Future<void> _completeOnboarding(BuildContext context, WidgetRef ref) async {
    final notificationGateway = ref.read(localNotificationGatewayProvider);
    final hasPermission = await notificationGateway.isPermissionGranted();
    if (!hasPermission) {
      await notificationGateway.requestPermission();
      ref.invalidate(notificationPermissionGrantedProvider);
    }
    final settings = ref.read(reminderSettingsControllerProvider);
    final goalSettings = await ref.read(
      savedGoalScheduleSettingsProvider.future,
    );
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
      context.go(onboardingWidgetGuidePath);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final state = ref.watch(reminderSettingsControllerProvider);
    final controller = ref.read(reminderSettingsControllerProvider.notifier);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.surface.withValues(alpha: 0.98),
              theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                _ReminderHeroCard(
                  title: l10n.reminderSetupPageTitle,
                  description: l10n.reminderSetupPageDescription,
                ),
                const SizedBox(height: 24),
                _ReminderChoicePanel(
                  title: l10n.reminderSetupPanelTitle,
                  description: l10n.reminderSetupPanelDescription,
                  selectedMode: _resolveMode(state),
                  onSelectMode: (mode) =>
                      _applyMode(mode: mode, controller: controller),
                ),
                const SizedBox(height: 24),
                RhythmOnboardingActionCard(
                  primaryLabel: l10n.reminderSetupContinueButton,
                  secondaryLabel: l10n.reminderSetupSecondaryButton,
                  onPrimary: () => _completeOnboarding(context, ref),
                  onSecondary: () => _completeOnboarding(context, ref),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.reminderSetupBottomNote,
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.76,
                    ),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 顶部 Hero 卡，承接提醒设置页的夜色品牌感。
class _ReminderHeroCard extends StatelessWidget {
  const _ReminderHeroCard({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final heroTokens = theme.extension<RhythmHeroThemeExtension>();
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: heroTokens?.gradient,
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color:
              heroTokens?.borderColor ??
              theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.12),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.18),
                  ),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.nightlight_round,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    height: 1.08,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFEEF2FF),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

enum _ReminderMode { soft, standard, off }

_ReminderMode _resolveMode(ReminderSettingsState state) {
  if (!state.softReminderEnabled && !state.targetReminderEnabled) {
    return _ReminderMode.off;
  }
  if (state.targetReminderEnabled) {
    return _ReminderMode.standard;
  }
  return _ReminderMode.soft;
}

void _applyMode({
  required _ReminderMode mode,
  required ReminderSettingsController controller,
}) {
  switch (mode) {
    case _ReminderMode.soft:
      controller.setSoftReminderEnabled(true);
      controller.setTargetReminderEnabled(false);
      controller.setWeeklyReportEnabled(true);
      controller.updateLeadMinutes(45);
      return;
    case _ReminderMode.standard:
      controller.setSoftReminderEnabled(true);
      controller.setTargetReminderEnabled(true);
      controller.setWeeklyReportEnabled(true);
      controller.updateLeadMinutes(30);
      return;
    case _ReminderMode.off:
      controller.setSoftReminderEnabled(false);
      controller.setTargetReminderEnabled(false);
      controller.setWeeklyReportEnabled(true);
      controller.updateLeadMinutes(45);
      return;
  }
}

/// 提醒方式面板，对齐设计稿里的三种首启选择。
class _ReminderChoicePanel extends StatelessWidget {
  const _ReminderChoicePanel({
    required this.title,
    required this.description,
    required this.selectedMode,
    required this.onSelectMode,
  });

  final String title;
  final String description;
  final _ReminderMode selectedMode;
  final ValueChanged<_ReminderMode> onSelectMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final options = <_ReminderOptionData>[
      _ReminderOptionData(
        mode: _ReminderMode.soft,
        title: AppLocalizations.of(context).reminderSetupSoftTitle,
        description: AppLocalizations.of(context).reminderSetupSoftDescription,
        backgroundColor: const Color(0xFFEEF3FF),
        borderColor: const Color(0xFFCCD9F3),
        icon: Icons.notifications_none_rounded,
        key: const Key('reminder-mode-soft'),
      ),
      _ReminderOptionData(
        mode: _ReminderMode.standard,
        title: AppLocalizations.of(context).reminderSetupStandardTitle,
        description: AppLocalizations.of(
          context,
        ).reminderSetupStandardDescription,
        backgroundColor: const Color(0xFFFBFCFD),
        borderColor: const Color(0xFFE0E7F2),
        icon: Icons.notifications_active_outlined,
        key: const Key('reminder-mode-standard'),
      ),
      _ReminderOptionData(
        mode: _ReminderMode.off,
        title: AppLocalizations.of(context).reminderSetupOffTitle,
        description: AppLocalizations.of(context).reminderSetupOffDescription,
        backgroundColor: const Color(0xFFF8F7FB),
        borderColor: const Color(0xFFF0ECF7),
        icon: Icons.notifications_off_outlined,
        key: const Key('reminder-mode-off'),
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.84),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0x80FFFFFF)),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.07),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          for (var index = 0; index < options.length; index++) ...[
            _ReminderOptionCard(
              data: options[index],
              selected: options[index].mode == selectedMode,
              onTap: () => onSelectMode(options[index].mode),
            ),
            if (index != options.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

/// 单个提醒方式卡片。
class _ReminderOptionCard extends StatelessWidget {
  const _ReminderOptionCard({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final _ReminderOptionData data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      key: data.key,
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: data.backgroundColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? const Color(0xFF8FA2D8) : data.borderColor,
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              alignment: Alignment.center,
              child: Icon(data.icon, size: 18, color: const Color(0xFF182033)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF182033),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.description,
                    style: textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF6F7891),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderOptionData {
  const _ReminderOptionData({
    required this.mode,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
    required this.key,
  });

  final _ReminderMode mode;
  final String title;
  final String description;
  final Color backgroundColor;
  final Color borderColor;
  final IconData icon;
  final Key key;
}
