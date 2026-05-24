import 'package:rhythm/app/router/app_router.dart';

import '../domain/widget_entry_source.dart';

/// 承载一次小组件打开后的目标路由和来源信息。
class WidgetRouteEntry {
  /// 创建小组件路由入口。
  const WidgetRouteEntry({
    required this.path,
    required this.source,
  });

  /// 目标路由路径。
  final String path;

  /// 小组件入口来源。
  final WidgetEntrySource source;
}

/// 解析小组件入口 Uri，统一收口到睡前模式的跳转契约。
class WidgetEntryController {
  /// 解析小组件 Uri，只有明确的 bedtime shortcut 才会产生跳转。
  WidgetRouteEntry? resolve(Uri? uri) {
    if (uri == null || uri.host != 'bedtime') {
      return null;
    }

    if (uri.queryParameters['source'] == 'widget_bedtime_shortcut') {
      return const WidgetRouteEntry(
        path: bedtimeModePath,
        source: WidgetEntrySource.bedtimeShortcut,
      );
    }

    return null;
  }
}
