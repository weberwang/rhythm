import '../domain/bedtime_reminder_plan.dart';

/// 本地通知网关边界，隔离业务调度层与真实通知插件。
abstract class LocalNotificationGateway {
  /// 初始化通知插件，并注册点击回调。
  Future<void> initialize({
    required void Function(String? payload) onOpened,
  });

  /// 申请通知权限。
  Future<bool> requestPermission();

  /// 调度单条睡前提醒。
  Future<void> schedule(BedtimeReminderPlan plan);

  /// 清空现有睡前提醒。
  Future<void> cancelBedtimeReminders();
}

/// 提供阶段五默认使用的占位网关；真实平台接线后只替换此实现。
class NoopLocalNotificationGateway implements LocalNotificationGateway {
  @override
  Future<void> cancelBedtimeReminders() async {}

  @override
  Future<void> initialize({
    required void Function(String? payload) onOpened,
  }) async {}

  @override
  Future<bool> requestPermission() async {
    return true;
  }

  @override
  Future<void> schedule(BedtimeReminderPlan plan) async {}
}
