import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/core/presentation/widgets/secondary_page_header.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/notifications/application/bedtime_reminder_scheduler.dart';
import 'package:rhythm/features/notifications/application/reminder_settings_controller.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import 'widgets/reminder_strategy_form_section.dart';

/// 展示阶段八的提醒设置页，复用现有提醒策略表单并在保存时触发重新调度。
class NotificationSettingsPage extends HookConsumerWidget {
  /// 创建提醒设置页。
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SecondaryPageHeader(
                title: l10n.notificationSettingsPageTitle,
                fallbackLocation: RhythmTab.profile.path,
                titleStyle: textTheme.headlineSmall?.copyWith(
                  fontFamily: 'Funnel Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.notificationSettingsPageDescription,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const ReminderStrategyFormSection(),
                      const SizedBox(height: 12),
                      _LeadHintCard(
                        title: l10n.notificationSettingsLeadTitle,
                        chipLabels: [
                          l10n.goalScheduleMinutesValue(30),
                          l10n.goalScheduleMinutesValue(45),
                          l10n.goalScheduleMinutesValue(60),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              RhythmPrimaryButton(
                label: l10n.notificationSettingsSaveButton,
                onPressed: () async {
                  final settings = ref.read(reminderSettingsControllerProvider);
                  final goalSettings = await ref.read(
                    savedGoalScheduleSettingsProvider.future,
                  );
                  final now = ref.read(timeContextProvider).now;
                  await ref
                      .read(bedtimeReminderSchedulerProvider)
                      .scheduleForCurrentSettings(
                        settings: settings,
                        goalSettings: goalSettings,
                        now: now,
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 渲染提醒设置页的提前量提示卡，保持设计稿中的轻量提示区块。
class _LeadHintCard extends StatelessWidget {
  /// 创建提前量提示卡。
  const _LeadHintCard({required this.title, required this.chipLabels});

  /// 提示卡标题。
  final String title;

  /// 提前量标签列表。
  final List<String> chipLabels;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4E8CF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (var index = 0; index < chipLabels.length; index++)
                _LeadChip(text: chipLabels[index], highlighted: index == 1),
            ],
          ),
        ],
      ),
    );
  }
}

/// 渲染提前量选项说明标签，保留提醒页的轻量选择感。
class _LeadChip extends StatelessWidget {
  /// 创建提前量提示标签。
  const _LeadChip({required this.text, this.highlighted = false});

  /// 标签文案。
  final String text;

  /// 是否使用强调样式。
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: highlighted ? const Color(0xFF1B3A28) : const Color(0xFFF9FBF6),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: highlighted ? Colors.white : const Color(0xFF1B3A28),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
