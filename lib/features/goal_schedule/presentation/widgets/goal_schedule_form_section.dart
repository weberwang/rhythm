import 'package:flutter/material.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_form_state.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示目标作息表单的字段分组，保持页面层只负责路由与提交动作。
class GoalScheduleFormSection extends StatelessWidget {
  /// 创建目标作息表单分组组件实例。
  const GoalScheduleFormSection({super.key, required this.form});

  /// 当前表单状态快照。
  final GoalScheduleFormState form;

  /// 渲染目标作息表单摘要。
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FormCard(
          title: l10n.goalScheduleBedtimeLabel,
          value: _formatTime(form.bedtimeHour, form.bedtimeMinute),
          description: l10n.goalScheduleBedtimeDescription,
        ),
        const SizedBox(height: 12),
        _FormCard(
          title: l10n.goalScheduleWakeLabel,
          value: _formatTime(form.wakeHour, form.wakeMinute),
          description: l10n.goalScheduleWakeDescription,
          errorText: form.wakeTimeError == null
              ? null
              : l10n.goalScheduleWakeSameAsBedtimeError,
        ),
        const SizedBox(height: 12),
        _FormCard(
          title: l10n.goalScheduleLateThresholdLabel,
          value: l10n.goalScheduleMinutesValue(form.lateThresholdMinutes),
          description: l10n.goalScheduleLateThresholdDescription,
        ),
        const SizedBox(height: 12),
        _FormCard(
          title: l10n.goalScheduleDayStartLabel,
          value: _formatTime(form.dayStartHour, form.dayStartMinute),
          description: l10n.goalScheduleDayStartDescription,
        ),
      ],
    );
  }

  /// 统一格式化时间文本，避免多个字段各自拼接时分字符串。
  String _formatTime(int hour, int minute) {
    final hourText = hour.toString().padLeft(2, '0');
    final minuteText = minute.toString().padLeft(2, '0');
    return '$hourText:$minuteText';
  }
}

/// 承载单个目标作息字段的卡片展示。
class _FormCard extends StatelessWidget {
  /// 创建表单摘要卡片实例。
  const _FormCard({
    required this.title,
    required this.value,
    required this.description,
    this.errorText,
  });

  /// 字段标题。
  final String title;

  /// 字段当前值。
  final String value;

  /// 字段说明。
  final String description;

  /// 字段错误说明。
  final String? errorText;

  /// 渲染表单摘要卡片。
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
        border: Border.all(
          color: errorText == null
              ? colorScheme.outlineVariant
              : colorScheme.error,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(value, style: textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          if (errorText != null) ...[
            const SizedBox(height: 8),
            Text(
              errorText!,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.error,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
