import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

import '../../domain/entities/onboarding_widget_guide.dart';
import '../../domain/gateways/onboarding_widget_guide_gateway.dart';

/// 用 `home_widget` 包承接小组件可用性探测，并向引导页返回稳定展示快照。
class DeviceOnboardingWidgetGuideGateway
    implements OnboardingWidgetGuideGateway {
  /// 创建小组件引导适配器。
  const DeviceOnboardingWidgetGuideGateway();

  @override
  Future<OnboardingWidgetGuide> loadGuide() async {
    if (kIsWeb) {
      return const OnboardingWidgetGuide(
        support: OnboardingWidgetGuideSupport.unavailable,
        installedWidgetCount: 0,
        canRequestPin: false,
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        try {
          final installedWidgets = await HomeWidget.getInstalledWidgets();
          final canRequestPin =
              await HomeWidget.isRequestPinWidgetSupported() ?? false;

          return OnboardingWidgetGuide(
            support: canRequestPin
                ? OnboardingWidgetGuideSupport.supported
                : OnboardingWidgetGuideSupport.manualOnly,
            installedWidgetCount: installedWidgets.length,
            canRequestPin: canRequestPin,
          );
        } catch (_) {
          // 原生配置未就绪时不阻断引导，只退回到“稍后手动添加”的保守说明。
          return const OnboardingWidgetGuide(
            support: OnboardingWidgetGuideSupport.manualOnly,
            installedWidgetCount: 0,
            canRequestPin: false,
          );
        }
      case TargetPlatform.iOS:
        return const OnboardingWidgetGuide(
          support: OnboardingWidgetGuideSupport.manualOnly,
          installedWidgetCount: 0,
          canRequestPin: false,
        );
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        return const OnboardingWidgetGuide(
          support: OnboardingWidgetGuideSupport.unavailable,
          installedWidgetCount: 0,
          canRequestPin: false,
        );
    }
  }
}
