// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_capability_gateways.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 暴露账号登录适配入口，让应用层只依赖稳定业务结果而不是第三方 SDK。

@ProviderFor(onboardingAccountGateway)
const onboardingAccountGatewayProvider = OnboardingAccountGatewayProvider._();

/// 暴露账号登录适配入口，让应用层只依赖稳定业务结果而不是第三方 SDK。

final class OnboardingAccountGatewayProvider
    extends
        $FunctionalProvider<
          OnboardingAccountGateway,
          OnboardingAccountGateway,
          OnboardingAccountGateway
        >
    with $Provider<OnboardingAccountGateway> {
  /// 暴露账号登录适配入口，让应用层只依赖稳定业务结果而不是第三方 SDK。
  const OnboardingAccountGatewayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingAccountGatewayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingAccountGatewayHash();

  @$internal
  @override
  $ProviderElement<OnboardingAccountGateway> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OnboardingAccountGateway create(Ref ref) {
    return onboardingAccountGateway(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingAccountGateway value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingAccountGateway>(value),
    );
  }
}

String _$onboardingAccountGatewayHash() =>
    r'1f0c77119e68e5fb9d3fc4a19aa25b84aabf12d4';

/// 暴露健康权限适配入口，让应用层只依赖业务语义结果。

@ProviderFor(onboardingHealthPermissionGateway)
const onboardingHealthPermissionGatewayProvider =
    OnboardingHealthPermissionGatewayProvider._();

/// 暴露健康权限适配入口，让应用层只依赖业务语义结果。

final class OnboardingHealthPermissionGatewayProvider
    extends
        $FunctionalProvider<
          OnboardingHealthPermissionGateway,
          OnboardingHealthPermissionGateway,
          OnboardingHealthPermissionGateway
        >
    with $Provider<OnboardingHealthPermissionGateway> {
  /// 暴露健康权限适配入口，让应用层只依赖业务语义结果。
  const OnboardingHealthPermissionGatewayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingHealthPermissionGatewayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$onboardingHealthPermissionGatewayHash();

  @$internal
  @override
  $ProviderElement<OnboardingHealthPermissionGateway> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OnboardingHealthPermissionGateway create(Ref ref) {
    return onboardingHealthPermissionGateway(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingHealthPermissionGateway value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingHealthPermissionGateway>(
        value,
      ),
    );
  }
}

String _$onboardingHealthPermissionGatewayHash() =>
    r'bea8c20b73cb555eb92fa06389ebbd22bdb22d4f';

/// 暴露小组件引导适配入口，让展示层不直接推断平台能力。

@ProviderFor(onboardingWidgetGuideGateway)
const onboardingWidgetGuideGatewayProvider =
    OnboardingWidgetGuideGatewayProvider._();

/// 暴露小组件引导适配入口，让展示层不直接推断平台能力。

final class OnboardingWidgetGuideGatewayProvider
    extends
        $FunctionalProvider<
          OnboardingWidgetGuideGateway,
          OnboardingWidgetGuideGateway,
          OnboardingWidgetGuideGateway
        >
    with $Provider<OnboardingWidgetGuideGateway> {
  /// 暴露小组件引导适配入口，让展示层不直接推断平台能力。
  const OnboardingWidgetGuideGatewayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingWidgetGuideGatewayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingWidgetGuideGatewayHash();

  @$internal
  @override
  $ProviderElement<OnboardingWidgetGuideGateway> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OnboardingWidgetGuideGateway create(Ref ref) {
    return onboardingWidgetGuideGateway(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingWidgetGuideGateway value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingWidgetGuideGateway>(value),
    );
  }
}

String _$onboardingWidgetGuideGatewayHash() =>
    r'f52c5213b562c80cc122915181b9784b774ddeab';

/// 统一读取当前设备的小组件引导快照，避免页面分散处理异步平台分支。

@ProviderFor(onboardingWidgetGuide)
const onboardingWidgetGuideProvider = OnboardingWidgetGuideProvider._();

/// 统一读取当前设备的小组件引导快照，避免页面分散处理异步平台分支。

final class OnboardingWidgetGuideProvider
    extends
        $FunctionalProvider<
          AsyncValue<OnboardingWidgetGuide>,
          OnboardingWidgetGuide,
          FutureOr<OnboardingWidgetGuide>
        >
    with
        $FutureModifier<OnboardingWidgetGuide>,
        $FutureProvider<OnboardingWidgetGuide> {
  /// 统一读取当前设备的小组件引导快照，避免页面分散处理异步平台分支。
  const OnboardingWidgetGuideProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingWidgetGuideProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingWidgetGuideHash();

  @$internal
  @override
  $FutureProviderElement<OnboardingWidgetGuide> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<OnboardingWidgetGuide> create(Ref ref) {
    return onboardingWidgetGuide(ref);
  }
}

String _$onboardingWidgetGuideHash() =>
    r'622cb2e8a8047fcb8c02a3b3eda3c01461cc3dbf';
