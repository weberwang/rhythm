import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';

import 'today_primary_action.dart';

/// 承载今日页首屏所需的最小领域摘要，统一达标、偏差与主行动口径。
class TodaySummary {
  /// 创建今日摘要实例。
  const TodaySummary({
    required this.hasRecord,
    required this.isGoalMet,
    required this.sleepOffsetMinutes,
    required this.isUserConfirmedRecord,
    required this.showRecoveryCard,
    required this.primaryAction,
    required this.latestRecord,
    required this.targetBedtimeMinutes,
    required this.trendOffsets,
  });

  /// 根据目标作息和有效记录构建今日摘要。
  factory TodaySummary.fromRecords({
    required GoalScheduleSettings settings,
    required List<EffectiveSleepRecord> records,
    required HealthPlatformState healthPlatformState,
    required DateTime now,
  }) {
    if (records.isEmpty) {
      return TodaySummary(
        hasRecord: false,
        isGoalMet: false,
        sleepOffsetMinutes: 0,
        isUserConfirmedRecord: false,
        showRecoveryCard: false,
        primaryAction: healthPlatformState.requiresManualFallback
            ? (healthPlatformState.canRequestAccess
                ? TodayPrimaryAction.openPermissionHelp
                : TodayPrimaryAction.manualRecord)
            : TodayPrimaryAction.manualRecord,
        latestRecord: null,
        targetBedtimeMinutes: settings.targetBedtimeMinutes,
        trendOffsets: const <int>[],
      );
    }

    final latestRecord = records.reduce((left, right) {
      return left.recordDate.isAfter(right.recordDate) ? left : right;
    });
    final targetBedtime = DateTime.utc(
      latestRecord.recordDate.year,
      latestRecord.recordDate.month,
      latestRecord.recordDate.day,
      settings.targetBedtimeMinutes ~/ 60,
      settings.targetBedtimeMinutes % 60,
    );
    final sleepOffsetMinutes =
        latestRecord.fellAsleepAt.difference(targetBedtime).inMinutes;
    final isGoalMet = sleepOffsetMinutes <= settings.lateThresholdMinutes;
    final showRecoveryCard = sleepOffsetMinutes > settings.lateThresholdMinutes;
    final sortedRecords = [...records]
      ..sort((left, right) => left.recordDate.compareTo(right.recordDate));
    final trendOffsets = sortedRecords.map((record) {
      final recordTargetBedtime = DateTime.utc(
        record.recordDate.year,
        record.recordDate.month,
        record.recordDate.day,
        settings.targetBedtimeMinutes ~/ 60,
        settings.targetBedtimeMinutes % 60,
      );
      return record.fellAsleepAt.difference(recordTargetBedtime).inMinutes;
    }).toList();

    return TodaySummary(
      hasRecord: true,
      isGoalMet: isGoalMet,
      sleepOffsetMinutes: sleepOffsetMinutes,
      isUserConfirmedRecord: latestRecord.isUserConfirmed,
      showRecoveryCard: showRecoveryCard,
      primaryAction: showRecoveryCard
          ? TodayPrimaryAction.viewRecoveryPlan
          : TodayPrimaryAction.enterBedtimeMode,
      latestRecord: latestRecord,
      targetBedtimeMinutes: settings.targetBedtimeMinutes,
      trendOffsets: trendOffsets,
    );
  }

  /// 是否存在昨晚记录。
  final bool hasRecord;

  /// 昨晚是否达标。
  final bool isGoalMet;

  /// 与目标入睡时间的分钟偏差；正数表示晚于目标，负数表示早于目标。
  final int sleepOffsetMinutes;

  /// 当前结果是否来自用户确认记录。
  final bool isUserConfirmedRecord;

  /// 是否应在首屏展示恢复建议卡。
  final bool showRecoveryCard;

  /// 今日页首屏主行动。
  final TodayPrimaryAction primaryAction;

  /// 最近一条可展示记录，供后续页面层继续展开。
  final EffectiveSleepRecord? latestRecord;

  /// 今晚目标入睡时间，供行动卡展示。
  final int targetBedtimeMinutes;

  /// 最近 7 天趋势偏差分钟数组，供趋势区展示。
  final List<int> trendOffsets;
}
