import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../router/app_router.dart';
import '../../features/notifications/application/notification_entry_controller.dart';
import '../../features/notifications/data/plugin_local_notification_gateway.dart';
import '../../features/widget_bridge/application/widget_entry_controller.dart';
import '../../features/widget_bridge/application/widget_launch_gateway.dart';

/// 启动入口目标类型，决定冷启动后优先进入的页面。
enum BootstrapEntryTarget {
  /// 默认进入正常启动分发。
  defaultFlow,

  /// 直接进入今日页。
  today,

  /// 直接进入睡前模式。
  bedtime,
}

/// 承载启动层解析后的首屏目标，避免把插件结果直接暴露给路由层。
class BootstrapLaunchEntry {
  /// 创建启动入口结果。
  const BootstrapLaunchEntry({
    required this.target,
  });

  /// 冷启动后优先进入的目标。
  final BootstrapEntryTarget target;
}

/// 提供启动入口状态，供 LaunchGate 决定默认分发前是否优先跳转睡前模式。
final bootstrapLaunchEntryProvider = Provider<BootstrapLaunchEntry>((ref) {
  return const BootstrapLaunchEntry(target: BootstrapEntryTarget.defaultFlow);
});

/// 解析通知和小组件冷启动入口，统一产出首屏目标。
Future<BootstrapLaunchEntry> resolveBootstrapLaunchEntry({
  required PluginLocalNotificationGateway notificationGateway,
  required WidgetLaunchGateway widgetLaunchGateway,
}) async {
  final notificationEntryController = NotificationEntryController();
  final notificationPayload = await notificationGateway.readLaunchPayload();
  if (notificationEntryController.resolve(notificationPayload) != null) {
    return const BootstrapLaunchEntry(target: BootstrapEntryTarget.bedtime);
  }

  final widgetEntryController = WidgetEntryController();
  final widgetUri = await widgetLaunchGateway.readInitialEntry();
  final widgetEntry = widgetEntryController.resolve(widgetUri);
  if (widgetEntry?.path == RhythmTab.today.path) {
    return const BootstrapLaunchEntry(target: BootstrapEntryTarget.today);
  }
  if (widgetEntry?.path == bedtimeModePath) {
    return const BootstrapLaunchEntry(target: BootstrapEntryTarget.bedtime);
  }

  return const BootstrapLaunchEntry(target: BootstrapEntryTarget.defaultFlow);
}
