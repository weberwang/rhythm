import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/features/onboarding_activation/domain/onboarding_activation_models.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

part 'onboarding_activation_notification_gateway.g.dart';

/// 首次激活阶段的提醒调度桥接。
class OnboardingActivationNotificationGateway {
  /// 创建提醒调度桥接。
  OnboardingActivationNotificationGateway({
    FlutterLocalNotificationsPlugin? notificationsPlugin,
  }) : _notificationsPlugin =
           notificationsPlugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  static const int _bedtimeReminderId = 4101;
  static bool _timezoneInitialized = false;
  static bool _pluginInitialized = false;

  /// 按 onboarding 当前设置应用提醒策略。
  Future<bool> applyReminderPlan(OnboardingActivationState state) async {
    try {
      await _ensureInitialized();

      if (state.reminderChoice == OnboardingReminderChoice.disabled) {
        await _notificationsPlugin.cancel(id: _bedtimeReminderId);
        return true;
      }

      await _requestPlatformPermissions();

      final location = await _resolveLocation();
      final scheduledDate = _nextReminderDate(state, location);
      final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'rhythm_bedtime_channel',
          'Bedtime reminders',
          channelDescription: 'Gentle reminders before your target bedtime.',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      );

      await _notificationsPlugin.zonedSchedule(
        id: _bedtimeReminderId,
        title: 'Rhythm',
        body: 'Start winding down for tonight.',
        scheduledDate: scheduledDate,
        notificationDetails: notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _ensureInitialized() async {
    if (_pluginInitialized) {
      return;
    }

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );

    await _notificationsPlugin.initialize(settings: initializationSettings);
    _pluginInitialized = true;
  }

  Future<void> _requestPlatformPermissions() async {
    if (kIsWeb) {
      return;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        await _notificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission();
        return;
      case TargetPlatform.iOS:
        await _notificationsPlugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, badge: true, sound: true);
        return;
      case TargetPlatform.macOS:
        await _notificationsPlugin
            .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, badge: true, sound: true);
        return;
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
        return;
    }
  }

  Future<tz.Location> _resolveLocation() async {
    if (!_timezoneInitialized) {
      tz_data.initializeTimeZones();
      _timezoneInitialized = true;
    }

    final timezoneInfo = await FlutterTimezone.getLocalTimezone();
    final location = tz.getLocation(timezoneInfo.identifier);
    tz.setLocalLocation(location);
    return location;
  }

  tz.TZDateTime _nextReminderDate(
    OnboardingActivationState state,
    tz.Location location,
  ) {
    final bedtimeHour = state.bedtimeHour;
    final reminderTime = DateTime(
      2000,
      1,
      1,
      bedtimeHour,
    ).subtract(Duration(minutes: state.reminderLeadMinutes));
    final now = tz.TZDateTime.now(location);

    var scheduled = tz.TZDateTime(
      location,
      now.year,
      now.month,
      now.day,
      reminderTime.hour,
      reminderTime.minute,
    );
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}

/// 提供首次激活提醒调度桥接。
@Riverpod(keepAlive: true)
OnboardingActivationNotificationGateway onboardingActivationNotificationGateway(
  Ref ref,
) {
  return OnboardingActivationNotificationGateway();
}
