import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/bedtime/domain/bedtime_action.dart';
import 'package:rhythm/features/bedtime/domain/bedtime_mode_summary.dart';
import 'package:rhythm/features/bedtime/domain/bedtime_status.dart';

/// 验证睡前模式领域规则，确保倒计时、推荐状态和动作建议口径稳定。
void main() {
  test('目标时间前返回正向倒计时和准备建议', () {
    final summary = BedtimeModeSummary.calculate(
      now: DateTime(2026, 5, 24, 22, 45),
      targetBedtime: DateTime(2026, 5, 24, 23, 30),
      softReminderLeadMinutes: 45,
    );

    expect(summary.minutesUntilTarget, 45);
    expect(summary.progress, 0);
    expect(summary.recommendedStatus, BedtimeStatus.readyToSleep);
    expect(
      summary.actions.map((action) => action.type),
      contains(BedtimeActionType.dimLights),
    );
  });

  test('目标时间后限制进度上限并推荐温和收尾', () {
    final summary = BedtimeModeSummary.calculate(
      now: DateTime(2026, 5, 24, 23, 45),
      targetBedtime: DateTime(2026, 5, 24, 23, 30),
      softReminderLeadMinutes: 45,
    );

    expect(summary.minutesUntilTarget, -15);
    expect(summary.progress, 1);
    expect(summary.recommendedStatus, BedtimeStatus.wantsMoreTime);
    expect(
      summary.actions.map((action) => action.type),
      contains(BedtimeActionType.closeTonight),
    );
  });

  test('超过目标三十分钟后推荐明显晚睡状态', () {
    final summary = BedtimeModeSummary.calculate(
      now: DateTime(2026, 5, 25, 0, 5),
      targetBedtime: DateTime(2026, 5, 24, 23, 30),
      softReminderLeadMinutes: 45,
    );

    expect(summary.minutesUntilTarget, -35);
    expect(summary.progress, 1);
    expect(summary.recommendedStatus, BedtimeStatus.likelyLate);
    expect(
      summary.actions.map((action) => action.type),
      contains(BedtimeActionType.planRecoveryTomorrow),
    );
  });
}
