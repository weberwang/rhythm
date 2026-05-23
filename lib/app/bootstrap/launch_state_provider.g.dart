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

/// 提供是否完成首次引导的状态，供启动分发页决定跳转目标。

@ProviderFor(onboardingCompleted)
const onboardingCompletedProvider = OnboardingCompletedProvider._();

/// 提供是否完成首次引导的状态，供启动分发页决定跳转目标。

final class OnboardingCompletedProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// 提供是否完成首次引导的状态，供启动分发页决定跳转目标。
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
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return onboardingCompleted(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$onboardingCompletedHash() =>
    r'b88b007d9c47e46b5a6d1d9bc447a27aa9035ac0';
