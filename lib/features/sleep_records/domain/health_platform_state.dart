/// 表示健康平台在当前设备上的主状态，供同步链路和展示层共用。
class HealthPlatformState {
  /// 创建健康平台状态实例。
  const HealthPlatformState._({
    required this.platformCode,
    required this.canReadData,
    required this.canInstallProvider,
    required this.canRequestAccess,
    required this.requiresManualFallback,
  });

  /// iOS 侧尚未完成健康权限授权。
  factory HealthPlatformState.iosPermissionRequired() {
    return const HealthPlatformState._(
      platformCode: 'ios_permission_required',
      canReadData: false,
      canInstallProvider: false,
      canRequestAccess: true,
      requiresManualFallback: true,
    );
  }

  /// iOS 侧已可读取 Apple Health 数据。
  factory HealthPlatformState.iosAvailable() {
    return const HealthPlatformState._(
      platformCode: 'ios_available',
      canReadData: true,
      canInstallProvider: false,
      canRequestAccess: false,
      requiresManualFallback: false,
    );
  }

  /// Android 侧平台不可用。
  factory HealthPlatformState.androidUnavailable() {
    return const HealthPlatformState._(
      platformCode: 'android_unavailable',
      canReadData: false,
      canInstallProvider: false,
      canRequestAccess: false,
      requiresManualFallback: true,
    );
  }

  /// Android 侧需要先安装 Health Connect。
  factory HealthPlatformState.androidInstallRequired() {
    return const HealthPlatformState._(
      platformCode: 'android_install_required',
      canReadData: false,
      canInstallProvider: true,
      canRequestAccess: false,
      requiresManualFallback: true,
    );
  }

  /// Android 侧已安装 Health Connect，但尚未完成权限授权。
  factory HealthPlatformState.androidPermissionRequired() {
    return const HealthPlatformState._(
      platformCode: 'android_permission_required',
      canReadData: false,
      canInstallProvider: false,
      canRequestAccess: true,
      requiresManualFallback: true,
    );
  }

  /// Android 侧主链路可用。
  factory HealthPlatformState.androidAvailable() {
    return const HealthPlatformState._(
      platformCode: 'android_available',
      canReadData: true,
      canInstallProvider: false,
      canRequestAccess: false,
      requiresManualFallback: false,
    );
  }

  /// 当前设备不在阶段三支持范围内。
  factory HealthPlatformState.unsupported() {
    return const HealthPlatformState._(
      platformCode: 'unsupported',
      canReadData: false,
      canInstallProvider: false,
      canRequestAccess: false,
      requiresManualFallback: false,
    );
  }

  /// 当前平台状态代码，便于后续映射到 UI 或埋点参数。
  final String platformCode;

  /// 当前状态是否允许直接读取健康数据。
  final bool canReadData;

  /// 当前状态是否允许触发安装或升级健康提供方。
  final bool canInstallProvider;

  /// 当前状态是否允许直接发起权限申请。
  final bool canRequestAccess;

  /// 当前状态是否应优先走手动补录降级。
  final bool requiresManualFallback;

  @override
  bool operator ==(Object other) {
    return other is HealthPlatformState &&
        platformCode == other.platformCode &&
        canReadData == other.canReadData &&
        canInstallProvider == other.canInstallProvider &&
        canRequestAccess == other.canRequestAccess &&
        requiresManualFallback == other.requiresManualFallback;
  }

  @override
  int get hashCode => Object.hash(
        platformCode,
        canReadData,
        canInstallProvider,
        canRequestAccess,
        requiresManualFallback,
      );
}
