import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/theme/app_theme.dart';

/// 验证底部导航选中态文案使用独立语义色，避免与指示器反色复用后不可见。
void main() {
  group('AppTheme 底部导航', () {
    test('浅色主题的选中态文案使用品牌色', () {
      final theme = AppTheme.light();
      final selectedLabelStyle = theme.navigationBarTheme.labelTextStyle
          ?.resolve({WidgetState.selected});
      final selectedIconTheme = theme.navigationBarTheme.iconTheme?.resolve({
        WidgetState.selected,
      });

      expect(selectedLabelStyle, isNotNull);
      expect(selectedIconTheme, isNotNull);
      expect(selectedLabelStyle!.color, theme.colorScheme.primary);
      expect(
        selectedLabelStyle.color,
        isNot(equals(selectedIconTheme!.color)),
      );
    });
  });
}
