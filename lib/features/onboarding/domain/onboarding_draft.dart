import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_draft.freezed.dart';

/// 定义引导阶段可选的登录方式，后续接真实 SDK 时只需补齐对应分支。
enum OnboardingAuthOption {
  /// 尚未选择登录方式。
  none,

  /// 仅记录 Apple 登录入口点击，不接入真实登录。
  apple,

  /// 仅记录 Google 登录入口点击，不接入真实登录。
  google,

  /// 记录邮箱登录入口点击，为后续接真实邮箱链路预留设计稿入口。
  email,

  /// 允许用户先匿名进入主链路。
  anonymous,
}

/// 定义健康权限页的处理动作，便于后续接权限埋点和完成态持久化。
enum OnboardingHealthPermissionAction {
  /// 尚未处理权限步骤。
  none,

  /// 用户选择了授权入口，但当前任务不接真实权限请求。
  authorize,

  /// 用户选择先以手动模式继续。
  skip,
}

/// 承载首次引导阶段暂存的用户选择，集中保存三步流中的最小状态。
@freezed
abstract class OnboardingDraft with _$OnboardingDraft {
  /// 创建首次引导草稿实例。
  const factory OnboardingDraft({
    @Default(OnboardingAuthOption.none) OnboardingAuthOption authOption,
    @Default(OnboardingHealthPermissionAction.none)
    OnboardingHealthPermissionAction healthPermissionAction,
  }) = _OnboardingDraft;
}
