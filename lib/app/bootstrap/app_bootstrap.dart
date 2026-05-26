import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/notifications/application/bedtime_reminder_scheduler.dart';
import '../../features/notifications/data/plugin_local_notification_gateway.dart';
import '../../features/notifications/data/timezone_gateway.dart';
import '../../features/widget_bridge/application/widget_launch_gateway.dart';
import '../rhythm_app.dart';
import 'bootstrap_launch_entry.dart';
import 'launch_state_provider.dart';
import 'supabase_bootstrap.dart';

/// 启动 Rhythm App，并集中完成首屏所需的基础依赖装配。
Future<void> bootstrapApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final supabaseBootstrapState = await initializeSupabaseBootstrap();
  final notificationGateway = PluginLocalNotificationGateway(
    plugin: FlutterLocalNotificationsPlugin(),
    timezoneGateway: DeviceTimezoneGateway(),
  );
  await notificationGateway.initialize(onOpened: (_) {});
  final launchEntry = await resolveBootstrapLaunchEntry(
    notificationGateway: notificationGateway,
    widgetLaunchGateway: HomeWidgetLaunchGateway(),
  );

  runApp(
    ProviderScope(
      overrides: [
        // 启动阶段先注入持久化依赖，避免路由分发时重复异步获取实例。
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        bootstrapLaunchEntryProvider.overrideWithValue(launchEntry),
        // 启动期注入同一个真实通知网关，确保设置页申请权限与后续调度共用一套插件实例。
        localNotificationGatewayProvider.overrideWithValue(notificationGateway),
        // 将启动期解析出的 Supabase 状态注入全局，供同步链路直接消费。
        supabaseBootstrapStateProvider.overrideWithValue(
          supabaseBootstrapState,
        ),
      ],
      child: const RhythmApp(),
    ),
  );
}
