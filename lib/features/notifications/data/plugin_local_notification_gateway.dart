import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../domain/bedtime_reminder_plan.dart';
import 'local_notification_gateway.dart';
import 'timezone_gateway.dart';

/// 使用 `flutter_local_notifications` 实现本地通知网关。
class PluginLocalNotificationGateway implements LocalNotificationGateway {
  /// 创建插件通知网关。
  PluginLocalNotificationGateway({
    required FlutterLocalNotificationsPlugin plugin,
    required TimezoneGateway timezoneGateway,
  }) : _plugin = plugin,
       _timezoneGateway = timezoneGateway;

  final FlutterLocalNotificationsPlugin _plugin;
  final TimezoneGateway _timezoneGateway;
  bool _timezoneInitialized = false;

  @override
  Future<void> initialize({
    required void Function(String? payload) onOpened,
  }) async {
    final settings = InitializationSettings(
      android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: const DarwinInitializationSettings(),
      macOS: const DarwinInitializationSettings(),
    );
    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {
        onOpened(response.payload);
      },
    );
  }

  @override
  Future<bool> requestPermission() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      return await android?.requestNotificationsPermission() ?? true;
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final ios = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      return await ios?.requestPermissions(alert: true, badge: true, sound: true) ??
          true;
    }
    if (defaultTargetPlatform == TargetPlatform.macOS) {
      final macos = _plugin.resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>();
      return await macos?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          true;
    }
    return true;
  }

  @override
  Future<void> schedule(BedtimeReminderPlan plan) async {
    await _ensureTimezoneReady();
    final timezoneName = await _timezoneGateway.resolveLocalTimezoneName();
    final location = tz.getLocation(timezoneName);
    final scheduledDate = tz.TZDateTime.from(plan.scheduledAt, location);

    await _plugin.zonedSchedule(
      id: plan.id,
      title: plan.titleKey,
      body: plan.bodyKey,
      scheduledDate: scheduledDate,
      notificationDetails: NotificationDetails(
        android: const AndroidNotificationDetails(
          'bedtime_reminders',
          'Bedtime reminders',
          channelDescription: 'Gentle bedtime reminders',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: const DarwinNotificationDetails(
          interruptionLevel: InterruptionLevel.passive,
        ),
        macOS: const DarwinNotificationDetails(
          interruptionLevel: InterruptionLevel.passive,
        ),
      ),
      payload: plan.payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  @override
  Future<void> cancelBedtimeReminders() async {
    await _plugin.cancel(id: 1001);
    await _plugin.cancel(id: 1002);
  }

  /// 读取冷启动通知入口 payload，供启动层优先决定首屏去向。
  Future<String?> readLaunchPayload() async {
    final details = await _plugin.getNotificationAppLaunchDetails();
    if (details == null || !details.didNotificationLaunchApp) {
      return null;
    }
    return details.notificationResponse?.payload;
  }

  Future<void> _ensureTimezoneReady() async {
    if (_timezoneInitialized) {
      return;
    }
    tz.initializeTimeZones();
    final timezoneName = await _timezoneGateway.resolveLocalTimezoneName();
    tz.setLocalLocation(tz.getLocation(timezoneName));
    _timezoneInitialized = true;
  }
}
