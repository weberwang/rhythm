// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_schedule_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 统一暴露目标作息仓储实现，后续页面只通过应用层消费该依赖。

@ProviderFor(goalScheduleRepository)
const goalScheduleRepositoryProvider = GoalScheduleRepositoryProvider._();

/// 统一暴露目标作息仓储实现，后续页面只通过应用层消费该依赖。

final class GoalScheduleRepositoryProvider
    extends
        $FunctionalProvider<
          GoalScheduleRepository,
          GoalScheduleRepository,
          GoalScheduleRepository
        >
    with $Provider<GoalScheduleRepository> {
  /// 统一暴露目标作息仓储实现，后续页面只通过应用层消费该依赖。
  const GoalScheduleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalScheduleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalScheduleRepositoryHash();

  @$internal
  @override
  $ProviderElement<GoalScheduleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoalScheduleRepository create(Ref ref) {
    return goalScheduleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalScheduleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoalScheduleRepository>(value),
    );
  }
}

String _$goalScheduleRepositoryHash() =>
    r'833237d610f708d11ea77057f9695d6b9c75e0fb';
