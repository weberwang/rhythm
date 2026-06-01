import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
    if (defaultTargetPlatform == TargetPlatform.windows) {
      // Windows 当前没有接入 home_widget 冷启动桥，桌面端启动时直接降级到默认分发。
      return null;
    }
    try {
      return HomeWidget.initiallyLaunchedFromHomeWidget();
    } on MissingPluginException {
      // 运行平台未注册该插件时，不让启动链路因为可选能力直接白屏。
      return null;
    }
  }
}
