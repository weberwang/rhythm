import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/core/presentation/widgets/secondary_page_header.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_form_controller.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_settings_save_service.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_form_state.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import 'widgets/goal_schedule_form_section.dart';

/// 展示阶段八的目标作息编辑页，复用既有表单组件承接已保存设置的微调。
class GoalScheduleSettingsPage extends HookConsumerWidget {
  /// 创建目标作息编辑页。
  const GoalScheduleSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final savedSettingsAsync = ref.watch(savedGoalScheduleSettingsProvider);
    final savedSettings = savedSettingsAsync.maybeWhen(
      data: (value) => value,
      orElse: () => null,
    );
    final formState = ref.watch(goalScheduleFormControllerProvider);
    final controller = ref.read(goalScheduleFormControllerProvider.notifier);
    final seeded = useRef(false);
    final l10n = AppLocalizations.of(context);

    useEffect(() {
      // 已保存设置只在首次进入页面时注入一次，避免用户手动修改过程中被异步读回值覆盖。
      if (!seeded.value && savedSettings != null) {
        seeded.value = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.updateBedtime(
            hour: savedSettings.targetBedtimeMinutes ~/ 60,
            minute: savedSettings.targetBedtimeMinutes % 60,
          );
          controller.updateWakeTime(
            hour: savedSettings.targetWakeMinutes ~/ 60,
            minute: savedSettings.targetWakeMinutes % 60,
          );
          controller.updateLateThreshold(savedSettings.lateThresholdMinutes);
          controller.updateDayStart(
            hour: savedSettings.dayStartMinutes ~/ 60,
            minute: savedSettings.dayStartMinutes % 60,
          );
        });
      }
      return null;
    }, [savedSettings]);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SecondaryPageHeader(
                title: l10n.goalScheduleSettingsPageTitle,
                fallbackLocation: RhythmTab.profile.path,
                titleStyle: textTheme.headlineSmall?.copyWith(
                  fontFamily: 'Funnel Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.goalScheduleSettingsPageDescription,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              _SummaryCard(
                formState: formState,
                bedtimeLabel: l10n.goalScheduleSettingsSummaryBedtimeLabel,
                wakeLabel: l10n.goalScheduleSettingsSummaryWakeLabel,
                lateThresholdLabel:
                    l10n.goalScheduleSettingsSummaryLateThresholdLabel,
                dayStartLabel: l10n.goalScheduleSettingsSummaryDayStartLabel,
                lateThresholdValue: l10n.goalScheduleMinutesValue(
                  formState.lateThresholdMinutes,
                ),
              ),
              const SizedBox(height: 12),
              const Expanded(
                child: SingleChildScrollView(child: GoalScheduleFormSection()),
              ),
              const SizedBox(height: 12),
              _HintCard(description: l10n.goalScheduleSettingsHintDescription),
              const SizedBox(height: 12),
              RhythmPrimaryButton(
                label: l10n.goalScheduleSettingsSaveButton,
                onPressed: () async {
                  if (!controller.submit()) {
                    return;
                  }
                  await ref
                      .read(goalScheduleSettingsSaveServiceProvider)
                      .save(
                        GoalScheduleSettings(
                          targetBedtimeMinutes:
                              formState.bedtimeHour * 60 +
                              formState.bedtimeMinute,
                          targetWakeMinutes:
                              formState.wakeHour * 60 + formState.wakeMinute,
                          lateThresholdMinutes: formState.lateThresholdMinutes,
                          dayStartMinutes:
                              formState.dayStartHour * 60 +
                              formState.dayStartMinute,
                        ),
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

/// 渲染当前目标作息摘要，避免页面层手写时间与阈值格式化。
class _SummaryCard extends StatelessWidget {
  /// 创建目标作息摘要卡。
  const _SummaryCard({
    required this.formState,
    required this.bedtimeLabel,
    required this.wakeLabel,
    required this.lateThresholdLabel,
    required this.dayStartLabel,
    required this.lateThresholdValue,
  });

  /// 当前表单状态。
  final GoalScheduleFormState formState;

  /// 目标入睡时间标题。
  final String bedtimeLabel;

  /// 目标起床时间标题。
  final String wakeLabel;

  /// 晚睡阈值标题。
  final String lateThresholdLabel;

  /// 一天起始时间标题。
  final String dayStartLabel;

  /// 晚睡阈值格式化结果。
  final String lateThresholdValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
        children: [
          _SummaryRow(
            label: bedtimeLabel,
            value: _formatTime(formState.bedtimeHour, formState.bedtimeMinute),
          ),
          _SummaryRow(
            label: wakeLabel,
            value: _formatTime(formState.wakeHour, formState.wakeMinute),
          ),
          _SummaryRow(label: lateThresholdLabel, value: lateThresholdValue),
          _SummaryRow(
            label: dayStartLabel,
            value: _formatTime(
              formState.dayStartHour,
              formState.dayStartMinute,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int hour, int minute) {
    final hourText = hour.toString().padLeft(2, '0');
    final minuteText = minute.toString().padLeft(2, '0');
    return '$hourText:$minuteText';
  }
}

/// 渲染摘要中的单行字段，保持标签和值的左右分布结构。
class _SummaryRow extends StatelessWidget {
  /// 创建摘要行。
  const _SummaryRow({required this.label, required this.value});

  /// 字段标题。
  final String label;

  /// 字段值。
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontFamily: 'IBM Plex Mono',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// 渲染目标调整提示卡，保留设计稿中的温和引导语气。
class _HintCard extends StatelessWidget {
  /// 创建提示卡。
  const _HintCard({required this.description});

  /// 提示说明。
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0E1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        description,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4),
      ),
    );
  }
}
