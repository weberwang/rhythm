import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/notifications/application/bedtime_reminder_scheduler.dart';
import 'package:rhythm/features/notifications/data/local_notification_gateway.dart';
import 'package:rhythm/features/notifications/data/timezone_gateway.dart';
import 'package:rhythm/features/notifications/domain/bedtime_reminder_plan.dart';
import 'package:rhythm/features/notifications/domain/reminder_settings_state.dart';

/// 验证睡前提醒调度规则，确保默认温和且避免连续强打扰。
void main() {
  const settings = GoalScheduleSettings(
    targetBedtimeMinutes: 23 * 60 + 30,
    targetWakeMinutes: 7 * 60 + 30,
    lateThresholdMinutes: 30,
    dayStartMinutes: 4 * 60,
  );

  test('默认只开启柔性提醒时只生成一条柔性提醒', () {
    final scheduler = BedtimeReminderScheduler(
      notificationGateway: _MemoryNotificationGateway(),
      timezoneGateway: _FixedTimezoneGateway(),
    );

    final plans = scheduler.buildPlans(
      settings: const ReminderSettingsState(),
      goalSettings: settings,
      now: DateTime(2026, 5, 24, 20, 0),
    );

    expect(plans, hasLength(1));
    expect(plans.first.type, BedtimeReminderType.soft);
    expect(plans.first.scheduledAt, DateTime(2026, 5, 24, 22, 45));
  });

  test('开启到点提醒时生成柔性提醒和到点提醒', () {
    final scheduler = BedtimeReminderScheduler(
      notificationGateway: _MemoryNotificationGateway(),
      timezoneGateway: _FixedTimezoneGateway(),
    );

    final plans = scheduler.buildPlans(
      settings: const ReminderSettingsState(
        targetReminderEnabled: true,
      ),
      goalSettings: settings,
      now: DateTime(2026, 5, 24, 20, 0),
    );

    expect(plans, hasLength(2));
    expect(plans.map((plan) => plan.type), [
      BedtimeReminderType.soft,
      BedtimeReminderType.targetTime,
    ]);
  });

  test('两条提醒间隔过近时只保留到点提醒', () {
    final scheduler = BedtimeReminderScheduler(
      notificationGateway: _MemoryNotificationGateway(),
      timezoneGateway: _FixedTimezoneGateway(),
    );

    final plans = scheduler.buildPlans(
      settings: const ReminderSettingsState(
        targetReminderEnabled: true,
        leadMinutes: 10,
      ),
      goalSettings: settings,
      now: DateTime(2026, 5, 24, 22, 0),
    );

    expect(plans, hasLength(1));
    expect(plans.first.type, BedtimeReminderType.targetTime);
  });

  test('目标时间跨午夜时调度到正确业务日期', () {
    final scheduler = BedtimeReminderScheduler(
      notificationGateway: _MemoryNotificationGateway(),
      timezoneGateway: _FixedTimezoneGateway(),
    );
    const overnightSettings = GoalScheduleSettings(
      targetBedtimeMinutes: 30,
      targetWakeMinutes: 7 * 60 + 30,
      lateThresholdMinutes: 30,
      dayStartMinutes: 4 * 60,
    );

    final plans = scheduler.buildPlans(
      settings: const ReminderSettingsState(),
      goalSettings: overnightSettings,
      now: DateTime(2026, 5, 24, 23, 0),
    );

    expect(plans.first.scheduledAt, DateTime(2026, 5, 24, 23, 45));
  });
}

class _MemoryNotificationGateway implements LocalNotificationGateway {
  final List<BedtimeReminderPlan> scheduledPlans = <BedtimeReminderPlan>[];

  @override
  Future<void> cancelBedtimeReminders() async {
    scheduledPlans.clear();
  }

  @override
  Future<void> initialize({
    required void Function(String? payload) onOpened,
  }) async {}

  @override
  Future<bool> requestPermission() async {
    return true;
  }

  @override
  Future<void> schedule(BedtimeReminderPlan plan) async {
    scheduledPlans.add(plan);
  }
}

class _FixedTimezoneGateway implements TimezoneGateway {
  @override
  Future<String> resolveLocalTimezoneName() async {
    return 'Asia/Shanghai';
  }
}
