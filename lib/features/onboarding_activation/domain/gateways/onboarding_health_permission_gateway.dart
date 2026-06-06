import '../entities/onboarding_draft.dart';

/// 约束 onboarding 触发健康权限的应用边界，避免页面直接持有插件实例。
abstract interface class OnboardingHealthPermissionGateway {
  /// 请求最小睡眠读取权限，并返回当前引导所需的降级语义结果。
  Future<OnboardingHealthPermissionStatus> requestSleepPermission();
}
