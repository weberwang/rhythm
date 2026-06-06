// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_account_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 读取当前共享账号快照，供设置页和后续同步状态聚合消费。

@ProviderFor(currentAccountSession)
const currentAccountSessionProvider = CurrentAccountSessionProvider._();

/// 读取当前共享账号快照，供设置页和后续同步状态聚合消费。

final class CurrentAccountSessionProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppAccountSession?>,
          AppAccountSession?,
          FutureOr<AppAccountSession?>
        >
    with
        $FutureModifier<AppAccountSession?>,
        $FutureProvider<AppAccountSession?> {
  /// 读取当前共享账号快照，供设置页和后续同步状态聚合消费。
  const CurrentAccountSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentAccountSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentAccountSessionHash();

  @$internal
  @override
  $FutureProviderElement<AppAccountSession?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AppAccountSession?> create(Ref ref) {
    return currentAccountSession(ref);
  }
}

String _$currentAccountSessionHash() =>
    r'2ee7d454a7090bb2b13f1d348d9927e40d269a9a';
