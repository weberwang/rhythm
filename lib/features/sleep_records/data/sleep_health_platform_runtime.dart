import 'dart:io';

/// 抽象当前运行平台，便于在单元测试中稳定模拟 Android 与 iOS 分支。
enum SleepHealthRuntimePlatform {
  /// Android + Health Connect。
  android,

  /// iOS + Apple Health。
  ios,

  /// 当前阶段未支持的平台。
  unsupported,
}

/// 提供当前设备平台信息。
abstract class SleepHealthPlatformRuntime {
  /// 返回当前运行平台。
  SleepHealthRuntimePlatform get currentPlatform;
}

/// 生产环境默认平台实现。
class DeviceSleepHealthPlatformRuntime implements SleepHealthPlatformRuntime {
  /// 创建默认平台运行时实例。
  const DeviceSleepHealthPlatformRuntime();

  @override
  SleepHealthRuntimePlatform get currentPlatform {
    if (Platform.isAndroid) {
      return SleepHealthRuntimePlatform.android;
    }
    if (Platform.isIOS) {
      return SleepHealthRuntimePlatform.ios;
    }
    return SleepHealthRuntimePlatform.unsupported;
  }
}
