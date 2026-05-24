import 'package:flutter_test/flutter_test.dart';
import 'package:health/health.dart';
import 'package:rhythm/features/sleep_records/data/health_permission_gateway.dart';
import 'package:rhythm/features/sleep_records/data/sleep_health_client.dart';
import 'package:rhythm/features/sleep_records/data/sleep_health_platform_runtime.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';

/// 验证健康权限网关会把双端插件状态收口为稳定业务状态。
void main() {
  group('HealthPermissionGateway', () {
    test('Android SDK 可用状态返回可读取数据的平台状态', () {
      final state = HealthPermissionGateway.resolveAndroidPlatformState(
        HealthConnectSdkStatus.sdkAvailable,
      );

      expect(state, HealthPlatformState.androidAvailable());
    });

    test('Android SDK 不可用状态返回安装引导状态', () {
      final state = HealthPermissionGateway.resolveAndroidPlatformState(
        HealthConnectSdkStatus.sdkUnavailable,
      );

      expect(state, HealthPlatformState.androidInstallRequired());
    });

    test('Android 已安装但未授权时返回重新授权状态', () async {
      final gateway = HealthPermissionGateway(
        client: _FakeSleepHealthClient(
          sdkStatus: HealthConnectSdkStatus.sdkAvailable,
          hasPermissionsResult: false,
        ),
        runtime: const _FakeRuntime(SleepHealthRuntimePlatform.android),
      );

      final state = await gateway.getCurrentPlatformState();

      expect(state, HealthPlatformState.androidPermissionRequired());
      expect(state.canRequestAccess, isTrue);
    });

    test('Android 请求授权后可进入可读取状态', () async {
      final client = _FakeSleepHealthClient(
        sdkStatus: HealthConnectSdkStatus.sdkAvailable,
        hasPermissionsResult: false,
        requestAuthorizationResult: true,
        historyAvailable: true,
        historyAuthorized: false,
        requestHistoryAuthorizationResult: true,
      );
      final gateway = HealthPermissionGateway(
        client: client,
        runtime: const _FakeRuntime(SleepHealthRuntimePlatform.android),
      );

      final state = await gateway.requestAccess();

      expect(state, HealthPlatformState.androidAvailable());
      expect(client.requestAuthorizationCalled, isTrue);
      expect(client.requestHistoryAuthorizationCalled, isTrue);
    });

    test('iOS 首次默认进入权限申请状态，授权后变为可读取状态', () async {
      final gateway = HealthPermissionGateway(
        client: _FakeSleepHealthClient(requestAuthorizationResult: true),
        runtime: const _FakeRuntime(SleepHealthRuntimePlatform.ios),
      );

      final initialState = await gateway.getCurrentPlatformState();
      final authorizedState = await gateway.requestAccess();

      expect(initialState, HealthPlatformState.iosPermissionRequired());
      expect(authorizedState, HealthPlatformState.iosAvailable());
    });
  });
}

class _FakeRuntime implements SleepHealthPlatformRuntime {
  const _FakeRuntime(this.currentPlatform);

  @override
  final SleepHealthRuntimePlatform currentPlatform;
}

class _FakeSleepHealthClient implements SleepHealthClient {
  _FakeSleepHealthClient({
    this.sdkStatus,
    this.hasPermissionsResult,
    this.requestAuthorizationResult = false,
    this.historyAvailable = false,
    this.historyAuthorized = false,
    this.requestHistoryAuthorizationResult = false,
  });

  final HealthConnectSdkStatus? sdkStatus;
  final bool? hasPermissionsResult;
  final bool requestAuthorizationResult;
  final bool historyAvailable;
  final bool historyAuthorized;
  final bool requestHistoryAuthorizationResult;

  bool requestAuthorizationCalled = false;
  bool requestHistoryAuthorizationCalled = false;

  @override
  Future<void> configure() async {}

  @override
  Future<HealthConnectSdkStatus?> getHealthConnectSdkStatus() async => sdkStatus;

  @override
  Future<List<HealthDataPoint>> getHealthDataFromTypes({
    required List<HealthDataType> types,
    required DateTime startTime,
    required DateTime endTime,
    List<RecordingMethod> recordingMethodsToFilter = const [],
  }) async {
    return const <HealthDataPoint>[];
  }

  @override
  Future<bool?> hasPermissions(
    List<HealthDataType> types, {
    List<HealthDataAccess>? permissions,
  }) async {
    return hasPermissionsResult;
  }

  @override
  Future<void> installHealthConnect() async {}

  @override
  Future<bool> isHealthDataHistoryAuthorized() async => historyAuthorized;

  @override
  Future<bool> isHealthDataHistoryAvailable() async => historyAvailable;

  @override
  Future<bool> requestAuthorization(
    List<HealthDataType> types, {
    List<HealthDataAccess>? permissions,
  }) async {
    requestAuthorizationCalled = true;
    return requestAuthorizationResult;
  }

  @override
  Future<bool> requestHealthDataHistoryAuthorization() async {
    requestHistoryAuthorizationCalled = true;
    return requestHistoryAuthorizationResult;
  }
}
