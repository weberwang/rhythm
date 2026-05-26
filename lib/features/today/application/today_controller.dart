import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/sleep_records/application/effective_sleep_record_provider.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';

import '../domain/today_summary.dart';
import 'today_view_state.dart';

part 'today_controller.g.dart';

/// 聚合目标作息、有效记录与平台状态，向今日页输出单一可渲染状态。
@riverpod
Future<TodayViewState> todayController(Ref ref) async {
  final settings = await ref.watch(savedGoalScheduleSettingsProvider.future);
  if (settings == null) {
    return const TodayViewState(
      status: TodayViewStatus.goalMissing,
      prioritizeRecoveryCard: false,
    );
  }

  final healthPlatformState = await ref.watch(healthPlatformStateProvider.future);
  final records = await ref.watch(recentEffectiveSleepRecordsProvider.future);
  final summary = TodaySummary.fromRecords(
    settings: settings,
    records: records,
    healthPlatformState: healthPlatformState,
    now: DateTime.now(),
  );

  if (!summary.hasRecord) {
    return TodayViewState(
      status: _statusFromSummary(
        summary: summary,
        healthPlatformState: healthPlatformState,
      ),
      prioritizeRecoveryCard: false,
      summary: summary,
    );
  }

  return TodayViewState(
    status: TodayViewStatus.ready,
    prioritizeRecoveryCard: summary.showRecoveryCard,
    summary: summary,
  );
}

/// 根据摘要和平台状态确定今日页空态类型，避免展示层重复判断权限逻辑。
TodayViewStatus _statusFromSummary({
  required TodaySummary summary,
  required HealthPlatformState healthPlatformState,
}) {
  if (summary.hasRecord) {
    return TodayViewStatus.ready;
  }
  if (healthPlatformState.canRequestAccess) {
    return TodayViewStatus.permissionFailed;
  }
  return TodayViewStatus.empty;
}
