import 'package:health/health.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/core/permissions/app_permission_models.dart';

part 'onboarding_activation_health_gateway.g.dart';

/// 首次激活阶段的健康权限桥接。
class OnboardingActivationHealthGateway {
  /// 创建健康权限桥接。
  OnboardingActivationHealthGateway({Health? health})
    : _health = health ?? Health();

  final Health _health;

  static const _types = <HealthDataType>[
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_IN_BED,
  ];

  static const _permissions = <HealthDataAccess>[
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];

  /// 尝试为首次激活申请最小健康读取权限。
  Future<AppPermissionStatus> requestSleepReadAccess() async {
    try {
      await _health.configure();

      final hasPermissions = await _health.hasPermissions(
        _types,
        permissions: _permissions,
      );
      if (hasPermissions == true) {
        return AppPermissionStatus.granted;
      }

      final granted = await _health.requestAuthorization(
        _types,
        permissions: _permissions,
      );
      return granted
          ? AppPermissionStatus.granted
          : AppPermissionStatus.denied;
    } on UnsupportedError {
      return AppPermissionStatus.unsupported;
    } catch (_) {
      return AppPermissionStatus.denied;
    }
  }
}

/// 提供首次激活健康权限桥接。
@Riverpod(keepAlive: true)
OnboardingActivationHealthGateway onboardingActivationHealthGateway(Ref ref) {
  return OnboardingActivationHealthGateway();
}
