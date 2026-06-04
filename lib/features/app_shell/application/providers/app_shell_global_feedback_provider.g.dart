// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_shell_global_feedback_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 根据 `sleep-data-core` 的共享状态决定是否需要展示全局反馈。

@ProviderFor(appShellGlobalFeedback)
const appShellGlobalFeedbackProvider = AppShellGlobalFeedbackProvider._();

/// 根据 `sleep-data-core` 的共享状态决定是否需要展示全局反馈。

final class AppShellGlobalFeedbackProvider
    extends
        $FunctionalProvider<
          AppShellGlobalFeedbackKind?,
          AppShellGlobalFeedbackKind?,
          AppShellGlobalFeedbackKind?
        >
    with $Provider<AppShellGlobalFeedbackKind?> {
  /// 根据 `sleep-data-core` 的共享状态决定是否需要展示全局反馈。
  const AppShellGlobalFeedbackProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appShellGlobalFeedbackProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appShellGlobalFeedbackHash();

  @$internal
  @override
  $ProviderElement<AppShellGlobalFeedbackKind?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppShellGlobalFeedbackKind? create(Ref ref) {
    return appShellGlobalFeedback(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppShellGlobalFeedbackKind? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppShellGlobalFeedbackKind?>(value),
    );
  }
}

String _$appShellGlobalFeedbackHash() =>
    r'5d9d4308ae9e67264b61f64e43514ca07e89bb63';
