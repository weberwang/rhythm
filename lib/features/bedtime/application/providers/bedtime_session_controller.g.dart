// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bedtime_session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 暴露当前时间，便于睡前页测试稳定控制倒计时。

@ProviderFor(bedtimeNow)
const bedtimeNowProvider = BedtimeNowProvider._();

/// 暴露当前时间，便于睡前页测试稳定控制倒计时。

final class BedtimeNowProvider
    extends $FunctionalProvider<DateTime, DateTime, DateTime>
    with $Provider<DateTime> {
  /// 暴露当前时间，便于睡前页测试稳定控制倒计时。
  const BedtimeNowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bedtimeNowProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bedtimeNowHash();

  @$internal
  @override
  $ProviderElement<DateTime> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DateTime create(Ref ref) {
    return bedtimeNow(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$bedtimeNowHash() => r'83aa3739423ab52ee7c92fb6a7fb4d7badf0317d';

/// 睡前会话控制器负责收敛倒计时、状态选择和单一动作建议。

@ProviderFor(BedtimeSessionController)
const bedtimeSessionControllerProvider = BedtimeSessionControllerProvider._();

/// 睡前会话控制器负责收敛倒计时、状态选择和单一动作建议。
final class BedtimeSessionControllerProvider
    extends
        $AsyncNotifierProvider<BedtimeSessionController, BedtimeSessionDraft> {
  /// 睡前会话控制器负责收敛倒计时、状态选择和单一动作建议。
  const BedtimeSessionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bedtimeSessionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bedtimeSessionControllerHash();

  @$internal
  @override
  BedtimeSessionController create() => BedtimeSessionController();
}

String _$bedtimeSessionControllerHash() =>
    r'd96350246931fc446eb0f95ae9740345831f446d';

/// 睡前会话控制器负责收敛倒计时、状态选择和单一动作建议。

abstract class _$BedtimeSessionController
    extends $AsyncNotifier<BedtimeSessionDraft> {
  FutureOr<BedtimeSessionDraft> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<BedtimeSessionDraft>, BedtimeSessionDraft>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BedtimeSessionDraft>, BedtimeSessionDraft>,
              AsyncValue<BedtimeSessionDraft>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
