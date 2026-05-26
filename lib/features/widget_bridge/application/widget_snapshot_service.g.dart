// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_snapshot_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 提供小组件快照服务，避免显示层直接关心实例装配。

@ProviderFor(widgetSnapshotService)
const widgetSnapshotServiceProvider = WidgetSnapshotServiceProvider._();

/// 提供小组件快照服务，避免显示层直接关心实例装配。

final class WidgetSnapshotServiceProvider
    extends
        $FunctionalProvider<
          WidgetSnapshotService,
          WidgetSnapshotService,
          WidgetSnapshotService
        >
    with $Provider<WidgetSnapshotService> {
  /// 提供小组件快照服务，避免显示层直接关心实例装配。
  const WidgetSnapshotServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'widgetSnapshotServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$widgetSnapshotServiceHash();

  @$internal
  @override
  $ProviderElement<WidgetSnapshotService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WidgetSnapshotService create(Ref ref) {
    return widgetSnapshotService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WidgetSnapshotService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WidgetSnapshotService>(value),
    );
  }
}

String _$widgetSnapshotServiceHash() =>
    r'f7e8a4fe2d315faf0c513eb2a188fa56657dccf3';

/// 聚合当前目标、权限与有效记录，向小组件设置页输出可展示快照。

@ProviderFor(widgetThemeSnapshot)
const widgetThemeSnapshotProvider = WidgetThemeSnapshotProvider._();

/// 聚合当前目标、权限与有效记录，向小组件设置页输出可展示快照。

final class WidgetThemeSnapshotProvider
    extends
        $FunctionalProvider<
          AsyncValue<WidgetSnapshot>,
          WidgetSnapshot,
          FutureOr<WidgetSnapshot>
        >
    with $FutureModifier<WidgetSnapshot>, $FutureProvider<WidgetSnapshot> {
  /// 聚合当前目标、权限与有效记录，向小组件设置页输出可展示快照。
  const WidgetThemeSnapshotProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'widgetThemeSnapshotProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$widgetThemeSnapshotHash();

  @$internal
  @override
  $FutureProviderElement<WidgetSnapshot> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WidgetSnapshot> create(Ref ref) {
    return widgetThemeSnapshot(ref);
  }
}

String _$widgetThemeSnapshotHash() =>
    r'b0fc7f8549477572fc6509726aa9d8d455b8d1df';
