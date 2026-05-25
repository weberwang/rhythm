import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/preferences/data/shared_preferences_app_preferences_repository.dart';
import 'package:rhythm/features/preferences/domain/app_locale_preference.dart';
import 'package:rhythm/features/preferences/domain/app_preferences.dart';
import 'package:rhythm/features/preferences/domain/app_theme_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 验证应用偏好仓储会正确回落默认值并持久化用户选择。
void main() {
  test('未保存偏好时返回跟随系统默认值', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final preferences = await SharedPreferences.getInstance();
    final repository = SharedPreferencesAppPreferencesRepository(preferences);

    final restored = repository.read();

    expect(restored, AppPreferences.fallback());
  });

  test('保存后会恢复语言与主题偏好', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final preferences = await SharedPreferences.getInstance();
    final repository = SharedPreferencesAppPreferencesRepository(preferences);
    const expected = AppPreferences(
      localePreference: AppLocalePreference.english,
      themePreference: AppThemePreference.dark,
    );

    await repository.save(expected);
    final restored = repository.read();

    expect(restored, expected);
  });
}
