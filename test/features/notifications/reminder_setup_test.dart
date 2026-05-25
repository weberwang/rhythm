import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/notifications/application/bedtime_reminder_scheduler.dart';
import 'package:rhythm/features/notifications/data/local_notification_gateway.dart';
import 'package:rhythm/features/notifications/data/timezone_gateway.dart';
import 'package:rhythm/features/notifications/domain/bedtime_reminder_plan.dart';
import 'package:rhythm/features/notifications/domain/reminder_settings_state.dart';

import '../../support/test_app.dart';

/// 验证提醒策略默认状态与首次引导完成链路。
void main() {
  test('提醒策略默认值符合 MVP 预期', () {
    const state = ReminderSettingsState();

    expect(state.softReminderEnabled, isTrue);
    expect(state.targetReminderEnabled, isFalse);
    expect(state.weeklyReportEnabled, isTrue);
    expect(state.leadMinutes, 45);
  });

  testWidgets('提醒策略保存后先进入小组件引导页，再进入今日页', (tester) async {
    final scheduler = _TestBedtimeReminderScheduler();
    await pumpRhythmApp(
      tester,
      onboardingCompleted: false,
      overrides: [
        bedtimeReminderSchedulerProvider.overrideWithValue(scheduler),
      ],
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('开始建立我的作息目标'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('匿名进入'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('先用手动模式'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存目标，继续下一步'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('完成设置，进入今日页'));
    await tester.pumpAndSettle();

    expect(find.text('让睡前入口更近一点，不用每次都先打开 App。'), findsOneWidget);

    await tester.tap(find.text('知道了，稍后我自己加'));
    await tester.pumpAndSettle();

    expect(find.text('今日'), findsWidgets);
    expect(scheduler.scheduleCalled, isTrue);
  });

  testWidgets('提醒策略页支持切换开关和修改提前量', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    await tester.tap(find.text('开始建立我的作息目标'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('匿名进入'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('先用手动模式'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存目标，继续下一步'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('target-reminder-switch')));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const Key('lead-minutes-dropdown')));
    await tester.tap(find.byKey(const Key('lead-minutes-dropdown')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('60').last);
    await tester.tap(find.text('60').last, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(find.text('在目标入睡前 60 分钟提醒'), findsOneWidget);
  });
}

/// 预留提醒调度断言使用的测试调度器，后续阶段五接入完成后应被页面调用。
class _TestBedtimeReminderScheduler extends BedtimeReminderScheduler {
  _TestBedtimeReminderScheduler()
      : super(
          notificationGateway: _NoopNotificationGateway(),
          timezoneGateway: _NoopTimezoneGateway(),
        );

  bool scheduleCalled = false;

  @override
  Future<List<BedtimeReminderPlan>> scheduleFromSettings({
    required ReminderSettingsState settings,
    required GoalScheduleSettings goalSettings,
    required DateTime now,
  }) async {
    scheduleCalled = true;
    return <BedtimeReminderPlan>[];
  }
}

class _NoopNotificationGateway implements LocalNotificationGateway {
  @override
  Future<void> cancelBedtimeReminders() async {}

  @override
  Future<void> initialize({
    required void Function(String? payload) onOpened,
  }) async {}

  @override
  Future<bool> requestPermission() async {
    return true;
  }

  @override
  Future<void> schedule(BedtimeReminderPlan plan) async {}
}

class _NoopTimezoneGateway implements TimezoneGateway {
  @override
  Future<String> resolveLocalTimezoneName() async {
    return 'Asia/Shanghai';
  }
}
