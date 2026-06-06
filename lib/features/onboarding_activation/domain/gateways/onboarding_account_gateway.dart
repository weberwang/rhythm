import '../entities/onboarding_account_connection_result.dart';

/// 约束 onboarding 触发平台登录的边界，避免页面直接依赖 OAuth / SDK 调用。
abstract interface class OnboardingAccountGateway {
  /// 使用指定账号入口执行一次引导期登录尝试，并返回稳定业务结果。
  Future<OnboardingAccountConnectionResult> signIn(
    OnboardingAccountProvider provider,
  );
}
