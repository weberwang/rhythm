import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_shell_models.freezed.dart';

/// 根级 tab 枚举。
enum AppShellTab {
  /// 今日。
  today,

  /// 日历。
  calendar,

  /// 睡前。
  bedtime,

  /// 洞察。
  insights,

  /// 我的。
  profile,
}

/// 根壳层 tab 状态。
@freezed
abstract class AppShellTabState with _$AppShellTabState {
  /// 创建 tab 状态。
  const factory AppShellTabState({
    required AppShellTab currentTab,
    @Default(false) bool reselectRequested,
  }) = _AppShellTabState;
}

/// 启动分发目标。
enum LaunchRouteTarget {
  /// 引导。
  onboarding,

  /// 今日。
  today,

  /// 日历。
  calendar,

  /// 睡前。
  bedtime,

  /// 洞察。
  insights,

  /// 我的。
  profile,
}

/// 启动分发决策结果。
@freezed
class LaunchDecision with _$LaunchDecision {
  /// 直接跳转到目标模块。
  const factory LaunchDecision.redirect({
    required LaunchRouteTarget target,
    String? successMessage,
  }) = _LaunchDecisionRedirect;

  /// 先展示 handoff 过渡，再进入目标模块。
  const factory LaunchDecision.handoff({
    required LaunchRouteTarget target,
    required String reason,
  }) = _LaunchDecisionHandoff;

  /// 当前 deep link 无法直接进入时，先回退到可用落点。
  const factory LaunchDecision.blocked({
    required LaunchRouteTarget fallbackTarget,
    required String message,
  }) = _LaunchDecisionBlocked;

  /// 进入壳层错误页。
  const factory LaunchDecision.failure({
    required String message,
  }) = _LaunchDecisionFailure;
}

/// deep link 解析结果。
@freezed
class AppShellDeepLink with _$AppShellDeepLink {
  /// 没有 deep link。
  const factory AppShellDeepLink.none() = _AppShellDeepLinkNone;

  /// deep link 指向模块落点。
  const factory AppShellDeepLink.target({
    required LaunchRouteTarget target,
    required String source,
  }) = _AppShellDeepLinkTarget;
}

/// 根级 overlay 类型。
enum AppShellOverlayType {
  /// 阻断型错误。
  blockingError,

  /// 成功反馈。
  success,

  /// 普通提示。
  info,
}

/// 根级 overlay 事件。
class AppShellOverlayEvent {
  /// 创建 overlay 事件。
  const AppShellOverlayEvent._({
    required this.type,
    required this.message,
  });

  /// 创建阻断型错误事件。
  const AppShellOverlayEvent.blockingError({
    required String message,
  }) : this._(type: AppShellOverlayType.blockingError, message: message);

  /// 创建成功反馈事件。
  const AppShellOverlayEvent.success({
    required String message,
  }) : this._(type: AppShellOverlayType.success, message: message);

  /// 创建普通提示事件。
  const AppShellOverlayEvent.info({
    required String message,
  }) : this._(type: AppShellOverlayType.info, message: message);

  /// 事件类型。
  final AppShellOverlayType type;

  /// 展示文案。
  final String message;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppShellOverlayEvent &&
            other.type == type &&
            other.message == message);
  }

  @override
  int get hashCode => Object.hash(type, message);
}
