// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_snapshot_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 聚合 today 首屏最小可用上下文，先回答“昨晚怎么样 / 今晚做什么”，再等待真实记录接线。

@ProviderFor(todaySnapshot)
const todaySnapshotProvider = TodaySnapshotProvider._();

/// 聚合 today 首屏最小可用上下文，先回答“昨晚怎么样 / 今晚做什么”，再等待真实记录接线。

final class TodaySnapshotProvider
    extends
        $FunctionalProvider<
          AsyncValue<TodaySnapshot>,
          TodaySnapshot,
          FutureOr<TodaySnapshot>
        >
    with $FutureModifier<TodaySnapshot>, $FutureProvider<TodaySnapshot> {
  /// 聚合 today 首屏最小可用上下文，先回答“昨晚怎么样 / 今晚做什么”，再等待真实记录接线。
  const TodaySnapshotProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todaySnapshotProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todaySnapshotHash();

  @$internal
  @override
  $FutureProviderElement<TodaySnapshot> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TodaySnapshot> create(Ref ref) {
    return todaySnapshot(ref);
  }
}

String _$todaySnapshotHash() => r'bdd9489e4a9dd23fb5ad1a328167fc979a6562af';
