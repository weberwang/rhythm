// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bedtime_session_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 暴露睡前会话仓储，让 bedtime 控制器只通过应用层消费持久化边界。

@ProviderFor(bedtimeSessionRepository)
const bedtimeSessionRepositoryProvider = BedtimeSessionRepositoryProvider._();

/// 暴露睡前会话仓储，让 bedtime 控制器只通过应用层消费持久化边界。

final class BedtimeSessionRepositoryProvider
    extends
        $FunctionalProvider<
          BedtimeSessionRepository,
          BedtimeSessionRepository,
          BedtimeSessionRepository
        >
    with $Provider<BedtimeSessionRepository> {
  /// 暴露睡前会话仓储，让 bedtime 控制器只通过应用层消费持久化边界。
  const BedtimeSessionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bedtimeSessionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bedtimeSessionRepositoryHash();

  @$internal
  @override
  $ProviderElement<BedtimeSessionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BedtimeSessionRepository create(Ref ref) {
    return bedtimeSessionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BedtimeSessionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BedtimeSessionRepository>(value),
    );
  }
}

String _$bedtimeSessionRepositoryHash() =>
    r'a5a53ac4a569c4a2befde703c998b78be0a67fad';
