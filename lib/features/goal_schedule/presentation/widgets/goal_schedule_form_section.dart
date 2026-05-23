import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_form_controller.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示目标作息表单的字段分组，保持页面层只负责路由与提交动作。
class GoalScheduleFormSection extends HookConsumerWidget {
  /// 创建目标作息表单分组组件实例。
  const GoalScheduleFormSection({super.key});

  /// 渲染目标作息表单，并把字段交互收口到对应控制器。
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final form = ref.watch(goalScheduleFormControllerProvider);
    final controller = ref.read(goalScheduleFormControllerProvider.notifier);
    final timeOptions = _timeOptions();
    final dayStartOptions = _dayStartOptions();
    final lateThresholdOptions = _lateThresholdOptions();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TimeFormCard(
          title: l10n.goalScheduleBedtimeLabel,
          description: l10n.goalScheduleBedtimeDescription,
          selectedValue: _encodeTime(form.bedtimeHour, form.bedtimeMinute),
          selectedLabel: _formatTime(form.bedtimeHour, form.bedtimeMinute),
          options: timeOptions,
          fieldKey: const Key('goal-bedtime-dropdown'),
          onChanged: (value) {
            final time = _decodeTime(value);
            controller.updateBedtime(hour: time.$1, minute: time.$2);
          },
        ),
        const SizedBox(height: 12),
        _TimeFormCard(
          title: l10n.goalScheduleWakeLabel,
          description: l10n.goalScheduleWakeDescription,
          selectedValue: _encodeTime(form.wakeHour, form.wakeMinute),
          options: timeOptions,
          fieldKey: const Key('goal-wake-dropdown'),
          onChanged: (value) {
            final time = _decodeTime(value);
            controller.updateWakeTime(hour: time.$1, minute: time.$2);
          },
          selectedLabel: _formatTime(form.wakeHour, form.wakeMinute),
          errorText: form.wakeTimeError == null
              ? null
              : l10n.goalScheduleWakeSameAsBedtimeError,
        ),
        const SizedBox(height: 12),
        _SelectFormCard(
          title: l10n.goalScheduleLateThresholdLabel,
          description: l10n.goalScheduleLateThresholdDescription,
          selectedValue: form.lateThresholdMinutes,
          options: lateThresholdOptions
              .map(
                (minutes) => DropdownMenuItem<int>(
                  value: minutes,
                  child: Text(l10n.goalScheduleMinutesValue(minutes)),
                ),
              )
              .toList(),
          fieldKey: const Key('goal-late-threshold-dropdown'),
          onChanged: controller.updateLateThreshold,
        ),
        const SizedBox(height: 12),
        _TimeFormCard(
          title: l10n.goalScheduleDayStartLabel,
          description: l10n.goalScheduleDayStartDescription,
          selectedValue: _encodeTime(form.dayStartHour, form.dayStartMinute),
          selectedLabel: _formatTime(form.dayStartHour, form.dayStartMinute),
          options: dayStartOptions,
          fieldKey: const Key('goal-day-start-dropdown'),
          onChanged: (value) {
            final time = _decodeTime(value);
            controller.updateDayStart(hour: time.$1, minute: time.$2);
          },
        ),
      ],
    );
  }

  /// 生成半小时粒度的通用时间选项，满足 MVP 目标作息设置需要。
  List<DropdownMenuItem<int>> _timeOptions() {
    final options = <DropdownMenuItem<int>>[];
    for (var hour = 0; hour < 24; hour++) {
      for (final minute in const [0, 30]) {
        final value = _encodeTime(hour, minute);
        options.add(
          DropdownMenuItem<int>(
            value: value,
            child: Text(_formatTime(hour, minute)),
          ),
        );
      }
    }
    return options;
  }

  /// 一天起始时间只开放凌晨区间，避免超出当前业务设定的解释范围。
  List<DropdownMenuItem<int>> _dayStartOptions() {
    final options = <DropdownMenuItem<int>>[];
    for (var hour = 0; hour <= 6; hour++) {
      for (final minute in const [0, 30]) {
        final value = _encodeTime(hour, minute);
        options.add(
          DropdownMenuItem<int>(
            value: value,
            child: Text(_formatTime(hour, minute)),
          ),
        );
      }
    }
    return options;
  }

  /// 熬夜阈值先限制在明确可解释的分钟档位，避免自由输入造成噪声。
  List<int> _lateThresholdOptions() {
    return const [15, 30, 45, 60, 90];
  }

  /// 编码时间值，便于下拉框只传递单一整数。
  int _encodeTime(int hour, int minute) {
    return hour * 60 + minute;
  }

  /// 解码时间值，恢复小时和分钟供控制器写入状态。
  (int, int) _decodeTime(int value) {
    return (value ~/ 60, value % 60);
  }

  /// 统一格式化时间文本，避免多个字段各自拼接时分字符串。
  String _formatTime(int hour, int minute) {
    final hourText = hour.toString().padLeft(2, '0');
    final minuteText = minute.toString().padLeft(2, '0');
    return '$hourText:$minuteText';
  }
}

/// 承载带时间选择的目标作息字段卡片。
class _TimeFormCard extends StatelessWidget {
  /// 创建时间字段卡片实例。
  const _TimeFormCard({
    required this.title,
    required this.description,
    required this.selectedValue,
    required this.options,
    required this.fieldKey,
    required this.onChanged,
    required this.selectedLabel,
    this.errorText,
  });

  /// 字段标题。
  final String title;

  /// 字段说明。
  final String description;

  /// 当前选中的时间值。
  final int selectedValue;

  /// 可选时间项。
  final List<DropdownMenuItem<int>> options;

  /// 测试与状态定位使用的控件键。
  final Key fieldKey;

  /// 选择变化后的回调。
  final ValueChanged<int> onChanged;

  /// 当前值的可读文案，便于测试稳定识别更新结果。
  final String selectedLabel;

  /// 字段错误说明。
  final String? errorText;

  /// 渲染时间选择字段卡片。
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
          DropdownButtonFormField<int>(
            key: fieldKey,
            initialValue: selectedValue,
            items: options,
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            selectedLabel,
            key: Key('${fieldKey.toString()}-value'),
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.primary,
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

/// 承载带离散选项的数字字段卡片。
class _SelectFormCard extends StatelessWidget {
  /// 创建离散选项字段卡片实例。
  const _SelectFormCard({
    required this.title,
    required this.description,
    required this.selectedValue,
    required this.options,
    required this.fieldKey,
    required this.onChanged,
  });

  /// 字段标题。
  final String title;

  /// 字段说明。
  final String description;

  /// 当前选中值。
  final int selectedValue;

  /// 可选项列表。
  final List<DropdownMenuItem<int>> options;

  /// 测试与状态定位使用的控件键。
  final Key fieldKey;

  /// 值变化后的回调。
  final ValueChanged<int> onChanged;

  /// 渲染离散选项字段卡片。
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
          Text(title, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          DropdownButtonFormField<int>(
            key: fieldKey,
            initialValue: selectedValue,
            items: options,
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
