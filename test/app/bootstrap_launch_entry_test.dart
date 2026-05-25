import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/bootstrap/bootstrap_launch_entry.dart';
import 'package:rhythm/features/notifications/data/plugin_local_notification_gateway.dart';
import 'package:rhythm/features/notifications/data/timezone_gateway.dart';
import 'package:rhythm/features/widget_bridge/application/widget_launch_gateway.dart';

/// 验证冷启动时会按通知和小组件入口统一分发首屏目标。
void main() {
  test('通知入口优先进入睡前模式', () async {
    final entry = await resolveBootstrapLaunchEntry(
      notificationGateway: _FakeNotificationGateway(
        'rhythm://bedtime?source=soft_reminder',
      ),
      widgetLaunchGateway: _FakeWidgetLaunchGateway(
        Uri.parse('rhythm://today?source=widget_today'),
      ),
    );

    expect(entry.target, BootstrapEntryTarget.bedtime);
  });

  test('today 小组件入口进入今日页', () async {
    final entry = await resolveBootstrapLaunchEntry(
      notificationGateway: _FakeNotificationGateway(null),
      widgetLaunchGateway: _FakeWidgetLaunchGateway(
        Uri.parse('rhythm://today?source=widget_today'),
      ),
    );

    expect(entry.target, BootstrapEntryTarget.today);
  });

  test('bedtime 小组件入口进入睡前模式', () async {
    final entry = await resolveBootstrapLaunchEntry(
      notificationGateway: _FakeNotificationGateway(null),
      widgetLaunchGateway: _FakeWidgetLaunchGateway(
        Uri.parse('rhythm://bedtime?source=widget_bedtime_shortcut'),
      ),
    );

    expect(entry.target, BootstrapEntryTarget.bedtime);
  });
}

/// 提供测试用通知网关，避免依赖真实通知插件。
class _FakeNotificationGateway extends PluginLocalNotificationGateway {
  _FakeNotificationGateway(this.payload)
    : super(
        plugin: FlutterLocalNotificationsPlugin(),
        timezoneGateway: _FakeTimezoneGateway(),
      );

  final String? payload;

  @override
  Future<String?> readLaunchPayload() async => payload;
}

/// 提供测试用小组件启动网关，避免依赖真实插件。
class _FakeWidgetLaunchGateway implements WidgetLaunchGateway {
  const _FakeWidgetLaunchGateway(this.uri);

  final Uri? uri;

  @override
  Future<Uri?> readInitialEntry() async => uri;
}

/// 提供测试用时区网关，避免构造真实平台依赖。
class _FakeTimezoneGateway implements TimezoneGateway {
  @override
  Future<String> resolveLocalTimezoneName() async => 'Asia/Shanghai';
}
