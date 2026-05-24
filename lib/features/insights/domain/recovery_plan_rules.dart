import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/insights/domain/stability_score_rules.dart';
import 'package:rhythm/features/insights/domain/recovery_plan.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';

/// 统一承接阶段七恢复计划触发与步骤生成规则。
class RecoveryPlanRules {
  const RecoveryPlanRules._();

  /// 对最近一次明显晚睡生成 1 到 3 天恢复建议。
  static RecoveryPlan? build({
    required GoalScheduleSettings settings,
    required List<EffectiveSleepRecord> records,
    required DateTime now,
  }) {
    if (records.isEmpty) {
      return null;
    }

    final latest = [...records]
      ..sort((left, right) => right.recordDate.compareTo(left.recordDate));
    final latestRecord = latest.first;
    final offset = StabilityScoreRules.offsetMinutes(
      record: latestRecord,
      settings: settings,
    );
    final recoveryThreshold = settings.lateThresholdMinutes + 45;
    if (offset <= recoveryThreshold) {
      return null;
    }

    final days = offset >= settings.lateThresholdMinutes + 120
        ? 3
        : offset >= settings.lateThresholdMinutes + 75
            ? 2
            : 1;
    final steps = List<RecoveryPlanStep>.generate(days, (index) {
      final day = index + 1;
      if (day == 1) {
        return const RecoveryPlanStep(
          dayIndex: 1,
          type: RecoveryPlanStepType.closeWorkEarlier,
        );
      }
      if (day == 2) {
        return const RecoveryPlanStep(
          dayIndex: 2,
          type: RecoveryPlanStepType.reduceNightNoise,
        );
      }
      return const RecoveryPlanStep(
        dayIndex: 3,
        type: RecoveryPlanStepType.reviewLateTriggers,
      );
    });

    return RecoveryPlan(
      status: RecoveryPlanStatus.unread,
      horizonDays: days,
      triggerOffsetMinutes: offset,
      steps: steps,
    );
  }
}
