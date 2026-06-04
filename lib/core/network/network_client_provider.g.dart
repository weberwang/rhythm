// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 统一创建 Dio 客户端，为后续真实远端契约保留单一入口。

@ProviderFor(networkClient)
const networkClientProvider = NetworkClientProvider._();

/// 统一创建 Dio 客户端，为后续真实远端契约保留单一入口。

final class NetworkClientProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// 统一创建 Dio 客户端，为后续真实远端契约保留单一入口。
  const NetworkClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$networkClientHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return networkClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$networkClientHash() => r'266bc0f2142aa54070f1ce0ec0dcde686d8a99ca';
