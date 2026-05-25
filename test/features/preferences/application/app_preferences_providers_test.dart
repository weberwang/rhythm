import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/features/preferences/application/app_preferences_providers.dart';
import 'package:rhythm/features/preferences/domain/app_locale_preference.dart';
import 'package:rhythm/features/preferences/domain/app_preferences.dart';
import 'package:rhythm/features/preferences/domain/app_preferences_repository.dart';
import 'package:rhythm/features/preferences/domain/app_theme_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 验证应用偏好 provider 会派生全局主题与语言，并在保存失败时回滚。
void main() {
  test('初始化时会从共享偏好读取默认值', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
    );
    addTearDown(container.dispose);

    expect(
      container.read(appPreferencesControllerProvider),
      AppPreferences.fallback(),
    );
    expect(container.read(appLocaleProvider), isNull);
    expect(container.read(appThemeModeProvider), ThemeMode.system);
  });

  test('切换语言时会立即更新 locale provider', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
    );
    addTearDown(container.dispose);

    final succeeded = await container
        .read(appPreferencesControllerProvider.notifier)
        .updateLocale(AppLocalePreference.english);

    expect(succeeded, isTrue);
    expect(
      container.read(appPreferencesControllerProvider).localePreference,
      AppLocalePreference.english,
    );
    expect(container.read(appLocaleProvider), const Locale('en'));
  });

  test('切换主题时会立即更新 themeMode provider', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
    );
    addTearDown(container.dispose);

    final succeeded = await container
        .read(appPreferencesControllerProvider.notifier)
        .updateTheme(AppThemePreference.dark);

    expect(succeeded, isTrue);
    expect(
      container.read(appPreferencesControllerProvider).themePreference,
      AppThemePreference.dark,
    );
    expect(container.read(appThemeModeProvider), ThemeMode.dark);
  });

  test('保存失败时会回滚到旧偏好', () async {
    final container = ProviderContainer(
      overrides: [
        appPreferencesRepositoryProvider.overrideWithValue(
          _ThrowingAppPreferencesRepository(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final succeeded = await container
        .read(appPreferencesControllerProvider.notifier)
        .updateTheme(AppThemePreference.dark);

    expect(succeeded, isFalse);
    expect(
      container.read(appPreferencesControllerProvider),
      AppPreferences.fallback(),
    );
    expect(container.read(appThemeModeProvider), ThemeMode.system);
  });
}

/// 提供始终写入失败的仓储，用于验证控制器会回滚乐观更新。
class _ThrowingAppPreferencesRepository implements AppPreferencesRepository {
  @override
  AppPreferences read() => AppPreferences.fallback();

  @override
  Future<void> save(AppPreferences preferences) async {
    throw Exception('save failed');
  }
}
