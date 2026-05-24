import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_form_controller.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../app/router/app_router.dart';
import 'widgets/goal_schedule_form_section.dart';

/// 目标作息设置页，按 Pencil 的页面节奏完成首次目标设定。
class GoalSetupPage extends HookConsumerWidget {
  /// 创建目标作息设置页。
  const GoalSetupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(goalScheduleFormControllerProvider.notifier);

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
                      const _HeaderPill(text: '设置一个能做到的目标'),
                      const SizedBox(height: 8),
                      Text(
                        '目标是节律的参考线，不是每天必须完美做到的红线。',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontFamily: 'Funnel Sans',
                              fontWeight: FontWeight.w700,
                              height: 1.08,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '先给出一版基础目标，后面随时可以调整。',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontFamily: 'Geist',
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              height: 1.4,
                            ),
                      ),
                      const SizedBox(height: 18),
                      const _GoalSummaryCard(),
                      const SizedBox(height: 12),
                      const GoalScheduleFormSection(),
                      const SizedBox(height: 12),
                      const _GoalWorkdayCard(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              RhythmPrimaryButton(
                label: l10n.goalSetupContinueButton,
                onPressed: () async {
                  if (controller.submit()) {
                    final form = ref.read(goalScheduleFormControllerProvider);
                    await ref
                        .read(goalScheduleSettingsRepositoryProvider)
                        .save(
                          GoalScheduleSettings(
                            targetBedtimeMinutes:
                                form.bedtimeHour * 60 + form.bedtimeMinute,
                            targetWakeMinutes:
                                form.wakeHour * 60 + form.wakeMinute,
                            lateThresholdMinutes: form.lateThresholdMinutes,
                            dayStartMinutes:
                                form.dayStartHour * 60 + form.dayStartMinute,
                          ),
                        );
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

/// 目标作息设置主卡。
class _GoalSummaryCard extends StatelessWidget {
  const _GoalSummaryCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
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
        children: const [
          _GoalRow(label: '目标入睡时间', value: '23:30'),
          _GoalRow(label: '目标起床时间', value: '07:30'),
          _GoalRow(label: '晚睡阈值', value: '30 分钟'),
          _GoalRow(label: '一天起始时间', value: '04:00'),
        ],
      ),
    );
  }
}

/// 目标作息字段行。
class _GoalRow extends StatelessWidget {
  /// 创建目标行。
  const _GoalRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textTheme.bodyMedium),
          Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              fontFamily: 'IBM Plex Mono',
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

/// 工作日规则卡。
class _GoalWorkdayCard extends StatelessWidget {
  const _GoalWorkdayCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('工作日规则', style: textTheme.titleMedium),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _Chip(text: '工作日优先'),
              _Chip(text: '后续再调'),
            ],
          ),
        ],
      ),
    );
  }
}

/// 工作日标签。
class _Chip extends StatelessWidget {
  /// 创建标签。
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
