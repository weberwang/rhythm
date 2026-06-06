import '../entities/onboarding_widget_guide.dart';

/// 约束 onboarding 获取小组件引导信息的边界，避免展示层推断平台能力。
abstract interface class OnboardingWidgetGuideGateway {
  /// 读取当前设备的小组件可用性快照。
  Future<OnboardingWidgetGuide> loadGuide();
}
