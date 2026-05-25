import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/widget_bridge/application/widget_entry_controller.dart';
import 'package:rhythm/features/widget_bridge/domain/widget_entry_source.dart';

/// 验证小组件入口只在有效 bedtime shortcut 时进入睡前页。
void main() {
  test('today shortcut 进入今日页', () {
    final controller = WidgetEntryController();

    final entry = controller.resolve(
      Uri.parse('rhythm://today?source=widget_today'),
    );

    expect(entry?.path, RhythmTab.today.path);
    expect(entry?.source, WidgetEntrySource.todayShortcut);
  });

  test('bedtime shortcut 进入睡前页', () {
    final controller = WidgetEntryController();

    final entry = controller.resolve(
      Uri.parse('rhythm://bedtime?source=widget_bedtime_shortcut'),
    );

    expect(entry?.path, bedtimeModePath);
    expect(entry?.source, WidgetEntrySource.bedtimeShortcut);
  });

  test('未知来源不改变路由', () {
    final controller = WidgetEntryController();

    final entry = controller.resolve(Uri.parse('rhythm://calendar'));

    expect(entry, isNull);
  });

  test('空 uri 不改变路由', () {
    final controller = WidgetEntryController();

    final entry = controller.resolve(null);

    expect(entry, isNull);
  });
}
