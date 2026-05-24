// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_schedule_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 提供目标作息设置仓储，统一封装持久化读写入口。

@ProviderFor(goalScheduleSettingsRepository)
const goalScheduleSettingsRepositoryProvider =
    GoalScheduleSettingsRepositoryProvider._();

/// 提供目标作息设置仓储，统一封装持久化读写入口。

final class GoalScheduleSettingsRepositoryProvider
    extends
        $FunctionalProvider<
          GoalScheduleSettingsRepository,
          GoalScheduleSettingsRepository,
          GoalScheduleSettingsRepository
        >
    with $Provider<GoalScheduleSettingsRepository> {
  /// 提供目标作息设置仓储，统一封装持久化读写入口。
  const GoalScheduleSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalScheduleSettingsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalScheduleSettingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<GoalScheduleSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoalScheduleSettingsRepository create(Ref ref) {
    return goalScheduleSettingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalScheduleSettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoalScheduleSettingsRepository>(
        value,
      ),
    );
  }
}

String _$goalScheduleSettingsRepositoryHash() =>
    r'22aba8559e20dc59b43079ce680f9e20a91d1bf9';

/// 读取最近保存的目标作息设置，供今日页和后续阶段复用。

@ProviderFor(savedGoalScheduleSettings)
const savedGoalScheduleSettingsProvider = SavedGoalScheduleSettingsProvider._();

/// 读取最近保存的目标作息设置，供今日页和后续阶段复用。

final class SavedGoalScheduleSettingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<GoalScheduleSettings?>,
          GoalScheduleSettings?,
          FutureOr<GoalScheduleSettings?>
        >
    with
        $FutureModifier<GoalScheduleSettings?>,
        $FutureProvider<GoalScheduleSettings?> {
  /// 读取最近保存的目标作息设置，供今日页和后续阶段复用。
  const SavedGoalScheduleSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedGoalScheduleSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedGoalScheduleSettingsHash();

  @$internal
  @override
  $FutureProviderElement<GoalScheduleSettings?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GoalScheduleSettings?> create(Ref ref) {
    return savedGoalScheduleSettings(ref);
  }
}

String _$savedGoalScheduleSettingsHash() =>
    r'39de40dd0c97c7ceb8fc44f8b16bccf209b51340';
