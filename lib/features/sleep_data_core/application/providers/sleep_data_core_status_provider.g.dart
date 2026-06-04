// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_data_core_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 暴露当前数据来源可信度，后续可由健康读取、手动修正链路接入真实实现。

@ProviderFor(sleepSourceConfidence)
const sleepSourceConfidenceProvider = SleepSourceConfidenceProvider._();

/// 暴露当前数据来源可信度，后续可由健康读取、手动修正链路接入真实实现。

final class SleepSourceConfidenceProvider
    extends
        $FunctionalProvider<
          SleepSourceConfidence,
          SleepSourceConfidence,
          SleepSourceConfidence
        >
    with $Provider<SleepSourceConfidence> {
  /// 暴露当前数据来源可信度，后续可由健康读取、手动修正链路接入真实实现。
  const SleepSourceConfidenceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sleepSourceConfidenceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sleepSourceConfidenceHash();

  @$internal
  @override
  $ProviderElement<SleepSourceConfidence> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SleepSourceConfidence create(Ref ref) {
    return sleepSourceConfidence(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SleepSourceConfidence value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SleepSourceConfidence>(value),
    );
  }
}

String _$sleepSourceConfidenceHash() =>
    r'038fff7d4ed8e9718b23a9788ad1ba9e6624ca83';

/// 暴露当前同步状态，先统一“可恢复失败”语义，再延后真实同步接线。

@ProviderFor(sleepSyncStatus)
const sleepSyncStatusProvider = SleepSyncStatusProvider._();

/// 暴露当前同步状态，先统一“可恢复失败”语义，再延后真实同步接线。

final class SleepSyncStatusProvider
    extends
        $FunctionalProvider<SleepSyncStatus, SleepSyncStatus, SleepSyncStatus>
    with $Provider<SleepSyncStatus> {
  /// 暴露当前同步状态，先统一“可恢复失败”语义，再延后真实同步接线。
  const SleepSyncStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sleepSyncStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sleepSyncStatusHash();

  @$internal
  @override
  $ProviderElement<SleepSyncStatus> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SleepSyncStatus create(Ref ref) {
    return sleepSyncStatus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SleepSyncStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SleepSyncStatus>(value),
    );
  }
}

String _$sleepSyncStatusHash() => r'8ea43cf41eda4c4083471d0d709b21f042ce5b54';

/// 暴露当前时区上下文状态，为后续跨时区确认入口预留统一边界。

@ProviderFor(sleepTimezoneContext)
const sleepTimezoneContextProvider = SleepTimezoneContextProvider._();

/// 暴露当前时区上下文状态，为后续跨时区确认入口预留统一边界。

final class SleepTimezoneContextProvider
    extends
        $FunctionalProvider<
          SleepTimezoneContext,
          SleepTimezoneContext,
          SleepTimezoneContext
        >
    with $Provider<SleepTimezoneContext> {
  /// 暴露当前时区上下文状态，为后续跨时区确认入口预留统一边界。
  const SleepTimezoneContextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sleepTimezoneContextProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sleepTimezoneContextHash();

  @$internal
  @override
  $ProviderElement<SleepTimezoneContext> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SleepTimezoneContext create(Ref ref) {
    return sleepTimezoneContext(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SleepTimezoneContext value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SleepTimezoneContext>(value),
    );
  }
}

String _$sleepTimezoneContextHash() =>
    r'0f78e7b66c9a970441be397ef2b90c2c9cdb3feb';

/// 聚合 `sleep-data-core` 的共享状态快照，避免下游页面各自拼装语义。

@ProviderFor(sleepDataCoreStatus)
const sleepDataCoreStatusProvider = SleepDataCoreStatusProvider._();

/// 聚合 `sleep-data-core` 的共享状态快照，避免下游页面各自拼装语义。

final class SleepDataCoreStatusProvider
    extends
        $FunctionalProvider<
          SleepDataCoreStatus,
          SleepDataCoreStatus,
          SleepDataCoreStatus
        >
    with $Provider<SleepDataCoreStatus> {
  /// 聚合 `sleep-data-core` 的共享状态快照，避免下游页面各自拼装语义。
  const SleepDataCoreStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sleepDataCoreStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sleepDataCoreStatusHash();

  @$internal
  @override
  $ProviderElement<SleepDataCoreStatus> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SleepDataCoreStatus create(Ref ref) {
    return sleepDataCoreStatus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SleepDataCoreStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SleepDataCoreStatus>(value),
    );
  }
}

String _$sleepDataCoreStatusHash() =>
    r'5d75d0031703d9fe109c85215bf1aed2aa3ce86f';
