import 'package:rhythm/app/router/app_router.dart';

import '../domain/notification_open_source.dart';

/// 承载一次通知打开后的目标路由和来源信息。
class NotificationRouteEntry {
  /// 创建通知路由入口。
  const NotificationRouteEntry({
    required this.path,
    required this.source,
  });

  /// 目标路由路径。
  final String path;

  /// 通知来源。
  final NotificationOpenSource source;
}

/// 解析通知 payload，避免路由层散落字符串判断。
class NotificationEntryController {
  /// 将通知 payload 解析成稳定的路由入口。
  NotificationRouteEntry? resolve(String? payload) {
    if (payload == null || payload.isEmpty) {
      return null;
    }

    final uri = Uri.tryParse(payload);
    if (uri == null || uri.host != 'bedtime') {
      return null;
    }

    switch (uri.queryParameters['source']) {
      case 'soft_reminder':
        return const NotificationRouteEntry(
          path: bedtimeModePath,
          source: NotificationOpenSource.softReminder,
        );
      case 'target_reminder':
        return const NotificationRouteEntry(
          path: bedtimeModePath,
          source: NotificationOpenSource.targetReminder,
        );
      default:
        return null;
    }
  }
}
