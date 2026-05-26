// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 提供会员服务默认实例，统一收口快照读取与权益判断。

@ProviderFor(membershipService)
const membershipServiceProvider = MembershipServiceProvider._();

/// 提供会员服务默认实例，统一收口快照读取与权益判断。

final class MembershipServiceProvider
    extends
        $FunctionalProvider<
          MembershipService,
          MembershipService,
          MembershipService
        >
    with $Provider<MembershipService> {
  /// 提供会员服务默认实例，统一收口快照读取与权益判断。
  const MembershipServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'membershipServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$membershipServiceHash();

  @$internal
  @override
  $ProviderElement<MembershipService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MembershipService create(Ref ref) {
    return membershipService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MembershipService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MembershipService>(value),
    );
  }
}

String _$membershipServiceHash() => r'4456d6e71c10ea6e722cb116a6bf00ae61e57879';
