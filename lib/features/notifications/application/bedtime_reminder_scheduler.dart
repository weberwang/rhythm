import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/notifications/data/local_notification_gateway.dart';
import 'package:rhythm/features/notifications/data/timezone_gateway.dart';
import 'package:rhythm/features/notifications/data/plugin_local_notification_gateway.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../domain/bedtime_reminder_plan.dart';
import '../domain/reminder_settings_state.dart';

/// 提供时区读取网关。
final timezoneGatewayProvider = Provider<TimezoneGateway>((ref) {
  return DeviceTimezoneGateway();
});

/// 提供本地通知网关，当前先用占位实现承接调度边界。
final localNotificationGatewayProvider = Provider<LocalNotificationGateway>((
  ref,
) {
  return NoopLocalNotificationGateway();
});

/// 聚合当前通知权限状态，避免页面层直接理解平台插件差异。
final notificationPermissionGrantedProvider =
    FutureProvider.autoDispose<bool>((ref) async {
      final gateway = ref.watch(localNotificationGatewayProvider);
      return gateway.isPermissionGranted();
    });

/// 提供睡前提醒调度器，集中承接提醒生成和插件调度逻辑。
final bedtimeReminderSchedulerProvider = Provider<BedtimeReminderScheduler>((
  ref,
) {
  return BedtimeReminderScheduler(
    notificationGateway: ref.watch(localNotificationGatewayProvider),
    timezoneGateway: ref.watch(timezoneGatewayProvider),
  );
});

/// 提供真实通知插件网关，供应用启动时注入统一调度链路。
final pluginLocalNotificationGatewayProvider =
    Provider<PluginLocalNotificationGateway>((ref) {
      return PluginLocalNotificationGateway(
        plugin: FlutterLocalNotificationsPlugin(),
        timezoneGateway: ref.watch(timezoneGatewayProvider),
      );
    });

/// 编排睡前提醒计划，确保默认温和且不连续强打扰。
class BedtimeReminderScheduler {
  /// 创建提醒调度器。
  BedtimeReminderScheduler({
    required LocalNotificationGateway notificationGateway,
    required TimezoneGateway timezoneGateway,
  }) : _notificationGateway = notificationGateway,
       _timezoneGateway = timezoneGateway;

  final LocalNotificationGateway _notificationGateway;
  final TimezoneGateway _timezoneGateway;

  /// 根据提醒设置和目标作息构建今晚提醒计划。
  List<BedtimeReminderPlan> buildPlans({
    required ReminderSettingsState settings,
    required GoalScheduleSettings goalSettings,
    required DateTime now,
  }) {
    final targetBedtime = _resolveTargetBedtime(now, goalSettings);
    final plans = <BedtimeReminderPlan>[];

    if (settings.softReminderEnabled) {
      plans.add(
        BedtimeReminderPlan(
          id: 1001,
          scheduledAt: targetBedtime.subtract(
            Duration(minutes: settings.leadMinutes),
          ),
          type: BedtimeReminderType.soft,
          titleKey: 'reminderSoftReminderTitle',
          bodyKey: 'reminderSoftReminderDescription',
          payload: 'rhythm://bedtime?source=soft_reminder',
        ),
      );
    }

    if (settings.targetReminderEnabled) {
      plans.add(
        BedtimeReminderPlan(
          id: 1002,
          scheduledAt: targetBedtime,
          type: BedtimeReminderType.targetTime,
          titleKey: 'reminderTargetReminderTitle',
          bodyKey: 'reminderTargetReminderDescription',
          payload: 'rhythm://bedtime?source=target_reminder',
        ),
      );
    }

    if (plans.length < 2) {
      return plans;
    }

    final sortedPlans = [...plans]
      ..sort((left, right) => left.scheduledAt.compareTo(right.scheduledAt));
    final gap = sortedPlans.last.scheduledAt
        .difference(sortedPlans.first.scheduledAt)
        .inMinutes;
    if (gap < 15) {
      return sortedPlans
          .where((plan) => plan.type == BedtimeReminderType.targetTime)
          .toList();
    }

    return sortedPlans;
  }

  /// 根据当前提醒草稿和已保存目标作息生成并下发计划。
  Future<List<BedtimeReminderPlan>> scheduleFromSettings({
    required ReminderSettingsState settings,
    required GoalScheduleSettings goalSettings,
    required DateTime now,
  }) async {
    await _timezoneGateway.resolveLocalTimezoneName();
    final plans = buildPlans(
      settings: settings,
      goalSettings: goalSettings,
      now: now,
    );
    await _notificationGateway.cancelBedtimeReminders();
    for (final plan in plans) {
      await _notificationGateway.schedule(plan);
    }
    return plans;
  }

  /// 使用 provider 当前状态调度提醒，供引导完成时直接调用。
  Future<List<BedtimeReminderPlan>> scheduleForCurrentSettings({
    required ReminderSettingsState settings,
    required GoalScheduleSettings? goalSettings,
    required DateTime now,
  }) async {
    if (goalSettings == null) {
      return <BedtimeReminderPlan>[];
    }
    return scheduleFromSettings(
      settings: settings,
      goalSettings: goalSettings,
      now: now,
    );
  }

  /// 结合当前时间和业务日定义目标入睡时间，正确处理跨午夜目标。
  DateTime _resolveTargetBedtime(
    DateTime now,
    GoalScheduleSettings goalSettings,
  ) {
    final targetHour = goalSettings.targetBedtimeMinutes ~/ 60;
    final targetMinute = goalSettings.targetBedtimeMinutes % 60;
    var target = DateTime(
      now.year,
      now.month,
      now.day,
      targetHour,
      targetMinute,
    );
    final nowMinutes = now.hour * 60 + now.minute;
    if (goalSettings.targetBedtimeMinutes < goalSettings.dayStartMinutes &&
        nowMinutes >= goalSettings.dayStartMinutes) {
      target = target.add(const Duration(days: 1));
    }
    return target;
  }
}
