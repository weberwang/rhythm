import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/notifications/data/plugin_local_notification_gateway.dart';
import '../../features/notifications/data/timezone_gateway.dart';
import '../../features/widget_bridge/application/widget_launch_gateway.dart';
import '../rhythm_app.dart';
import 'bootstrap_launch_entry.dart';
import 'launch_state_provider.dart';
import 'supabase_bootstrap.dart';

/// 启动 Rhythm App，并集中放置后续初始化依赖的入口。
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
        // 启动阶段先注入持久化依赖，避免在路由分发时重复异步获取实例。
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        bootstrapLaunchEntryProvider.overrideWithValue(launchEntry),
        supabaseBootstrapStateProvider.overrideWithValue(
          supabaseBootstrapState,
        ),
      ],
      child: const RhythmApp(),
    ),
  );
}
