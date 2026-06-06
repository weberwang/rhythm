import 'package:flutter/foundation.dart';
import 'package:health/health.dart';

import '../../domain/entities/onboarding_draft.dart';
import '../../domain/gateways/onboarding_health_permission_gateway.dart';

/// 用 `health` 包承接最小睡眠权限请求，并向应用层返回稳定业务结果。
class DeviceOnboardingHealthPermissionGateway
    implements OnboardingHealthPermissionGateway {
  /// 创建健康权限适配器。
  DeviceOnboardingHealthPermissionGateway({Health? health})
      : _health = health ?? Health();

  final Health _health;

  static const List<HealthDataType> _types = [
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_AWAKE,
  ];

  static const List<HealthDataAccess> _permissions = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];

  @override
  Future<OnboardingHealthPermissionStatus> requestSleepPermission() async {
    // web 与桌面不提供本轮引导所需的健康授权入口，直接返回可解释的降级状态。
    if (kIsWeb) {
      return OnboardingHealthPermissionStatus.unavailable;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final available = await _health.isHealthConnectAvailable();
        if (!available) {
          return OnboardingHealthPermissionStatus.unavailable;
        }

        final granted = await _health.requestAuthorization(
          _types,
          permissions: _permissions,
        );
        return granted
            ? OnboardingHealthPermissionStatus.granted
            : OnboardingHealthPermissionStatus.denied;
      case TargetPlatform.iOS:
        final granted = await _health.requestAuthorization(
          _types,
          permissions: _permissions,
        );
        return granted
            ? OnboardingHealthPermissionStatus.granted
            : OnboardingHealthPermissionStatus.denied;
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        return OnboardingHealthPermissionStatus.unavailable;
    }
  }
}
