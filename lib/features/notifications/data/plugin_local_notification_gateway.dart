import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../domain/bedtime_reminder_plan.dart';
import 'local_notification_gateway.dart';
import 'timezone_gateway.dart';

/// Windows 桌面通知初始化必须提供应用标识，否则插件会在启动阶段直接抛异常。
const WindowsInitializationSettings _windowsInitializationSettings =
    WindowsInitializationSettings(
      appName: 'rhythm',
      appUserModelId: 'com.example.rhythm',
      guid: '8d9d2b5d-6f7f-4d0f-9c76-6c7f2e9c4c18',
    );

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
      iOS: const DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
      macOS: const DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
      windows: _windowsInitializationSettings,
    );
    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {
        onOpened(response.payload);
      },
    );
  }

  @override
  Future<bool> isPermissionGranted() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      return await android?.areNotificationsEnabled() ?? true;
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final ios = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      return (await ios?.checkPermissions())?.isEnabled ?? false;
    }
    if (defaultTargetPlatform == TargetPlatform.macOS) {
      final macos = _plugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >();
      return (await macos?.checkPermissions())?.isEnabled ?? false;
    }
    return true;
  }

  @override
  Future<bool> requestPermission() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      return await android?.requestNotificationsPermission() ?? true;
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final ios = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      return await ios?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          true;
    }
    if (defaultTargetPlatform == TargetPlatform.macOS) {
      final macos = _plugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >();
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
    try {
      await _scheduleWithMode(
        plan: plan,
        scheduledDate: scheduledDate,
        scheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } on PlatformException catch (error) {
      if (!_shouldFallbackToInexactMode(error)) {
        rethrow;
      }
      // Android 14+ 若未授予 exact alarm 权限会直接抛错，这里降级为非精确定时以保证首启流程不崩溃。
      await _scheduleWithMode(
        plan: plan,
        scheduledDate: scheduledDate,
        scheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    }
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

  /// 使用指定调度模式下发本地通知，便于在权限受限时按平台能力降级。
  Future<void> _scheduleWithMode({
    required BedtimeReminderPlan plan,
    required tz.TZDateTime scheduledDate,
    required AndroidScheduleMode scheduleMode,
  }) {
    return _plugin.zonedSchedule(
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
      androidScheduleMode: scheduleMode,
    );
  }

  /// 仅在 Android 精确定时权限被系统拒绝时回退，其他异常仍保留原始失败以便上层感知。
  bool _shouldFallbackToInexactMode(PlatformException error) {
    return defaultTargetPlatform == TargetPlatform.android &&
        error.code == 'exact_alarms_not_permitted';
  }
}
