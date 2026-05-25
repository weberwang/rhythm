import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/features/preferences/data/shared_preferences_app_preferences_repository.dart';
import 'package:rhythm/features/preferences/domain/app_locale_preference.dart';
import 'package:rhythm/features/preferences/domain/app_preferences.dart';
import 'package:rhythm/features/preferences/domain/app_preferences_repository.dart';
import 'package:rhythm/features/preferences/domain/app_theme_preference.dart';

part 'app_preferences_providers.g.dart';

/// 提供应用偏好仓储，统一封装显示层偏好的本地持久化入口。
@riverpod
AppPreferencesRepository appPreferencesRepository(Ref ref) {
  return SharedPreferencesAppPreferencesRepository(
    ref.watch(sharedPreferencesProvider),
  );
}

/// 管理全局语言与主题偏好，并在保存失败时回滚乐观更新。
@riverpod
class AppPreferencesController extends _$AppPreferencesController {
  /// 读取当前已保存的应用偏好，确保根应用首帧即可消费同步状态。
  @override
  AppPreferences build() {
    return ref.watch(appPreferencesRepositoryProvider).read();
  }

  /// 更新语言偏好，失败时回滚旧值并返回 `false`。
  Future<bool> updateLocale(AppLocalePreference preference) {
    return _save(state.copyWith(localePreference: preference));
  }

  /// 更新主题偏好，失败时回滚旧值并返回 `false`。
  Future<bool> updateTheme(AppThemePreference preference) {
    return _save(state.copyWith(themePreference: preference));
  }

  Future<bool> _save(AppPreferences nextState) async {
    final previousState = state;
    state = nextState;
    try {
      await ref.read(appPreferencesRepositoryProvider).save(nextState);
      return true;
    } catch (_) {
      // 偏好切换优先保证即时反馈，但写入失败时必须回退，避免界面与持久化脱节。
      state = previousState;
      return false;
    }
  }
}

/// 将应用语言偏好映射为 `MaterialApp` 可直接消费的全局 Locale。
@riverpod
Locale? appLocale(Ref ref) {
  return switch (ref.watch(appPreferencesControllerProvider).localePreference) {
    AppLocalePreference.system => null,
    AppLocalePreference.simplifiedChinese => const Locale('zh'),
    AppLocalePreference.english => const Locale('en'),
  };
}

/// 将应用主题偏好映射为 `MaterialApp` 可直接消费的主题模式。
@riverpod
ThemeMode appThemeMode(Ref ref) {
  return switch (ref.watch(appPreferencesControllerProvider).themePreference) {
    AppThemePreference.system => ThemeMode.system,
    AppThemePreference.light => ThemeMode.light,
    AppThemePreference.dark => ThemeMode.dark,
  };
}
