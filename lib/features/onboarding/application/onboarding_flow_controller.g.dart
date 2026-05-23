// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_flow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 管理首次引导三步状态推进和草稿收集。

@ProviderFor(OnboardingFlowController)
const onboardingFlowControllerProvider = OnboardingFlowControllerProvider._();

/// 管理首次引导三步状态推进和草稿收集。
final class OnboardingFlowControllerProvider
    extends $NotifierProvider<OnboardingFlowController, OnboardingFlowState> {
  /// 管理首次引导三步状态推进和草稿收集。
  const OnboardingFlowControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingFlowControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingFlowControllerHash();

  @$internal
  @override
  OnboardingFlowController create() => OnboardingFlowController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingFlowState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingFlowState>(value),
    );
  }
}

String _$onboardingFlowControllerHash() =>
    r'aacf89fece06ffb39d5e79b0b87bb4cd52af55ed';

/// 管理首次引导三步状态推进和草稿收集。

abstract class _$OnboardingFlowController
    extends $Notifier<OnboardingFlowState> {
  OnboardingFlowState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<OnboardingFlowState, OnboardingFlowState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OnboardingFlowState, OnboardingFlowState>,
              OnboardingFlowState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
