import 'package:home_widget/home_widget.dart';

/// 小组件启动入口读取边界，隔离启动层与具体插件 API。
abstract class WidgetLaunchGateway {
  /// 读取冷启动时的小组件入口 Uri。
  Future<Uri?> readInitialEntry();
}

/// 使用 `home_widget` 读取冷启动入口。
class HomeWidgetLaunchGateway implements WidgetLaunchGateway {
  @override
  Future<Uri?> readInitialEntry() async {
    return HomeWidget.initiallyLaunchedFromHomeWidget();
  }
}
