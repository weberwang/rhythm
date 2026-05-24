import 'package:flutter_timezone/flutter_timezone.dart';

/// 时区读取边界，避免调度层直接依赖具体插件返回结构。
abstract class TimezoneGateway {
  /// 解析当前系统时区名。
  Future<String> resolveLocalTimezoneName();
}

/// 使用 `flutter_timezone` 读取系统时区，并为后续 `timezone` 初始化提供稳定入口。
class DeviceTimezoneGateway implements TimezoneGateway {
  @override
  Future<String> resolveLocalTimezoneName() async {
    final timezone = await FlutterTimezone.getLocalTimezone();
    return timezone.identifier;
  }
}
