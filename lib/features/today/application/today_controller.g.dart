// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 聚合目标作息、有效记录与平台状态，向今日页输出单一可渲染状态。

@ProviderFor(todayController)
const todayControllerProvider = TodayControllerProvider._();

/// 聚合目标作息、有效记录与平台状态，向今日页输出单一可渲染状态。

final class TodayControllerProvider
    extends
        $FunctionalProvider<
          AsyncValue<TodayViewState>,
          TodayViewState,
          FutureOr<TodayViewState>
        >
    with $FutureModifier<TodayViewState>, $FutureProvider<TodayViewState> {
  /// 聚合目标作息、有效记录与平台状态，向今日页输出单一可渲染状态。
  const TodayControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayControllerHash();

  @$internal
  @override
  $FutureProviderElement<TodayViewState> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TodayViewState> create(Ref ref) {
    return todayController(ref);
  }
}

String _$todayControllerHash() => r'c639dbfbdecb3b0adacdc88ba3e89c6b1679d044';
