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
    final notificationGateway = _FakeNotificationGateway(
      permissionGranted: false,
      permissionAfterRequest: true,
    );
    await pumpRhythmApp(
      tester,
      onboardingCompleted: false,
      overrides: [
        bedtimeReminderSchedulerProvider.overrideWithValue(scheduler),
        localNotificationGatewayProvider.overrideWithValue(notificationGateway),
      ],
    );
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
    await tester.ensureVisible(find.text('按这个继续'));
    await tester.tap(find.text('按这个继续'));
    await tester.pumpAndSettle();

    expect(find.text('把今晚的目标放到桌面上'), findsOneWidget);
    expect(notificationGateway.requestPermissionCalled, isTrue);

    await tester.ensureVisible(find.text('以后再说'));
    await tester.tap(find.text('以后再说'));
    await tester.pumpAndSettle();

    expect(find.text('今日'), findsWidgets);
    expect(scheduler.scheduleCalled, isTrue);
  });

  testWidgets('提醒策略页支持切换提醒方式', (tester) async {
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

    await tester.tap(find.byKey(const Key('reminder-mode-standard')));
    await tester.pumpAndSettle();

    expect(find.text('标准提醒'), findsWidgets);
  });
}

/// 预留提醒调度断言使用的测试调度器，后续阶段五接入完成后应被页面调用。
class _TestBedtimeReminderScheduler extends BedtimeReminderScheduler {
  _TestBedtimeReminderScheduler()
    : super(
        notificationGateway: _FakeNotificationGateway(permissionGranted: true),
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

/// 提供引导页测试用通知网关，确保权限申请与状态读取都可验证。
class _FakeNotificationGateway implements LocalNotificationGateway {
  _FakeNotificationGateway({
    required this.permissionGranted,
    bool? permissionAfterRequest,
  }) : _permissionAfterRequest = permissionAfterRequest ?? permissionGranted;

  bool permissionGranted;
  final bool _permissionAfterRequest;
  bool requestPermissionCalled = false;

  @override
  Future<void> cancelBedtimeReminders() async {}

  @override
  Future<void> initialize({
    required void Function(String? payload) onOpened,
  }) async {}

  @override
  Future<bool> isPermissionGranted() async => permissionGranted;

  @override
  Future<bool> requestPermission() async {
    requestPermissionCalled = true;
    permissionGranted = _permissionAfterRequest;
    return permissionGranted;
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
