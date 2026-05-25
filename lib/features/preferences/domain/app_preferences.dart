import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_locale_preference.dart';
import 'app_theme_preference.dart';

part 'app_preferences.freezed.dart';

/// 聚合应用级显示偏好，避免语言与主题在各层单独漂浮。
@freezed
abstract class AppPreferences with _$AppPreferences {
  /// 创建应用偏好实体，默认回落到跟随系统。
  const factory AppPreferences({
    @Default(AppLocalePreference.system) AppLocalePreference localePreference,
    @Default(AppThemePreference.system) AppThemePreference themePreference,
  }) = _AppPreferences;

  /// 返回首次启动或异常回退时使用的默认偏好。
  factory AppPreferences.fallback() => const AppPreferences();
}
