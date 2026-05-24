import 'bedtime_action.dart';
import 'bedtime_status.dart';

/// 承载睡前模式首屏所需的倒计时、推荐状态和动作建议。
class BedtimeModeSummary {
  /// 创建睡前模式摘要。
  const BedtimeModeSummary({
    required this.minutesUntilTarget,
    required this.progress,
    required this.recommendedStatus,
    required this.actions,
  });

  /// 距离目标入睡时间的分钟差；负数表示已经晚于目标。
  final int minutesUntilTarget;

  /// 倒计时进度，范围固定在 0 到 1。
  final double progress;

  /// 当前时间下更推荐用户优先选择的状态。
  final BedtimeStatus recommendedStatus;

  /// 当前状态对应的轻量动作建议。
  final List<BedtimeAction> actions;

  /// 根据当前时间与目标时间计算睡前模式摘要。
  static BedtimeModeSummary calculate({
    required DateTime now,
    required DateTime targetBedtime,
    required int softReminderLeadMinutes,
  }) {
    final minutesUntilTarget = targetBedtime.difference(now).inMinutes;
    final normalizedLeadMinutes = softReminderLeadMinutes <= 0
        ? 1
        : softReminderLeadMinutes;
    final rawProgress =
        (normalizedLeadMinutes - minutesUntilTarget) / normalizedLeadMinutes;
    final progress = rawProgress.clamp(0, 1).toDouble();

    if (minutesUntilTarget <= -30) {
      return BedtimeModeSummary(
        minutesUntilTarget: minutesUntilTarget,
        progress: progress,
        recommendedStatus: BedtimeStatus.likelyLate,
        actions: const <BedtimeAction>[
          BedtimeAction(
            type: BedtimeActionType.closeTonight,
            analyticsName: 'close_tonight',
            priority: 0,
          ),
          BedtimeAction(
            type: BedtimeActionType.planRecoveryTomorrow,
            analyticsName: 'plan_recovery_tomorrow',
            priority: 1,
          ),
        ],
      );
    }

    if (minutesUntilTarget < 0) {
      return BedtimeModeSummary(
        minutesUntilTarget: minutesUntilTarget,
        progress: progress,
        recommendedStatus: BedtimeStatus.wantsMoreTime,
        actions: const <BedtimeAction>[
          BedtimeAction(
            type: BedtimeActionType.tenMinuteWrapUp,
            analyticsName: 'ten_minute_wrap_up',
            priority: 0,
          ),
          BedtimeAction(
            type: BedtimeActionType.closeTonight,
            analyticsName: 'close_tonight',
            priority: 1,
          ),
        ],
      );
    }

    return BedtimeModeSummary(
      minutesUntilTarget: minutesUntilTarget,
      progress: progress,
      recommendedStatus: BedtimeStatus.readyToSleep,
      actions: const <BedtimeAction>[
        BedtimeAction(
          type: BedtimeActionType.dimLights,
          analyticsName: 'dim_lights',
          priority: 0,
        ),
        BedtimeAction(
          type: BedtimeActionType.putPhoneAway,
          analyticsName: 'put_phone_away',
          priority: 1,
        ),
      ],
    );
  }
}
