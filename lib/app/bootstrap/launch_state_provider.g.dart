// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 提供首次激活状态仓储，统一封装持久化键和值读取逻辑。

@ProviderFor(launchStateRepository)
const launchStateRepositoryProvider = LaunchStateRepositoryProvider._();

/// 提供首次激活状态仓储，统一封装持久化键和值读取逻辑。

final class LaunchStateRepositoryProvider
    extends
        $FunctionalProvider<
          LaunchStateRepository,
          LaunchStateRepository,
          LaunchStateRepository
        >
    with $Provider<LaunchStateRepository> {
  /// 提供首次激活状态仓储，统一封装持久化键和值读取逻辑。
  const LaunchStateRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'launchStateRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$launchStateRepositoryHash();

  @$internal
  @override
  $ProviderElement<LaunchStateRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LaunchStateRepository create(Ref ref) {
    return launchStateRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LaunchStateRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LaunchStateRepository>(value),
    );
  }
}

String _$launchStateRepositoryHash() =>
    r'67977a92aa07d5d0096cb15debffc999606e3da4';

/// 提供是否完成首次引导的异步状态，供启动分发页决定跳转目标。

@ProviderFor(onboardingCompleted)
const onboardingCompletedProvider = OnboardingCompletedProvider._();

/// 提供是否完成首次引导的异步状态，供启动分发页决定跳转目标。

final class OnboardingCompletedProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// 提供是否完成首次引导的异步状态，供启动分发页决定跳转目标。
  const OnboardingCompletedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingCompletedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingCompletedHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return onboardingCompleted(ref);
  }
}

String _$onboardingCompletedHash() =>
    r'e8d90e976b7c6cb84f0ca1fdd9f51ddea7352cb8';
