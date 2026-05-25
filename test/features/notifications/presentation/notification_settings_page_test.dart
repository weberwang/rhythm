import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

/// 验证提醒设置页会展示提醒策略，并在保存时触发调度。
void main() {
  testWidgets('提醒设置页展示标题并在保存时触发调度', (tester) async {
    final scheduler = _FakeBedtimeReminderScheduler();

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

    await tester.tap(find.text('保存提醒策略'));
    await tester.pumpAndSettle();

    expect(scheduler.scheduleCalled, isTrue);
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
        notificationGateway: _NoopLocalNotificationGateway(),
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

/// 提供提醒设置页测试用通知网关，避免真实插件初始化干扰。
class _NoopLocalNotificationGateway implements LocalNotificationGateway {
  @override
  Future<void> cancelBedtimeReminders() async {}

  @override
  Future<void> initialize({
    required void Function(String? payload) onOpened,
  }) async {}

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<void> schedule(BedtimeReminderPlan plan) async {}
}

/// 提供提醒设置页测试用时区网关，避免页面测试依赖真实平台时区。
class _NoopTimezoneGateway implements TimezoneGateway {
  @override
  Future<String> resolveLocalTimezoneName() async {
    return 'Asia/Shanghai';
  }
}
