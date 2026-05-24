import 'package:health/health.dart';

/// 定义阶段三健康数据客户端边界，隔离业务代码与三方插件直接耦合。
abstract class SleepHealthClient {
  /// 在首次使用前完成插件配置。
  Future<void> configure();

  /// 读取 Android Health Connect SDK 可用性状态。
  Future<HealthConnectSdkStatus?> getHealthConnectSdkStatus();

  /// 检查指定健康数据类型是否已有权限。
  Future<bool?> hasPermissions(
    List<HealthDataType> types, {
    List<HealthDataAccess>? permissions,
  });

  /// 申请指定健康数据类型权限。
  Future<bool> requestAuthorization(
    List<HealthDataType> types, {
    List<HealthDataAccess>? permissions,
  });

  /// 检查 Android 历史健康数据读取能力是否可用。
  Future<bool> isHealthDataHistoryAvailable();

  /// 检查 Android 历史健康数据读取权限是否已授权。
  Future<bool> isHealthDataHistoryAuthorized();

  /// 申请 Android 历史健康数据读取权限。
  Future<bool> requestHealthDataHistoryAuthorization();

  /// 读取指定时间范围内的健康数据点。
  Future<List<HealthDataPoint>> getHealthDataFromTypes({
    required List<HealthDataType> types,
    required DateTime startTime,
    required DateTime endTime,
    List<RecordingMethod> recordingMethodsToFilter,
  });

  /// 拉起 Android Health Connect 安装流程。
  Future<void> installHealthConnect();
}

/// 基于 `health` 插件的默认实现。
class PluginSleepHealthClient implements SleepHealthClient {
  /// 创建健康数据客户端实例。
  PluginSleepHealthClient({Health? health}) : _health = health ?? Health();

  final Health _health;
  bool _configured = false;

  @override
  Future<void> configure() async {
    if (_configured) {
      return;
    }
    await _health.configure();
    _configured = true;
  }

  @override
  Future<HealthConnectSdkStatus?> getHealthConnectSdkStatus() async {
    await configure();
    return _health.getHealthConnectSdkStatus();
  }

  @override
  Future<List<HealthDataPoint>> getHealthDataFromTypes({
    required List<HealthDataType> types,
    required DateTime startTime,
    required DateTime endTime,
    List<RecordingMethod> recordingMethodsToFilter = const [],
  }) async {
    await configure();
    return _health.getHealthDataFromTypes(
      types: types,
      startTime: startTime,
      endTime: endTime,
      recordingMethodsToFilter: recordingMethodsToFilter,
    );
  }

  @override
  Future<bool?> hasPermissions(
    List<HealthDataType> types, {
    List<HealthDataAccess>? permissions,
  }) async {
    await configure();
    return _health.hasPermissions(types, permissions: permissions);
  }

  @override
  Future<void> installHealthConnect() async {
    await configure();
    await _health.installHealthConnect();
  }

  @override
  Future<bool> isHealthDataHistoryAuthorized() async {
    await configure();
    return _health.isHealthDataHistoryAuthorized();
  }

  @override
  Future<bool> isHealthDataHistoryAvailable() async {
    await configure();
    return _health.isHealthDataHistoryAvailable();
  }

  @override
  Future<bool> requestAuthorization(
    List<HealthDataType> types, {
    List<HealthDataAccess>? permissions,
  }) async {
    await configure();
    return _health.requestAuthorization(types, permissions: permissions);
  }

  @override
  Future<bool> requestHealthDataHistoryAuthorization() async {
    await configure();
    return _health.requestHealthDataHistoryAuthorization();
  }
}
