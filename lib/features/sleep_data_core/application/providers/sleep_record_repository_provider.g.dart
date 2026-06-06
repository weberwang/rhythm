// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_record_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 暴露睡眠记录仓储入口，让 today、calendar、insights 共享同一条数据边界。

@ProviderFor(sleepRecordRepository)
const sleepRecordRepositoryProvider = SleepRecordRepositoryProvider._();

/// 暴露睡眠记录仓储入口，让 today、calendar、insights 共享同一条数据边界。

final class SleepRecordRepositoryProvider
    extends
        $FunctionalProvider<
          SleepRecordRepository,
          SleepRecordRepository,
          SleepRecordRepository
        >
    with $Provider<SleepRecordRepository> {
  /// 暴露睡眠记录仓储入口，让 today、calendar、insights 共享同一条数据边界。
  const SleepRecordRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sleepRecordRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sleepRecordRepositoryHash();

  @$internal
  @override
  $ProviderElement<SleepRecordRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SleepRecordRepository create(Ref ref) {
    return sleepRecordRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SleepRecordRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SleepRecordRepository>(value),
    );
  }
}

String _$sleepRecordRepositoryHash() =>
    r'ec8d98415f8f44642d85e1911d5b4fc560b2ea06';
