import 'package:flutter/material.dart';

import 'app_theme_tokens.dart';

/// 提供 Rhythm 的全局视觉主题，先保证 MVP 阶段拥有统一的基础样式。
class AppTheme {
  const AppTheme._();

  /// 构建浅色主题，后续页面和组件都只消费语义 token，而不是直接写原始颜色。
  static ThemeData light() => _buildTheme(AppThemeTokens.light);

  /// 构建暗色主题，从同一套语义 token 派生，保证与亮色稿保持同源关系。
  static ThemeData dark() => _buildTheme(AppThemeTokens.dark);

  /// 根据主题 token 生成统一的 Material 主题，减少亮暗主题分叉。
  static ThemeData _buildTheme(AppThemeTokens tokens) {
    final baseScheme = ColorScheme.fromSeed(
      seedColor: tokens.seed,
      brightness: tokens.brightness,
    );
    final colorScheme = baseScheme.copyWith(
      primary: tokens.primary,
      onPrimary: tokens.textInverse,
      primaryContainer: tokens.primaryMuted,
      onPrimaryContainer: tokens.textInverse,
      secondary: tokens.success,
      onSecondary: tokens.textInverse,
      secondaryContainer: tokens.successSurface,
      onSecondaryContainer: tokens.textPrimary,
      tertiary: tokens.warning,
      onTertiary: tokens.textPrimary,
      tertiaryContainer: tokens.warningSurface,
      onTertiaryContainer: tokens.textPrimary,
      error: tokens.danger,
      onError: tokens.textInverse,
      errorContainer: tokens.dangerSurface,
      onErrorContainer: tokens.textPrimary,
      surface: tokens.surface,
      onSurface: tokens.textPrimary,
      surfaceContainerHighest: tokens.surfaceElevated,
      onSurfaceVariant: tokens.textSecondary,
      outline: tokens.divider,
      outlineVariant: tokens.divider,
      shadow: const Color(0x1A000000),
    );

    final textTheme =
        Typography.material2021(
          platform: TargetPlatform.android,
          colorScheme: colorScheme,
        ).black.apply(
          bodyColor: tokens.textPrimary,
          displayColor: tokens.textPrimary,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: tokens.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: tokens.background,
      canvasColor: tokens.background,
      dividerColor: tokens.divider,
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: tokens.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: tokens.divider),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: tokens.background,
        foregroundColor: tokens.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: tokens.surface,
        indicatorColor: colorScheme.primaryContainer,
        surfaceTintColor: Colors.transparent,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final color = states.contains(WidgetState.selected)
              ? colorScheme.onPrimaryContainer
              : tokens.textMuted;
          return IconThemeData(color: color);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          // 选中文案位于底板上而不在指示器内部，必须保留品牌色对比度。
          return TextStyle(
            color: states.contains(WidgetState.selected)
                ? colorScheme.primary
                : tokens.textMuted,
            fontWeight: FontWeight.w600,
          );
        }),
      ),
    );
  }
}
