import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/goal_schedule/domain/repositories/goal_schedule_settings_repository.dart';
import 'package:rhythm/features/notifications/application/bedtime_reminder_scheduler.dart';
import 'package:rhythm/features/notifications/data/local_notification_gateway.dart';
import 'package:rhythm/features/notifications/data/timezone_gateway.dart';
import 'package:rhythm/features/notifications/domain/bedtime_reminder_plan.dart';
import 'package:rhythm/features/notifications/domain/reminder_settings_state.dart';
import 'package:rhythm/features/notifications/presentation/notification_settings_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证提醒设置页只展示一处提前量配置，并在保存时触发调度。
void main() {
  testWidgets('提醒设置页展示标题并在保存时触发调度', (tester) async {
    final scheduler = _FakeBedtimeReminderScheduler();
    final notificationGateway = _FakeLocalNotificationGateway(
      permissionGranted: true,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          goalScheduleSettingsRepositoryProvider.overrideWithValue(
            _FakeGoalScheduleSettingsRepository(
              const GoalScheduleSettings(
                targetBedtimeMinutes: 23 * 60 + 30,
                targetWakeMinutes: 7 * 60 + 30,
                lateThresholdMinutes: 30,
                dayStartMinutes: 4 * 60,
              ),
            ),
          ),
          bedtimeReminderSchedulerProvider.overrideWithValue(scheduler),
          localNotificationGatewayProvider.overrideWithValue(notificationGateway),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: NotificationSettingsPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('让提醒保持温和'), findsOneWidget);
    expect(find.text('保存提醒策略'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
    expect(find.text('通知权限已开启'), findsOneWidget);
    // 页面底部不应再额外渲染静态提前量提示卡，只保留真实可交互的下拉入口。
    expect(find.text('提前量'), findsNothing);
    expect(find.byKey(const Key('lead-minutes-dropdown')), findsOneWidget);

    await tester.tap(find.text('保存提醒策略'));
    await tester.pumpAndSettle();

    expect(scheduler.scheduleCalled, isTrue);
  });

  testWidgets('保存提醒策略时会先申请通知权限并刷新状态', (tester) async {
    final scheduler = _FakeBedtimeReminderScheduler();
    final notificationGateway = _FakeLocalNotificationGateway(
      permissionGranted: false,
      permissionAfterRequest: true,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          goalScheduleSettingsRepositoryProvider.overrideWithValue(
            _FakeGoalScheduleSettingsRepository(
              const GoalScheduleSettings(
                targetBedtimeMinutes: 23 * 60 + 30,
                targetWakeMinutes: 7 * 60 + 30,
                lateThresholdMinutes: 30,
                dayStartMinutes: 4 * 60,
              ),
            ),
          ),
          bedtimeReminderSchedulerProvider.overrideWithValue(scheduler),
          localNotificationGatewayProvider.overrideWithValue(notificationGateway),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: NotificationSettingsPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('通知权限未开启'), findsOneWidget);

    await tester.tap(find.text('保存提醒策略'));
    await tester.pumpAndSettle();

    expect(notificationGateway.requestPermissionCalled, isTrue);
    expect(scheduler.scheduleCalled, isTrue);
    expect(find.text('通知权限已开启'), findsOneWidget);
  });

  testWidgets('页面恢复前台后会自动刷新通知权限状态', (tester) async {
    final scheduler = _FakeBedtimeReminderScheduler();
    final notificationGateway = _FakeLocalNotificationGateway(
      permissionGranted: false,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          goalScheduleSettingsRepositoryProvider.overrideWithValue(
            _FakeGoalScheduleSettingsRepository(
              const GoalScheduleSettings(
                targetBedtimeMinutes: 23 * 60 + 30,
                targetWakeMinutes: 7 * 60 + 30,
                lateThresholdMinutes: 30,
                dayStartMinutes: 4 * 60,
              ),
            ),
          ),
          bedtimeReminderSchedulerProvider.overrideWithValue(scheduler),
          localNotificationGatewayProvider.overrideWithValue(notificationGateway),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: NotificationSettingsPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('通知权限未开启'), findsOneWidget);

    notificationGateway.permissionGranted = true;
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    expect(find.text('通知权限已开启'), findsOneWidget);
  });
}

/// 提供提醒设置页测试用目标作息仓储，避免保存时读取真实持久化依赖。
class _FakeGoalScheduleSettingsRepository
    extends GoalScheduleSettingsRepository {
  _FakeGoalScheduleSettingsRepository(this._settings);

  final GoalScheduleSettings? _settings;

  @override
  Future<GoalScheduleSettings?> read() async => _settings;

  @override
  Future<void> save(GoalScheduleSettings settings) async {}
}

/// 提供提醒设置页测试调度器，避免页面测试依赖真实通知插件。
class _FakeBedtimeReminderScheduler extends BedtimeReminderScheduler {
  _FakeBedtimeReminderScheduler()
    : super(
        notificationGateway: _FakeLocalNotificationGateway(
          permissionGranted: true,
        ),
        timezoneGateway: _NoopTimezoneGateway(),
      );

  bool scheduleCalled = false;

  @override
  Future<List<BedtimeReminderPlan>> scheduleForCurrentSettings({
    required ReminderSettingsState settings,
    required GoalScheduleSettings? goalSettings,
    required DateTime now,
  }) async {
    scheduleCalled = true;
    return <BedtimeReminderPlan>[];
  }
}

/// 提供提醒设置页测试用通知网关，覆盖权限查询与申请链路。
class _FakeLocalNotificationGateway implements LocalNotificationGateway {
  _FakeLocalNotificationGateway({
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

/// 提供提醒设置页测试用时区网关，避免依赖真实平台时区。
class _NoopTimezoneGateway implements TimezoneGateway {
  @override
  Future<String> resolveLocalTimezoneName() async {
    return 'Asia/Shanghai';
  }
}
