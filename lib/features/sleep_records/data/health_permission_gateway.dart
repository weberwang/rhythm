import 'package:health/health.dart';
import 'package:rhythm/features/sleep_records/data/sleep_health_client.dart';
import 'package:rhythm/features/sleep_records/data/sleep_health_platform_runtime.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';

/// 统一收口健康平台权限与可用性状态，避免页面直接理解插件枚举。
class HealthPermissionGateway {
  /// 创建健康权限网关实例。
  HealthPermissionGateway({
    SleepHealthClient? client,
    SleepHealthPlatformRuntime? runtime,
  })  : _client = client ?? PluginSleepHealthClient(),
        _runtime = runtime ?? const DeviceSleepHealthPlatformRuntime();

  final SleepHealthClient _client;
  final SleepHealthPlatformRuntime _runtime;
  bool _iosAuthorizationGrantedInSession = false;

  static const List<HealthDataType> _sleepTypes = <HealthDataType>[
    HealthDataType.SLEEP_ASLEEP,
  ];
  static const List<HealthDataAccess> _sleepReadPermissions =
      <HealthDataAccess>[
    HealthDataAccess.READ,
  ];

  /// 将 Android Health Connect SDK 状态映射为项目内部平台状态。
  static HealthPlatformState resolveAndroidPlatformState(
    HealthConnectSdkStatus status,
  ) {
    switch (status) {
      case HealthConnectSdkStatus.sdkAvailable:
        return HealthPlatformState.androidAvailable();
      case HealthConnectSdkStatus.sdkUnavailable:
        return HealthPlatformState.androidInstallRequired();
      case HealthConnectSdkStatus.sdkUnavailableProviderUpdateRequired:
        return HealthPlatformState.androidUnavailable();
    }
  }

  /// 返回当前平台的主状态，供管理页和同步编排统一分支。
  Future<HealthPlatformState> getCurrentPlatformState() async {
    switch (_runtime.currentPlatform) {
      case SleepHealthRuntimePlatform.android:
        await _client.configure();
        final sdkStatus = await _client.getHealthConnectSdkStatus();
        final platformState = resolveAndroidPlatformState(
          sdkStatus ?? HealthConnectSdkStatus.sdkUnavailable,
        );
        if (!platformState.canReadData) {
          return platformState;
        }

        final hasReadPermission = await _client.hasPermissions(
          _sleepTypes,
          permissions: _sleepReadPermissions,
        );
        if (hasReadPermission != true) {
          return HealthPlatformState.androidPermissionRequired();
        }

        final historyAvailable = await _client.isHealthDataHistoryAvailable();
        if (!historyAvailable) {
          return HealthPlatformState.androidAvailable();
        }

        final historyAuthorized =
            await _client.isHealthDataHistoryAuthorized();
        return historyAuthorized
            ? HealthPlatformState.androidAvailable()
            : HealthPlatformState.androidPermissionRequired();
      case SleepHealthRuntimePlatform.ios:
        await _client.configure();
        return _iosAuthorizationGrantedInSession
            ? HealthPlatformState.iosAvailable()
            : HealthPlatformState.iosPermissionRequired();
      case SleepHealthRuntimePlatform.unsupported:
        return HealthPlatformState.unsupported();
    }
  }

  /// 请求当前平台所需的睡眠读取权限，并返回申请后的平台状态。
  Future<HealthPlatformState> requestAccess() async {
    switch (_runtime.currentPlatform) {
      case SleepHealthRuntimePlatform.android:
        await _client.configure();
        final sdkStatus = await _client.getHealthConnectSdkStatus();
        final platformState = resolveAndroidPlatformState(
          sdkStatus ?? HealthConnectSdkStatus.sdkUnavailable,
        );
        if (!platformState.canReadData) {
          return platformState;
        }

        final granted = await _client.requestAuthorization(
          _sleepTypes,
          permissions: _sleepReadPermissions,
        );
        if (!granted) {
          return HealthPlatformState.androidPermissionRequired();
        }

        final historyAvailable = await _client.isHealthDataHistoryAvailable();
        if (!historyAvailable) {
          return HealthPlatformState.androidAvailable();
        }

        final historyAuthorized =
            await _client.isHealthDataHistoryAuthorized() ||
                await _client.requestHealthDataHistoryAuthorization();
        return historyAuthorized
            ? HealthPlatformState.androidAvailable()
            : HealthPlatformState.androidPermissionRequired();
      case SleepHealthRuntimePlatform.ios:
        await _client.configure();
        final granted = await _client.requestAuthorization(
          _sleepTypes,
          permissions: _sleepReadPermissions,
        );
        _iosAuthorizationGrantedInSession = granted;
        return granted
            ? HealthPlatformState.iosAvailable()
            : HealthPlatformState.iosPermissionRequired();
      case SleepHealthRuntimePlatform.unsupported:
        return HealthPlatformState.unsupported();
    }
  }

  /// 拉起 Android Health Connect 安装流程。
  Future<void> openHealthProviderInstallation() async {
    if (_runtime.currentPlatform != SleepHealthRuntimePlatform.android) {
      return;
    }
    await _client.configure();
    await _client.installHealthConnect();
  }
}
