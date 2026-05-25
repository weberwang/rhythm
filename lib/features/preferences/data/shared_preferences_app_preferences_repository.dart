import 'package:shared_preferences/shared_preferences.dart';

import '../domain/app_locale_preference.dart';
import '../domain/app_preferences.dart';
import '../domain/app_preferences_repository.dart';
import '../domain/app_theme_preference.dart';

/// 使用共享偏好持久化应用显示偏好，避免页面层散落存储键名。
class SharedPreferencesAppPreferencesRepository
    implements AppPreferencesRepository {
  /// 创建应用偏好仓储。
  SharedPreferencesAppPreferencesRepository(this._sharedPreferences);

  /// 语言偏好存储键。
  static const String localeKey = 'app_preferences.locale';

  /// 主题偏好存储键。
  static const String themeKey = 'app_preferences.theme';

  final SharedPreferences _sharedPreferences;

  @override
  AppPreferences read() {
    return AppPreferences(
      localePreference: _readLocalePreference(),
      themePreference: _readThemePreference(),
    );
  }

  @override
  Future<void> save(AppPreferences preferences) async {
    await _sharedPreferences.setString(
      localeKey,
      preferences.localePreference.name,
    );
    await _sharedPreferences.setString(
      themeKey,
      preferences.themePreference.name,
    );
  }

  AppLocalePreference _readLocalePreference() {
    final storedValue = _sharedPreferences.getString(localeKey);
    return AppLocalePreference.values.firstWhere(
      (preference) => preference.name == storedValue,
      orElse: () => AppLocalePreference.system,
    );
  }

  AppThemePreference _readThemePreference() {
    final storedValue = _sharedPreferences.getString(themeKey);
    return AppThemePreference.values.firstWhere(
      (preference) => preference.name == storedValue,
      orElse: () => AppThemePreference.system,
    );
  }
}
