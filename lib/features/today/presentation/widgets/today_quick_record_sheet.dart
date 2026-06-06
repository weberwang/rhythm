import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../application/providers/today_quick_record_controller.dart';
import '../../domain/entities/today_snapshot.dart';
import 'today_dashboard_style.dart';

/// today 快捷补录 sheet 只收集最小字段，避免把用户拖回复杂表单。
class TodayQuickRecordSheet extends HookConsumerWidget {
  /// 创建快捷补录 sheet。
  const TodayQuickRecordSheet({required this.tonightGoal, super.key});

  /// 今晚目标为补录提供默认时间锚点，避免表单空白起步。
  final TodayTonightGoalSummary tonightGoal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context);
    final materialLocalizations = MaterialLocalizations.of(context);
    final noteController = useTextEditingController();
    final sleepDate = useState(
      DateTime.now().subtract(const Duration(days: 1)),
    );
    final bedtime = useState(
      TimeOfDay(
        hour: tonightGoal.bedtimeMinutes ~/ 60 % 24,
        minute: tonightGoal.bedtimeMinutes % 60,
      ),
    );
    final wakeTime = useState(
      TimeOfDay(
        hour: tonightGoal.wakeTimeMinutes ~/ 60 % 24,
        minute: tonightGoal.wakeTimeMinutes % 60,
      ),
    );
    final submitState = ref.watch(todayQuickRecordControllerProvider);
    final isSubmitting = submitState.isLoading;

    Future<void> pickSleepDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: sleepDate.value,
        firstDate: DateTime(2025, 1, 1),
        lastDate: DateTime.now(),
      );
      if (picked != null) {
        sleepDate.value = picked;
      }
    }

    Future<void> pickBedtime() async {
      final picked = await showTimePicker(
        context: context,
        initialTime: bedtime.value,
      );
      if (picked != null) {
        bedtime.value = picked;
      }
    }

    Future<void> pickWakeTime() async {
      final picked = await showTimePicker(
        context: context,
        initialTime: wakeTime.value,
      );
      if (picked != null) {
        wakeTime.value = picked;
      }
    }

    Future<void> submit() async {
      await ref
          .read(todayQuickRecordControllerProvider.notifier)
          .submit(
            sleepDate: sleepDate.value,
            bedtimeMinutes: bedtime.value.hour * 60 + bedtime.value.minute,
            wakeTimeMinutes: wakeTime.value.hour * 60 + wakeTime.value.minute,
            note: noteController.text,
          );
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(localization.todayQuickRecordSaved)),
        );
      }
    }

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localization.todayQuickRecordSheetTitle,
              style: TodayDashboardStyle.heroTitle(
                context,
              ).copyWith(fontSize: 28),
            ),
            const SizedBox(height: 10),
            Text(
              localization.todayQuickRecordSheetBody,
              style: TodayDashboardStyle.bodyText(context),
            ),
            const SizedBox(height: 22),
            _SheetActionTile(
              label: localization.todayQuickRecordDateLabel,
              value: materialLocalizations.formatMediumDate(sleepDate.value),
              icon: Icons.calendar_today_outlined,
              onTap: pickSleepDate,
            ),
            const SizedBox(height: 12),
            _SheetActionTile(
              label: localization.todayQuickRecordBedtimeLabel,
              value: materialLocalizations.formatTimeOfDay(bedtime.value),
              icon: Icons.nightlight_round,
              onTap: pickBedtime,
            ),
            const SizedBox(height: 12),
            _SheetActionTile(
              label: localization.todayQuickRecordWakeTimeLabel,
              value: materialLocalizations.formatTimeOfDay(wakeTime.value),
              icon: Icons.wb_sunny_outlined,
              onTap: pickWakeTime,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: noteController,
              minLines: 2,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: localization.todayQuickRecordNoteLabel,
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: isSubmitting ? null : submit,
                child: Text(localization.todayQuickRecordSaveAction),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 统一封装快捷补录内的选择行，保持 sheet 视觉密度稳定。
class _SheetActionTile extends StatelessWidget {
  /// 创建选择行。
  const _SheetActionTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  /// 行标题。
  final String label;

  /// 当前值。
  final String value;

  /// 行图标。
  final IconData icon;

  /// 点击动作。
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: TodayDashboardStyle.cardRadius,
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: TodayDashboardStyle.cardRadius,
          border: Border.all(color: TodayDashboardStyle.cardStroke),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TodayDashboardStyle.supportLabel(context)),
                  const SizedBox(height: 4),
                  Text(value, style: TodayDashboardStyle.cardTitle(context)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}
