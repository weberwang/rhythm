import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/core/presentation/widgets/secondary_page_header.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_form_controller.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_settings_save_service.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';
import 'package:rhythm/shared/presentation/widgets/composites/rhythm_onboarding_action_card.dart';

import '../../../app/router/app_router.dart';

/// 目标作息设置页，首启阶段只要求用户先设定入睡和起床两个关键时间。
class GoalSetupPage extends HookConsumerWidget {
  /// 创建目标作息设置页。
  const GoalSetupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final form = ref.watch(goalScheduleFormControllerProvider);
    final controller = ref.read(goalScheduleFormControllerProvider.notifier);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    Future<void> saveAndContinue() async {
      if (!controller.submit()) {
        return;
      }
      await ref
          .read(goalScheduleSettingsSaveServiceProvider)
          .save(
            GoalScheduleSettings(
              targetBedtimeMinutes: form.bedtimeHour * 60 + form.bedtimeMinute,
              targetWakeMinutes: form.wakeHour * 60 + form.wakeMinute,
              lateThresholdMinutes: form.lateThresholdMinutes,
              dayStartMinutes: form.dayStartHour * 60 + form.dayStartMinute,
            ),
          );
      if (context.mounted) {
        // 首启主链路先补齐增强体验设置，再进入今日页。
        context.go(onboardingReminderSetupPath);
      }
    }

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
                SecondaryPageHeader(
                  title: l10n.goalSetupPageTitle,
                  fallbackLocation: onboardingWelcomePath,
                ),
                const SizedBox(height: 18),
                _GoalHeroCard(
                  title: l10n.goalSetupPageTitle,
                  description: l10n.goalSetupPageDescription,
                ),
                const SizedBox(height: 24),
                _GoalTimeSetupCard(
                  title: l10n.goalSetupCardTitle,
                  description: l10n.goalSetupCardDescription,
                  bedtimeValue: _formatTime(
                    form.bedtimeHour,
                    form.bedtimeMinute,
                  ),
                  wakeValue: _formatTime(form.wakeHour, form.wakeMinute),
                  bedtimeDescription: l10n.goalSetupBedtimeHint,
                  wakeDescription: l10n.goalSetupWakeHint,
                  onTapBedtime: () => _showTimePickerSheet(
                    context,
                    title: l10n.goalScheduleBedtimeLabel,
                    initialHour: form.bedtimeHour,
                    initialMinute: form.bedtimeMinute,
                    onConfirm: (hour, minute) =>
                        controller.updateBedtime(hour: hour, minute: minute),
                  ),
                  onTapWake: () => _showTimePickerSheet(
                    context,
                    title: l10n.goalScheduleWakeLabel,
                    initialHour: form.wakeHour,
                    initialMinute: form.wakeMinute,
                    onConfirm: (hour, minute) =>
                        controller.updateWakeTime(hour: hour, minute: minute),
                  ),
                  footerNote: l10n.goalSetupFooterHint,
                ),
                if (form.wakeTimeError != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    l10n.goalScheduleWakeSameAsBedtimeError,
                    style: textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                RhythmOnboardingActionCard(
                  primaryLabel: l10n.goalSetupContinueButton,
                  secondaryLabel: l10n.goalSetupSecondaryButton,
                  onPrimary: saveAndContinue,
                  onSecondary: saveAndContinue,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.goalSetupBottomNote,
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

/// 顶部 Hero 卡，承接目标页的首屏语义。
class _GoalHeroCard extends StatelessWidget {
  const _GoalHeroCard({required this.title, required this.description});

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

/// 时间设置卡组，复刻设计稿里的两张关键时间卡。
class _GoalTimeSetupCard extends StatelessWidget {
  const _GoalTimeSetupCard({
    required this.title,
    required this.description,
    required this.bedtimeValue,
    required this.wakeValue,
    required this.bedtimeDescription,
    required this.wakeDescription,
    required this.onTapBedtime,
    required this.onTapWake,
    required this.footerNote,
  });

  final String title;
  final String description;
  final String bedtimeValue;
  final String wakeValue;
  final String bedtimeDescription;
  final String wakeDescription;
  final VoidCallback onTapBedtime;
  final VoidCallback onTapWake;
  final String footerNote;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

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
          _GoalTimeCard(
            label: AppLocalizations.of(context).goalScheduleBedtimeLabel,
            value: bedtimeValue,
            description: bedtimeDescription,
            backgroundColor: const Color(0xFFF9FBFF),
            borderColor: const Color(0xFFE6ECF7),
            onTap: onTapBedtime,
          ),
          const SizedBox(height: 16),
          _GoalTimeCard(
            label: AppLocalizations.of(context).goalScheduleWakeLabel,
            value: wakeValue,
            description: wakeDescription,
            backgroundColor: const Color(0xFFFCFBF8),
            borderColor: const Color(0xFFEEE7D8),
            onTap: onTapWake,
          ),
          const SizedBox(height: 18),
          Text(
            footerNote,
            style: textTheme.bodySmall?.copyWith(
              color: const Color(0xFF8D97AE),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// 单个时间卡，点击后进入时间选择弹层。
class _GoalTimeCard extends StatelessWidget {
  const _GoalTimeCard({
    required this.label,
    required this.value,
    required this.description,
    required this.backgroundColor,
    required this.borderColor,
    required this.onTap,
  });

  final String label;
  final String value;
  final String description;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF6F7891),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: textTheme.displaySmall?.copyWith(
                      color: const Color(0xFF182033),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF6F7891),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF8D97AE),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 时间选择弹层，使用滚轮模拟设计稿里的时间抽屉交互。
class _GoalTimePickerSheet extends StatefulWidget {
  const _GoalTimePickerSheet({
    required this.title,
    required this.initialHour,
    required this.initialMinute,
    required this.onConfirm,
  });

  final String title;
  final int initialHour;
  final int initialMinute;
  final void Function(int hour, int minute) onConfirm;

  @override
  State<_GoalTimePickerSheet> createState() => _GoalTimePickerSheetState();
}

/// 管理时间滚轮的局部状态。
class _GoalTimePickerSheetState extends State<_GoalTimePickerSheet> {
  late int selectedHour;
  late int selectedMinute;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialHour;
    selectedMinute = widget.initialMinute;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _formatTime(selectedHour, selectedMinute),
                textAlign: TextAlign.center,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF182033),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 180,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F1F7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoPicker(
                            backgroundColor: Colors.white,
                            itemExtent: 40,
                            scrollController: FixedExtentScrollController(
                              initialItem: selectedHour,
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedHour = index;
                              });
                            },
                            children: List.generate(
                              24,
                              (index) => Center(
                                child: Text(index.toString().padLeft(2, '0')),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CupertinoPicker(
                            backgroundColor: Colors.white,
                            itemExtent: 40,
                            scrollController: FixedExtentScrollController(
                              initialItem: selectedMinute == 30 ? 1 : 0,
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedMinute = index == 0 ? 0 : 30;
                              });
                            },
                            children: const [
                              Center(child: Text('00')),
                              Center(child: Text('30')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  widget.onConfirm(selectedHour, selectedMinute);
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context).goalSetupPickerConfirm),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 弹出时间选择滚轮。
Future<void> _showTimePickerSheet(
  BuildContext context, {
  required String title,
  required int initialHour,
  required int initialMinute,
  required void Function(int hour, int minute) onConfirm,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return _GoalTimePickerSheet(
        title: title,
        initialHour: initialHour,
        initialMinute: initialMinute,
        onConfirm: onConfirm,
      );
    },
  );
}

/// 格式化当前选中的时间，统一页面和弹层展示。
String _formatTime(int hour, int minute) {
  final hourText = hour.toString().padLeft(2, '0');
  final minuteText = minute.toString().padLeft(2, '0');
  return '$hourText:$minuteText';
}
