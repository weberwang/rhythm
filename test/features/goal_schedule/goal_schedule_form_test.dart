import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_form_state.dart';

/// 验证目标作息表单状态会提供默认值与基础校验。
void main() {
  test('目标入睡时间与起床时间相同时返回校验错误', () {
    const state = GoalScheduleFormState(
      bedtimeHour: 23,
      bedtimeMinute: 30,
      wakeHour: 23,
      wakeMinute: 30,
    );

    expect(
      state.validate().wakeTimeError,
      GoalScheduleValidationError.sameAsBedtime,
    );
  });

  test('默认表单值落在 MVP 计划约定范围内', () {
    const state = GoalScheduleFormState();

    expect(state.bedtimeHour, 23);
    expect(state.bedtimeMinute, 30);
    expect(state.wakeHour, 7);
    expect(state.wakeMinute, 30);
    expect(state.lateThresholdMinutes, 30);
    expect(state.dayStartHour, 4);
    expect(state.dayStartMinute, 0);
  });
}
