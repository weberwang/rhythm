import 'package:flutter/material.dart';
import 'package:rhythm/features/notifications/domain/reminder_settings_state.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示提醒策略摘要，避免首次引导阶段直接引入复杂交互控件。
class ReminderStrategyFormSection extends StatelessWidget {
  /// 创建提醒策略摘要组件实例。
  const ReminderStrategyFormSection({
    super.key,
    required this.state,
  });

  /// 当前提醒策略状态。
  final ReminderSettingsState state;

  /// 渲染提醒策略摘要。
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        _ReminderCard(
          title: l10n.reminderSoftReminderTitle,
          description: l10n.reminderSoftReminderDescription,
          enabled: state.softReminderEnabled,
        ),
        const SizedBox(height: 12),
        _ReminderCard(
          title: l10n.reminderTargetReminderTitle,
          description: l10n.reminderTargetReminderDescription,
          enabled: state.targetReminderEnabled,
        ),
        const SizedBox(height: 12),
        _ReminderCard(
          title: l10n.reminderWeeklyReportTitle,
          description: l10n.reminderWeeklyReportDescription,
          enabled: state.weeklyReportEnabled,
        ),
        const SizedBox(height: 12),
        _ReminderCard(
          title: l10n.reminderLeadTimeTitle,
          description: l10n.reminderLeadTimeValue(state.leadMinutes),
          enabled: true,
        ),
      ],
    );
  }
}

/// 展示单条提醒策略摘要，便于保持信息密度与扫描效率。
class _ReminderCard extends StatelessWidget {
  /// 创建提醒摘要卡片实例。
  const _ReminderCard({
    required this.title,
    required this.description,
    required this.enabled,
  });

  /// 卡片标题。
  final String title;

  /// 卡片说明。
  final String description;

  /// 当前策略是否开启。
  final bool enabled;

  /// 渲染提醒摘要卡片。
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            enabled ? Icons.notifications_active_outlined : Icons.notifications_off_outlined,
            color: enabled ? colorScheme.primary : colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
