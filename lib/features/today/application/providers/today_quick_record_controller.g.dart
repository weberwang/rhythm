// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_quick_record_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 承接 today 快捷补录提交，避免页面直接依赖仓储或生成业务 id。

@ProviderFor(TodayQuickRecordController)
const todayQuickRecordControllerProvider =
    TodayQuickRecordControllerProvider._();

/// 承接 today 快捷补录提交，避免页面直接依赖仓储或生成业务 id。
final class TodayQuickRecordControllerProvider
    extends $AsyncNotifierProvider<TodayQuickRecordController, void> {
  /// 承接 today 快捷补录提交，避免页面直接依赖仓储或生成业务 id。
  const TodayQuickRecordControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayQuickRecordControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayQuickRecordControllerHash();

  @$internal
  @override
  TodayQuickRecordController create() => TodayQuickRecordController();
}

String _$todayQuickRecordControllerHash() =>
    r'73956cbad6e30a0b7fae204271ac54cac270d95a';

/// 承接 today 快捷补录提交，避免页面直接依赖仓储或生成业务 id。

abstract class _$TodayQuickRecordController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
