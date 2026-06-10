/// 应用级权限状态。
enum AppPermissionStatus {
  /// 未触发检查。
  unknown,

  /// 权限已授予。
  granted,

  /// 权限被拒绝或未开启。
  denied,

  /// 当前设备或环境不支持。
  unsupported,
}
