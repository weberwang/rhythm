// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_session_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 暴露共享账号快照仓储，让引导、设置和启动层只依赖稳定边界。

@ProviderFor(accountSessionRepository)
const accountSessionRepositoryProvider = AccountSessionRepositoryProvider._();

/// 暴露共享账号快照仓储，让引导、设置和启动层只依赖稳定边界。

final class AccountSessionRepositoryProvider
    extends
        $FunctionalProvider<
          AccountSessionRepository,
          AccountSessionRepository,
          AccountSessionRepository
        >
    with $Provider<AccountSessionRepository> {
  /// 暴露共享账号快照仓储，让引导、设置和启动层只依赖稳定边界。
  const AccountSessionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountSessionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountSessionRepositoryHash();

  @$internal
  @override
  $ProviderElement<AccountSessionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AccountSessionRepository create(Ref ref) {
    return accountSessionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountSessionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountSessionRepository>(value),
    );
  }
}

String _$accountSessionRepositoryHash() =>
    r'cc31c2c109fb9e921af2ccb8444e31c17a493999';
