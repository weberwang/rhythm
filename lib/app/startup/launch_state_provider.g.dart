// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 读取启动期最小上下文，并输出根级跳转决策。

@ProviderFor(launchState)
const launchStateProvider = LaunchStateProvider._();

/// 读取启动期最小上下文，并输出根级跳转决策。

final class LaunchStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<LaunchSnapshot>,
          LaunchSnapshot,
          FutureOr<LaunchSnapshot>
        >
    with $FutureModifier<LaunchSnapshot>, $FutureProvider<LaunchSnapshot> {
  /// 读取启动期最小上下文，并输出根级跳转决策。
  const LaunchStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'launchStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$launchStateHash();

  @$internal
  @override
  $FutureProviderElement<LaunchSnapshot> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LaunchSnapshot> create(Ref ref) {
    return launchState(ref);
  }
}

String _$launchStateHash() => r'8ec6d01d8379959c64caa0dda3339d0c5266e7bf';

/// 标记引导已经完成，让后续启动直接进入主壳。

@ProviderFor(completeOnboarding)
const completeOnboardingProvider = CompleteOnboardingProvider._();

/// 标记引导已经完成，让后续启动直接进入主壳。

final class CompleteOnboardingProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// 标记引导已经完成，让后续启动直接进入主壳。
  const CompleteOnboardingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completeOnboardingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completeOnboardingHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return completeOnboarding(ref);
  }
}

String _$completeOnboardingHash() =>
    r'1f4d0a4cf536db591c3b05031255cd253758e635';
