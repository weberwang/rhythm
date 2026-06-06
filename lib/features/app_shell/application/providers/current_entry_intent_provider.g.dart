// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_entry_intent_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 暴露当前统一入口意图，并允许在首启完成后重置一次性外部入口。

@ProviderFor(CurrentEntryIntent)
const currentEntryIntentProvider = CurrentEntryIntentProvider._();

/// 暴露当前统一入口意图，并允许在首启完成后重置一次性外部入口。
final class CurrentEntryIntentProvider
    extends $NotifierProvider<CurrentEntryIntent, EntryIntent> {
  /// 暴露当前统一入口意图，并允许在首启完成后重置一次性外部入口。
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
  CurrentEntryIntent create() => CurrentEntryIntent();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EntryIntent value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EntryIntent>(value),
    );
  }
}

String _$currentEntryIntentHash() =>
    r'f5e8c59363ca8fccae3cd251a4b91b6680ede33d';

/// 暴露当前统一入口意图，并允许在首启完成后重置一次性外部入口。

abstract class _$CurrentEntryIntent extends $Notifier<EntryIntent> {
  EntryIntent build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<EntryIntent, EntryIntent>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EntryIntent, EntryIntent>,
              EntryIntent,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
