import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/features/notifications/application/reminder_settings_controller.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示提醒策略表单，确保首次引导中的提醒设置具备真实可交互能力。
class ReminderStrategyFormSection extends HookConsumerWidget {
  /// 创建提醒策略表单组件实例。
  const ReminderStrategyFormSection({super.key});

  /// 渲染提醒策略表单。
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(reminderSettingsControllerProvider);
    final controller = ref.read(reminderSettingsControllerProvider.notifier);

    return Column(
      children: [
        _ReminderSwitchCard(
          title: l10n.reminderSoftReminderTitle,
          description: l10n.reminderSoftReminderDescription,
          enabled: state.softReminderEnabled,
          switchKey: const Key('soft-reminder-switch'),
          onChanged: controller.setSoftReminderEnabled,
        ),
        const SizedBox(height: 12),
        _ReminderSwitchCard(
          title: l10n.reminderTargetReminderTitle,
          description: l10n.reminderTargetReminderDescription,
          enabled: state.targetReminderEnabled,
          switchKey: const Key('target-reminder-switch'),
          onChanged: controller.setTargetReminderEnabled,
        ),
        const SizedBox(height: 12),
        _ReminderSwitchCard(
          title: l10n.reminderWeeklyReportTitle,
          description: l10n.reminderWeeklyReportDescription,
          enabled: state.weeklyReportEnabled,
          switchKey: const Key('weekly-report-switch'),
          onChanged: controller.setWeeklyReportEnabled,
        ),
        const SizedBox(height: 12),
        _ReminderLeadTimeCard(
          title: l10n.reminderLeadTimeTitle,
          description: l10n.reminderLeadTimeValue(state.leadMinutes),
          selectedLeadMinutes: state.leadMinutes,
          onChanged: controller.updateLeadMinutes,
        ),
      ],
    );
  }
}

/// 展示布尔开关型提醒设置，避免页面层重复拼装开关和说明样式。
class _ReminderSwitchCard extends StatelessWidget {
  /// 创建提醒开关卡片实例。
  const _ReminderSwitchCard({
    required this.title,
    required this.description,
    required this.enabled,
    required this.switchKey,
    required this.onChanged,
  });

  /// 卡片标题。
  final String title;

  /// 卡片说明。
  final String description;

  /// 当前策略是否开启。
  final bool enabled;

  /// 测试与状态定位使用的控件键。
  final Key switchKey;

  /// 开关变化后的回调。
  final ValueChanged<bool> onChanged;

  /// 渲染提醒开关卡片。
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(title, style: textTheme.titleMedium),
              ),
              Switch.adaptive(
                key: switchKey,
                value: enabled,
                onChanged: onChanged,
              ),
            ],
          ),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// 展示提醒提前量设置，保持与其他提醒项相同的信息卡片结构。
class _ReminderLeadTimeCard extends StatelessWidget {
  /// 创建提前量设置卡片实例。
  const _ReminderLeadTimeCard({
    required this.title,
    required this.description,
    required this.selectedLeadMinutes,
    required this.onChanged,
  });

  /// 卡片标题。
  final String title;

  /// 当前描述文案。
  final String description;

  /// 当前选中的提前量。
  final int selectedLeadMinutes;

  /// 选择变化后的回调。
  final ValueChanged<int> onChanged;

  /// 渲染提醒提前量设置卡片。
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    const leadOptions = <int>[15, 30, 45, 60, 90];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          DropdownButtonFormField<int>(
            key: const Key('lead-minutes-dropdown'),
            initialValue: selectedLeadMinutes,
            items: leadOptions
                .map(
                  (minutes) => DropdownMenuItem<int>(
                    value: minutes,
                    child: Text('$minutes'),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
