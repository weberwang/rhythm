// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_entry_intent_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 暴露当前统一入口意图，为后续通知与小组件路由分发保留扩展点。

@ProviderFor(currentEntryIntent)
const currentEntryIntentProvider = CurrentEntryIntentProvider._();

/// 暴露当前统一入口意图，为后续通知与小组件路由分发保留扩展点。

final class CurrentEntryIntentProvider
    extends $FunctionalProvider<EntryIntent, EntryIntent, EntryIntent>
    with $Provider<EntryIntent> {
  /// 暴露当前统一入口意图，为后续通知与小组件路由分发保留扩展点。
  const CurrentEntryIntentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentEntryIntentProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentEntryIntentHash();

  @$internal
  @override
  $ProviderElement<EntryIntent> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EntryIntent create(Ref ref) {
    return currentEntryIntent(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EntryIntent value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EntryIntent>(value),
    );
  }
}

String _$currentEntryIntentHash() =>
    r'b42478af60b9cf0e53d727e4878fcb3d55bade32';
