import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/notifications/application/notification_entry_controller.dart';
import 'package:rhythm/features/notifications/domain/notification_open_source.dart';

/// 验证通知 payload 会被解析成睡前页入口和稳定来源。
void main() {
  test('柔性提醒 payload 会跳到睡前页', () {
    final controller = NotificationEntryController();

    final entry = controller.resolve('rhythm://bedtime?source=soft_reminder');

    expect(entry, isNotNull);
    expect(entry?.path, bedtimeModePath);
    expect(entry?.source, NotificationOpenSource.softReminder);
  });

  test('到点提醒 payload 会跳到睡前页', () {
    final controller = NotificationEntryController();

    final entry = controller.resolve('rhythm://bedtime?source=target_reminder');

    expect(entry, isNotNull);
    expect(entry?.path, bedtimeModePath);
    expect(entry?.source, NotificationOpenSource.targetReminder);
  });

  test('无效 payload 不会生成跳转', () {
    final controller = NotificationEntryController();

    final entry = controller.resolve('rhythm://unknown');

    expect(entry, isNull);
  });
}
