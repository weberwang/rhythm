import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/theme/app_theme.dart';
import 'package:rhythm/app/theme/app_theme_tokens.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

void main() {
  group('AppTheme 页面过渡', () {
    test('浅色主题在 Android 上不强制覆盖为 iOS 风格页面过渡', () {
      final theme = AppTheme.light();

      expect(
        theme.pageTransitionsTheme.builders[TargetPlatform.android],
        isNot(isA<CupertinoPageTransitionsBuilder>()),
      );
    });

    test('深色主题在 Android 上不强制覆盖为 iOS 风格页面过渡', () {
      final theme = AppTheme.dark();

      expect(
        theme.pageTransitionsTheme.builders[TargetPlatform.android],
        isNot(isA<CupertinoPageTransitionsBuilder>()),
      );
    });

    test('浅色主题挂载 Pencil 双字体和共享主题扩展', () {
      final theme = AppTheme.light();

      expect(
        theme.textTheme.headlineMedium?.fontFamily,
        AppThemeTokens.light.fontHeading,
      );
      expect(
        theme.textTheme.bodyMedium?.fontFamily,
        AppThemeTokens.light.fontBody,
      );
      expect(theme.extension<RhythmHeroThemeExtension>(), isNotNull);
      expect(theme.extension<RhythmOverlayThemeExtension>(), isNotNull);
      expect(theme.extension<RhythmStatusThemeExtension>(), isNotNull);
      expect(theme.extension<RhythmChipThemeExtension>(), isNotNull);
    });
  });
}
