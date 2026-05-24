import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/core/time/sleep_record_day_resolver.dart';
import 'package:rhythm/features/sleep_records/application/manual_sleep_record_controller.dart';
import 'package:rhythm/features/sleep_records/application/sleep_records_analytics.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/domain/manual_sleep_record_form_state.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sleep_record_summary_row.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sleep_record_time_formatter.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 阶段三手动补录页，用于承接无数据和权限失败后的人工补录路径。
class ManualSleepRecordPage extends HookConsumerWidget {
  /// 创建手动补录页实例。
  const ManualSleepRecordPage({
    super.key,
    this.editingRecordId,
  });

  /// 当前是否处于编辑既有记录场景。
  final String? editingRecordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);
    final existingRecordFuture = useMemoized(
      () => editingRecordId == null
          ? Future<SleepRecord?>.value(null)
          : ref.read(sleepRecordRepositoryProvider).readRecordById(editingRecordId!),
      [editingRecordId],
    );
    final existingRecordSnapshot = useFuture(existingRecordFuture);
    final existingRecord = existingRecordSnapshot.data;
    final initialState = existingRecord == null
        ? ManualSleepRecordFormState()
        : ManualSleepRecordFormState(
            sleepHour: existingRecord.fellAsleepAt.hour,
            sleepMinute: existingRecord.fellAsleepAt.minute,
            wakeHour: existingRecord.wokeUpAt.hour,
            wakeMinute: existingRecord.wokeUpAt.minute,
            isEditing: true,
          );
    final formState = useState(initialState);
    useEffect(() {
      formState.value = initialState;
      return null;
    }, [existingRecord?.id]);
    final state = formState.value;
    final now = DateTime.now();
    final fellAsleepAt = DateTime(
      now.year,
      now.month,
      now.day,
      state.sleepHour,
      state.sleepMinute,
    );
    // 若起床时间早于或等于入睡时间，按次日处理，符合跨午夜睡眠补录场景。
    var wokeUpAt = DateTime(
      now.year,
      now.month,
      now.day,
      state.wakeHour,
      state.wakeMinute,
    );
    if (!wokeUpAt.isAfter(fellAsleepAt)) {
      wokeUpAt = wokeUpAt.add(const Duration(days: 1));
    }
    final recordDate = SleepRecordDayResolver.resolveRecordDate(
      fellAsleepAt: fellAsleepAt,
      dayStartMinutes: 4 * 60,
    );
    final duration = wokeUpAt.difference(fellAsleepAt);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.manualSleepRecordPageTitle, style: textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text(
                  l10n.manualSleepRecordPageSubtitle,
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.manualSleepRecordPageDescription,
                  style: textTheme.bodyMedium?.copyWith(color: const Color(0xFF4A6B52)),
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        SleepRecordSummaryRow(
                          label: l10n.manualSleepRecordDateLabel,
                          value:
                              '${recordDate.year.toString().padLeft(4, '0')}-${recordDate.month.toString().padLeft(2, '0')}-${recordDate.day.toString().padLeft(2, '0')}',
                        ),
                        const SizedBox(height: 12),
                        SleepRecordSummaryRow(
                          label: l10n.manualSleepRecordSleepTimeLabel,
                          value: formatSleepRecordTime(
                            state.sleepHour,
                            state.sleepMinute,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SleepRecordSummaryRow(
                          label: l10n.manualSleepRecordWakeTimeLabel,
                          value: formatSleepRecordTime(
                            state.wakeHour,
                            state.wakeMinute,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SleepRecordSummaryRow(
                          label: l10n.manualSleepRecordDurationLabel,
                          value: '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
                        ),
                        const SizedBox(height: 12),
                        SleepRecordSummaryRow(
                          label: l10n.manualSleepRecordSourceLabel,
                          value: l10n.manualSleepRecordSourceValue,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (state.timeRangeError != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      l10n.manualSleepRecordValidationSameTime,
                      style: textTheme.bodyMedium?.copyWith(color: Colors.red),
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final selected = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                              hour: state.sleepHour,
                              minute: state.sleepMinute,
                            ),
                          );
                          if (selected == null) {
                            return;
                          }
                          final controller = ManualSleepRecordController(
                            initialState: formState.value,
                          );
                          controller.updateSleepTime(
                            hour: selected.hour,
                            minute: selected.minute,
                          );
                          formState.value = controller.state;
                        },
                        child: Text(
                          '${l10n.manualSleepRecordSleepTimeLabel} · ${formatSleepRecordTime(state.sleepHour, state.sleepMinute)}',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final selected = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                              hour: state.wakeHour,
                              minute: state.wakeMinute,
                            ),
                          );
                          if (selected == null) {
                            return;
                          }
                          final controller = ManualSleepRecordController(
                            initialState: formState.value,
                          );
                          controller.updateWakeTime(
                            hour: selected.hour,
                            minute: selected.minute,
                          );
                          formState.value = controller.state;
                        },
                        child: Text(
                          '${l10n.manualSleepRecordWakeTimeLabel} · ${formatSleepRecordTime(state.wakeHour, state.wakeMinute)}',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Card(
                  color: const Color(0xFFF4E8CF),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.manualSleepRecordHelperTitle,
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(l10n.manualSleepRecordHelperDescription),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () async {
                    final controller = ManualSleepRecordController(
                      initialState: formState.value,
                    );
                    if (!controller.submit()) {
                      formState.value = controller.state;
                      return;
                    }
                    formState.value = controller.state;
                    final savedRecord = SleepRecord(
                      id: existingRecord?.id ?? 'manual-${now.microsecondsSinceEpoch}',
                      recordDate: recordDate,
                      fellAsleepAt: fellAsleepAt,
                      wokeUpAt: wokeUpAt,
                      durationMinutes: duration.inMinutes,
                      source: SleepRecordSource.manual,
                      confidence: SleepRecordConfidence.high,
                      timezone: now.timeZoneName,
                      isUserEdited: true,
                      sourceRecordId: existingRecord?.sourceRecordId,
                      createdAt: existingRecord?.createdAt ?? now,
                      updatedAt: now,
                    );
                    final repository = ref.read(sleepRecordRepositoryProvider);
                    await repository.saveRecord(savedRecord);
                    await ref.read(sleepRecordsAnalyticsProvider).track(
                      SleepRecordsAnalyticsEvent(
                        name: 'sleep_records_manual_saved',
                        parameters: <String, Object?>{
                          'duration_minutes': duration.inMinutes,
                        },
                      ),
                    );
                    ref.invalidate(recentEffectiveSleepRecordsProvider);
                    if (!context.mounted) {
                      return;
                    }
                    context.go(sleepRecordsHubPath);
                  },
                  child: Text(l10n.manualSleepRecordSaveButton),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    context.go(sleepRecordsHubPath);
                  },
                  child: Text(l10n.manualSleepRecordDiscardButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
