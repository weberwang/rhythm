// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchases_membership_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 提供 RevenueCat 会员边界默认实例，统一处理未配置时的免费版降级。

@ProviderFor(purchasesMembershipDataSource)
const purchasesMembershipDataSourceProvider =
    PurchasesMembershipDataSourceProvider._();

/// 提供 RevenueCat 会员边界默认实例，统一处理未配置时的免费版降级。

final class PurchasesMembershipDataSourceProvider
    extends
        $FunctionalProvider<
          PurchasesMembershipDataSource,
          PurchasesMembershipDataSource,
          PurchasesMembershipDataSource
        >
    with $Provider<PurchasesMembershipDataSource> {
  /// 提供 RevenueCat 会员边界默认实例，统一处理未配置时的免费版降级。
  const PurchasesMembershipDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchasesMembershipDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchasesMembershipDataSourceHash();

  @$internal
  @override
  $ProviderElement<PurchasesMembershipDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PurchasesMembershipDataSource create(Ref ref) {
    return purchasesMembershipDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PurchasesMembershipDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PurchasesMembershipDataSource>(
        value,
      ),
    );
  }
}

String _$purchasesMembershipDataSourceHash() =>
    r'a8d145fa3d8b2c32181fd981ebbaaf1de400fdf4';
