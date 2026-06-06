import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/gateways/onboarding_account_gateway.dart';
import '../../domain/entities/onboarding_widget_guide.dart';
import '../../domain/gateways/onboarding_health_permission_gateway.dart';
import '../../domain/gateways/onboarding_widget_guide_gateway.dart';
import '../../infrastructure/gateways/device_onboarding_account_gateway.dart';
import '../../infrastructure/gateways/device_onboarding_health_permission_gateway.dart';
import '../../infrastructure/gateways/device_onboarding_widget_guide_gateway.dart';

part 'onboarding_capability_gateways.g.dart';

/// 暴露账号登录适配入口，让应用层只依赖稳定业务结果而不是第三方 SDK。
@Riverpod(keepAlive: true)
OnboardingAccountGateway onboardingAccountGateway(Ref ref) {
  return DeviceOnboardingAccountGateway();
}

/// 暴露健康权限适配入口，让应用层只依赖业务语义结果。
@Riverpod(keepAlive: true)
OnboardingHealthPermissionGateway onboardingHealthPermissionGateway(Ref ref) {
  return DeviceOnboardingHealthPermissionGateway();
}

/// 暴露小组件引导适配入口，让展示层不直接推断平台能力。
@Riverpod(keepAlive: true)
OnboardingWidgetGuideGateway onboardingWidgetGuideGateway(Ref ref) {
  return DeviceOnboardingWidgetGuideGateway();
}

/// 统一读取当前设备的小组件引导快照，避免页面分散处理异步平台分支。
@Riverpod(keepAlive: true)
Future<OnboardingWidgetGuide> onboardingWidgetGuide(Ref ref) {
  final gateway = ref.watch(onboardingWidgetGuideGatewayProvider);
  return gateway.loadGuide();
}
