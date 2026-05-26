import 'package:home_widget/home_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/widget_snapshot.dart';

part 'home_widget_gateway.g.dart';

/// 描述当前设备上 Rhythm 小组件的安装状态。
enum HomeWidgetInstallationState {
  /// 当前至少存在一个已添加到系统桌面的 Rhythm 小组件实例。
  available,

  /// 当前设备还没有添加任何 Rhythm 小组件实例。
  notInstalled,
}

/// 描述当前设备是否支持由应用主动唤起“添加到桌面”流程。
enum HomeWidgetPinSupportState {
  /// 当前平台支持由应用发起固定到桌面请求。
  supported,

  /// 当前平台不支持主动唤起固定流程，只能给出手动添加指引。
  unsupported,
}

/// 小组件插件网关边界，集中隔离安装状态、添加入口、启动入口、数据写入与刷新调用。
abstract class HomeWidgetGateway {
  /// 读取当前设备上的小组件安装状态，避免页面层直接感知插件细节。
  Future<HomeWidgetInstallationState> getInstallationState();

  /// 读取当前设备是否支持从应用内直接发起“添加到桌面”请求。
  Future<HomeWidgetPinSupportState> getPinSupportState();

  /// 请求系统发起“添加到桌面”流程；返回值表示系统是否接受了该请求。
  Future<bool> requestPin();

  /// 读取冷启动时由小组件透传的入口 Uri。
  Future<Uri?> readInitialEntry();

  /// 将当前快照写入插件共享存储。
  Future<void> saveSnapshot(WidgetSnapshot snapshot);

  /// 清空小组件共享存储中的快照字段，避免桌面继续读取过期内容。
  Future<void> clearSnapshot();

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

  /// 统一维护共享存储字段名，便于清空快照时彻底删除旧值。
  static const List<String> _widgetDataKeys = <String>[
    'snapshot_state',
    'target_bedtime_label',
    'minutes_to_target',
    'last_night_status_label',
    'entry_uri',
  ];

  @override
  Future<HomeWidgetInstallationState> getInstallationState() async {
    final installedWidgets = await HomeWidget.getInstalledWidgets();
    if (installedWidgets.isEmpty) {
      return HomeWidgetInstallationState.notInstalled;
    }
    return HomeWidgetInstallationState.available;
  }

  @override
  Future<HomeWidgetPinSupportState> getPinSupportState() async {
    final supported = await HomeWidget.isRequestPinWidgetSupported() ?? false;
    return supported
        ? HomeWidgetPinSupportState.supported
        : HomeWidgetPinSupportState.unsupported;
  }

  @override
  Future<bool> requestPin() async {
    final supportState = await getPinSupportState();
    if (supportState == HomeWidgetPinSupportState.unsupported) {
      return false;
    }
    await HomeWidget.requestPinWidget(
      name: _androidWidgetName,
      androidName: _androidWidgetName,
    );
    return true;
  }

  @override
  Future<Uri?> readInitialEntry() async {
    return HomeWidget.initiallyLaunchedFromHomeWidget();
  }

  @override
  Future<void> saveSnapshot(WidgetSnapshot snapshot) async {
    final data = snapshot.toWidgetData();
    for (final entry in data.entries) {
      await HomeWidget.saveWidgetData<dynamic>(entry.key, entry.value);
    }
  }

  @override
  Future<void> clearSnapshot() async {
    for (final key in _widgetDataKeys) {
      await HomeWidget.saveWidgetData<dynamic>(key, null);
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
