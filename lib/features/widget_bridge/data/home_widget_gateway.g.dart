// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_widget_gateway.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 提供小组件插件网关，便于页面层通过 Provider 覆盖测试替身。

@ProviderFor(homeWidgetGateway)
const homeWidgetGatewayProvider = HomeWidgetGatewayProvider._();

/// 提供小组件插件网关，便于页面层通过 Provider 覆盖测试替身。

final class HomeWidgetGatewayProvider
    extends
        $FunctionalProvider<
          HomeWidgetGateway,
          HomeWidgetGateway,
          HomeWidgetGateway
        >
    with $Provider<HomeWidgetGateway> {
  /// 提供小组件插件网关，便于页面层通过 Provider 覆盖测试替身。
  const HomeWidgetGatewayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeWidgetGatewayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeWidgetGatewayHash();

  @$internal
  @override
  $ProviderElement<HomeWidgetGateway> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HomeWidgetGateway create(Ref ref) {
    return homeWidgetGateway(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeWidgetGateway value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeWidgetGateway>(value),
    );
  }
}

String _$homeWidgetGatewayHash() => r'012fc864c5119da8099a9f1cc859fec24352c0e0';
