// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_preferences_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 提供应用偏好仓储，统一封装显示层偏好的本地持久化入口。

@ProviderFor(appPreferencesRepository)
const appPreferencesRepositoryProvider = AppPreferencesRepositoryProvider._();

/// 提供应用偏好仓储，统一封装显示层偏好的本地持久化入口。

final class AppPreferencesRepositoryProvider
    extends
        $FunctionalProvider<
          AppPreferencesRepository,
          AppPreferencesRepository,
          AppPreferencesRepository
        >
    with $Provider<AppPreferencesRepository> {
  /// 提供应用偏好仓储，统一封装显示层偏好的本地持久化入口。
  const AppPreferencesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appPreferencesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appPreferencesRepositoryHash();

  @$internal
  @override
  $ProviderElement<AppPreferencesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppPreferencesRepository create(Ref ref) {
    return appPreferencesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppPreferencesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppPreferencesRepository>(value),
    );
  }
}

String _$appPreferencesRepositoryHash() =>
    r'cb80e7ac04f316d0e5ae4a9e922b5823e4b93163';

/// 管理全局语言与主题偏好，并在保存失败时回滚乐观更新。

@ProviderFor(AppPreferencesController)
const appPreferencesControllerProvider = AppPreferencesControllerProvider._();

/// 管理全局语言与主题偏好，并在保存失败时回滚乐观更新。
final class AppPreferencesControllerProvider
    extends $NotifierProvider<AppPreferencesController, AppPreferences> {
  /// 管理全局语言与主题偏好，并在保存失败时回滚乐观更新。
  const AppPreferencesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appPreferencesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appPreferencesControllerHash();

  @$internal
  @override
  AppPreferencesController create() => AppPreferencesController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppPreferences>(value),
    );
  }
}

String _$appPreferencesControllerHash() =>
    r'd9a339046c04d9119c2a6639760373b1169dd4f5';

/// 管理全局语言与主题偏好，并在保存失败时回滚乐观更新。

abstract class _$AppPreferencesController extends $Notifier<AppPreferences> {
  AppPreferences build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AppPreferences, AppPreferences>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppPreferences, AppPreferences>,
              AppPreferences,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// 将应用语言偏好映射为 `MaterialApp` 可直接消费的全局 Locale。

@ProviderFor(appLocale)
const appLocaleProvider = AppLocaleProvider._();

/// 将应用语言偏好映射为 `MaterialApp` 可直接消费的全局 Locale。

final class AppLocaleProvider
    extends $FunctionalProvider<Locale?, Locale?, Locale?>
    with $Provider<Locale?> {
  /// 将应用语言偏好映射为 `MaterialApp` 可直接消费的全局 Locale。
  const AppLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLocaleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLocaleHash();

  @$internal
  @override
  $ProviderElement<Locale?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Locale? create(Ref ref) {
    return appLocale(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale?>(value),
    );
  }
}

String _$appLocaleHash() => r'340e62632ec6e3d5a8e9af15543de4b24a09e2ed';

/// 将应用主题偏好映射为 `MaterialApp` 可直接消费的主题模式。

@ProviderFor(appThemeMode)
const appThemeModeProvider = AppThemeModeProvider._();

/// 将应用主题偏好映射为 `MaterialApp` 可直接消费的主题模式。

final class AppThemeModeProvider
    extends $FunctionalProvider<ThemeMode, ThemeMode, ThemeMode>
    with $Provider<ThemeMode> {
  /// 将应用主题偏好映射为 `MaterialApp` 可直接消费的主题模式。
  const AppThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeModeHash();

  @$internal
  @override
  $ProviderElement<ThemeMode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeMode create(Ref ref) {
    return appThemeMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$appThemeModeHash() => r'161ce7fb9f12bf05672ed0aae098a965d808e4e5';
