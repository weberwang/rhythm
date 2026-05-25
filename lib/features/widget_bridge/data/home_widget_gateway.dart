import 'package:home_widget/home_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/widget_snapshot.dart';

part 'home_widget_gateway.g.dart';

/// 小组件插件网关边界，集中隔离数据写入与刷新调用。
abstract class HomeWidgetGateway {
  /// 将当前快照写入插件共享存储。
  Future<void> saveSnapshot(WidgetSnapshot snapshot);

  /// 通知系统刷新小组件显示。
  Future<void> refresh();
}

/// 使用 `home_widget` 实现的小组件插件网关。
class PluginHomeWidgetGateway implements HomeWidgetGateway {
  /// 创建插件小组件网关。
  const PluginHomeWidgetGateway();

  /// 原生小组件标识集中放在此处，避免页面层散落平台细节。
  static const String _androidWidgetName = 'RhythmHomeWidgetProvider';

  /// iOS WidgetKit 的 kind 值，后续接原生扩展时只需修改这一处。
  static const String _iosWidgetName = 'RhythmWidget';

  @override
  Future<void> saveSnapshot(WidgetSnapshot snapshot) async {
    final data = snapshot.toWidgetData();
    for (final entry in data.entries) {
      await HomeWidget.saveWidgetData<dynamic>(entry.key, entry.value);
    }
  }

  @override
  Future<void> refresh() async {
    await HomeWidget.updateWidget(
      name: _androidWidgetName,
      androidName: _androidWidgetName,
      iOSName: _iosWidgetName,
    );
  }
}

/// 提供小组件插件网关，便于页面层通过 Provider 覆盖测试替身。
@riverpod
HomeWidgetGateway homeWidgetGateway(Ref ref) {
  return const PluginHomeWidgetGateway();
}
