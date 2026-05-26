// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 提供会员页面控制器，统一编排首屏快照、套餐切换与购买恢复动作。

@ProviderFor(MembershipController)
const membershipControllerProvider = MembershipControllerProvider._();

/// 提供会员页面控制器，统一编排首屏快照、套餐切换与购买恢复动作。
final class MembershipControllerProvider
    extends $AsyncNotifierProvider<MembershipController, MembershipViewState> {
  /// 提供会员页面控制器，统一编排首屏快照、套餐切换与购买恢复动作。
  const MembershipControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'membershipControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$membershipControllerHash();

  @$internal
  @override
  MembershipController create() => MembershipController();
}

String _$membershipControllerHash() =>
    r'c856242b0afa801e7156eb059db682556a23e21a';

/// 提供会员页面控制器，统一编排首屏快照、套餐切换与购买恢复动作。

abstract class _$MembershipController
    extends $AsyncNotifier<MembershipViewState> {
  FutureOr<MembershipViewState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<MembershipViewState>, MembershipViewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MembershipViewState>, MembershipViewState>,
              AsyncValue<MembershipViewState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
