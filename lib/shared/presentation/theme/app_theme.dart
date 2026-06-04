import 'package:flutter/material.dart';

/// 按冻结主题 token 提供轻色与深色主题基线。
class AppTheme {
  /// 私有构造，避免被误实例化。
  const AppTheme._();

  /// 轻色主题来自 `light-theme-freeze.yaml` 的稳定 token。
  static ThemeData light() {
    const primary = Color(0xFF1F6E73);
    const onPrimary = Color(0xFFFFFDF8);
    const background = Color(0xFFFBF7F0);
    const surface = Color(0xFFFFFFFF);
    const onSurface = Color(0xFF18343A);
    const secondary = Color(0xFFDCECF0);
    const outline = Color(0xFFD9E5E8);

    final scheme = const ColorScheme.light(
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSurface,
      surface: surface,
      onSurface: onSurface,
      error: Color(0xFFD96F64),
      onError: Color(0xFFFFF8F7),
    );

    return _buildTheme(
      base: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: background,
      ),
      dividerColor: outline,
    );
  }

  /// 深色主题来自 `dark-theme-freeze.yaml` 的稳定 token。
  static ThemeData dark() {
    const primary = Color(0xFF5FB5B7);
    const onPrimary = Color(0xFF0E1B1E);
    const background = Color(0xFF0F171A);
    const surface = Color(0xFF162226);
    const onSurface = Color(0xFFEEF3F3);
    const secondary = Color(0xFF274148);
    const outline = Color(0xFF2B4046);

    final scheme = const ColorScheme.dark(
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSurface,
      surface: surface,
      onSurface: onSurface,
      error: Color(0xFFE28A80),
      onError: Color(0xFF231413),
    );

    return _buildTheme(
      base: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: background,
      ),
      dividerColor: outline,
    );
  }

  /// 统一补齐导航、按钮与文本层级的主题基线。
  static ThemeData _buildTheme({
    required ThemeData base,
    required Color dividerColor,
  }) {
    return base.copyWith(
      dividerColor: dividerColor,
      appBarTheme: AppBarTheme(
        backgroundColor: base.colorScheme.surface,
        foregroundColor: base.colorScheme.onSurface,
        centerTitle: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: base.colorScheme.surface,
        indicatorColor: base.colorScheme.secondary,
        labelTextStyle: WidgetStatePropertyAll(
          base.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: base.colorScheme.primary,
          foregroundColor: base.colorScheme.onPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: base.colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: dividerColor),
        ),
      ),
    );
  }
}
