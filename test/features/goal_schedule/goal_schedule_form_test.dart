import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_form_controller.dart';
import 'package:rhythm/features/goal_schedule/data/goal_schedule_settings_repository.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_form_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../support/test_app.dart';

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

  test('控制器提交时会把相同的起床时间校验为错误状态', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final controller = container.read(
      goalScheduleFormControllerProvider.notifier,
    );

    controller.updateWakeTime(hour: 23, minute: 30);

    final success = controller.submit();

    expect(success, isFalse);
    expect(
      container.read(goalScheduleFormControllerProvider).wakeTimeError,
      GoalScheduleValidationError.sameAsBedtime,
    );
  });

  testWidgets('目标作息页保存后会进入提醒策略页', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('开始设置'));
    await tester.tap(find.text('开始设置'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('使用匿名继续'));
    await tester.tap(find.text('使用匿名继续'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('先手动记录'));
    await tester.tap(find.text('先手动记录'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('这样开始'));
    await tester.tap(find.text('这样开始'));
    await tester.pumpAndSettle();

    expect(find.text('提醒我在夜晚轻一点停下来'), findsOneWidget);
  });

  testWidgets('目标作息页保存后会持久化目标配置', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('开始设置'));
    await tester.tap(find.text('开始设置'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('使用匿名继续'));
    await tester.tap(find.text('使用匿名继续'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('先手动记录'));
    await tester.tap(find.text('先手动记录'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('这样开始'));
    await tester.tap(find.text('这样开始'));
    await tester.pumpAndSettle();

    final preferences = await SharedPreferences.getInstance();

    expect(
      preferences.getInt(
        SharedPreferencesGoalScheduleSettingsRepository.targetBedtimeMinutesKey,
      ),
      23 * 60 + 30,
    );
    expect(
      preferences.getInt(
        SharedPreferencesGoalScheduleSettingsRepository.targetWakeMinutesKey,
      ),
      7 * 60 + 30,
    );
    expect(
      preferences.getInt(
        SharedPreferencesGoalScheduleSettingsRepository.lateThresholdMinutesKey,
      ),
      30,
    );
    expect(
      preferences.getInt(
        SharedPreferencesGoalScheduleSettingsRepository.dayStartMinutesKey,
      ),
      4 * 60,
    );
  });
}
