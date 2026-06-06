import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_widget_guide.freezed.dart';

/// 描述当前设备对桌面小组件引导的支持级别。
enum OnboardingWidgetGuideSupport {
  /// 可以在本设备上直接承载小组件入口。
  supported,

  /// 能支持小组件语义，但通常需要用户稍后手动添加。
  manualOnly,

  /// 当前平台不支持该能力，应明确给出降级解释。
  unavailable,
}

/// 聚合 onboarding 小组件引导所需的最小平台信息，避免页面依赖插件细节。
@freezed
abstract class OnboardingWidgetGuide with _$OnboardingWidgetGuide {
  /// 创建小组件引导快照。
  const factory OnboardingWidgetGuide({
    required OnboardingWidgetGuideSupport support,
    required int installedWidgetCount,
    required bool canRequestPin,
  }) = _OnboardingWidgetGuide;
}
