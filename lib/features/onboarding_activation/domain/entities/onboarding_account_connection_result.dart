import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_account_connection_result.freezed.dart';

/// 定义引导期允许选择的账号入口提供方。
enum OnboardingAccountProvider {
  /// Apple 登录入口。
  apple,

  /// Google 登录入口。
  google,
}

/// 定义引导期账号连接的稳定结果语义，避免页面直接消费插件异常类型。
enum OnboardingAccountConnectionStatus {
  /// 尚未触发登录尝试。
  idle,

  /// 已成功拿到平台身份结果，可继续进入后续引导步骤。
  success,

  /// 用户主动取消了本轮登录。
  cancelled,

  /// 当前平台或环境暂时不支持该登录方式。
  unavailable,

  /// 发生了可重试失败。
  failed,
}

/// 聚合引导期账号连接结果，向页面暴露 provider / 状态 / 轻量展示字段。
@freezed
abstract class OnboardingAccountConnectionResult
    with _$OnboardingAccountConnectionResult {
  /// 创建账号连接结果快照。
  const factory OnboardingAccountConnectionResult({
    required OnboardingAccountProvider provider,
    required OnboardingAccountConnectionStatus status,
    String? displayName,
    String? email,
  }) = _OnboardingAccountConnectionResult;
}
