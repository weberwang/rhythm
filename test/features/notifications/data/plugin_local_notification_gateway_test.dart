import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/notifications/data/plugin_local_notification_gateway.dart';
import 'package:rhythm/features/notifications/data/timezone_gateway.dart';
import 'package:rhythm/features/notifications/domain/bedtime_reminder_plan.dart';

/// 验证真实通知网关在 Android 精确定时权限被拒时会自动降级为非精确定时。
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  AndroidFlutterLocalNotificationsPlugin.registerWith();

  const MethodChannel channel = MethodChannel(
    'dexterous.com/flutter/local_notifications',
  );

  late FlutterLocalNotificationsPlugin plugin;
  late PluginLocalNotificationGateway gateway;
  late List<MethodCall> log;

  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    plugin = FlutterLocalNotificationsPlugin();
    gateway = PluginLocalNotificationGateway(
      plugin: plugin,
      timezoneGateway: _FakeTimezoneGateway(),
    );
    log = <MethodCall>[];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (methodCall) async {
          log.add(methodCall);
          if (methodCall.method != 'zonedSchedule') {
            return null;
          }

          final arguments = methodCall.arguments as Map<dynamic, dynamic>;
          final platformSpecifics =
              arguments['platformSpecifics'] as Map<dynamic, dynamic>;
          final scheduleMode = platformSpecifics['scheduleMode'] as String;
          if (scheduleMode == 'exactAllowWhileIdle' &&
              log.where((call) => call.method == 'zonedSchedule').length == 1) {
            throw PlatformException(
              code: 'exact_alarms_not_permitted',
              message: 'Exact alarms are not permitted',
            );
          }
          return null;
        });
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('schedule 在 exact alarm 被拒时回退到 inexactAllowWhileIdle', () async {
    await gateway.schedule(
      BedtimeReminderPlan(
        id: 1001,
        scheduledAt: DateTime(2026, 6, 1, 22, 0),
        type: BedtimeReminderType.soft,
        titleKey: 'title',
        bodyKey: 'body',
        payload: 'payload',
      ),
    );

    final scheduleCalls = log.where((call) => call.method == 'zonedSchedule');
    expect(scheduleCalls.length, 2);

    final firstArguments =
        scheduleCalls.first.arguments as Map<dynamic, dynamic>;
    final secondArguments =
        scheduleCalls.last.arguments as Map<dynamic, dynamic>;
    expect(
      (firstArguments['platformSpecifics']
          as Map<dynamic, dynamic>)['scheduleMode'],
      'exactAllowWhileIdle',
    );
    expect(
      (secondArguments['platformSpecifics']
          as Map<dynamic, dynamic>)['scheduleMode'],
      'inexactAllowWhileIdle',
    );
  });
}

/// 提供测试用固定时区，避免单测依赖真实设备时区。
class _FakeTimezoneGateway implements TimezoneGateway {
  @override
  Future<String> resolveLocalTimezoneName() async {
    return 'Asia/Shanghai';
  }
}
