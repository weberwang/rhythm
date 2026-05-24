// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_context_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 提供当前设备时间上下文，后续可无缝替换为 `flutter_timezone` 的真实时区读取。

@ProviderFor(timeContext)
const timeContextProvider = TimeContextProvider._();

/// 提供当前设备时间上下文，后续可无缝替换为 `flutter_timezone` 的真实时区读取。

final class TimeContextProvider
    extends $FunctionalProvider<TimeContext, TimeContext, TimeContext>
    with $Provider<TimeContext> {
  /// 提供当前设备时间上下文，后续可无缝替换为 `flutter_timezone` 的真实时区读取。
  const TimeContextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timeContextProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timeContextHash();

  @$internal
  @override
  $ProviderElement<TimeContext> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TimeContext create(Ref ref) {
    return timeContext(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimeContext value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimeContext>(value),
    );
  }
}

String _$timeContextHash() => r'd7d2f7c6f809ef8fb588278efc7df10f75415373';
