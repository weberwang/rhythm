import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/theme/app_theme.dart';

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
  });
}
