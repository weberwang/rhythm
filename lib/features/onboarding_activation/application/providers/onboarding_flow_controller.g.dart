// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_flow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 管理 onboarding 的最小激活状态机，并统一提交权限结果、作息与完成标记。

@ProviderFor(OnboardingFlowController)
const onboardingFlowControllerProvider = OnboardingFlowControllerProvider._();

/// 管理 onboarding 的最小激活状态机，并统一提交权限结果、作息与完成标记。
final class OnboardingFlowControllerProvider
    extends $NotifierProvider<OnboardingFlowController, OnboardingDraft> {
  /// 管理 onboarding 的最小激活状态机，并统一提交权限结果、作息与完成标记。
  const OnboardingFlowControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingFlowControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingFlowControllerHash();

  @$internal
  @override
  OnboardingFlowController create() => OnboardingFlowController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingDraft value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingDraft>(value),
    );
  }
}

String _$onboardingFlowControllerHash() =>
    r'745ddac421775c71eb4804ce9af68e87e811c049';

/// 管理 onboarding 的最小激活状态机，并统一提交权限结果、作息与完成标记。

abstract class _$OnboardingFlowController extends $Notifier<OnboardingDraft> {
  OnboardingDraft build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<OnboardingDraft, OnboardingDraft>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OnboardingDraft, OnboardingDraft>,
              OnboardingDraft,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
