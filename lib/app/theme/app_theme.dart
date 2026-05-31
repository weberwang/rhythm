import 'package:flutter/material.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

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
      onPrimaryContainer: tokens.textPrimary,
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
      shadow: tokens.overlayScrim,
    );
    final textTheme = _buildTextTheme(colorScheme, tokens);
    final heroTokens = RhythmHeroThemeExtension(
      topColor: tokens.heroTop,
      bottomColor: tokens.heroBottom,
      textColor: tokens.textInverse,
      borderColor: tokens.borderSoft,
    );
    final overlayTokens = RhythmOverlayThemeExtension(
      sheetColor: tokens.surfaceSoft,
      dialogColor: tokens.surface,
      bannerColor: tokens.surface,
      scrimColor: tokens.overlayScrim,
      shadowColor: tokens.overlayScrim,
    );
    final statusTokens = RhythmStatusThemeExtension(
      success: tokens.success,
      successSurface: tokens.successSurface,
      warning: tokens.warning,
      warningSurface: tokens.warningSurface,
      danger: tokens.danger,
      dangerSurface: tokens.dangerSurface,
      info: tokens.info,
      infoSurface: tokens.infoSurface,
    );
    final chipTokens = RhythmChipThemeExtension(
      backgroundColor: tokens.surfaceSoft,
      selectedBackgroundColor: tokens.primaryMuted,
      borderColor: tokens.divider,
      selectedBorderColor: tokens.primary.withValues(alpha: 0.22),
      foregroundColor: tokens.textSecondary,
      selectedForegroundColor: tokens.primary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: tokens.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: tokens.background,
      canvasColor: tokens.surfaceSoft,
      dividerColor: tokens.divider,
      textTheme: textTheme,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 56),
          backgroundColor: tokens.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: tokens.primaryMuted,
          disabledForegroundColor: colorScheme.onPrimary.withValues(
            alpha: 0.72,
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontFamily: tokens.fontBody,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 56),
          backgroundColor: tokens.surface.withValues(
            alpha: tokens.brightness == Brightness.light ? 0.9 : 1,
          ),
          foregroundColor: tokens.textPrimary,
          disabledForegroundColor: tokens.textMuted,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          side: BorderSide(color: tokens.divider),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontFamily: tokens.fontBody,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: tokens.surface,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: tokens.divider),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: tokens.background,
        foregroundColor: tokens.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: overlayTokens.dialogColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(color: tokens.divider),
        ),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: overlayTokens.sheetColor,
        modalBackgroundColor: overlayTokens.sheetColor,
        surfaceTintColor: Colors.transparent,
        modalElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          side: BorderSide(color: tokens.divider),
        ),
        dragHandleColor: tokens.textMuted.withValues(alpha: 0.28),
        dragHandleSize: const Size(44, 4),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: tokens.surfaceSoft,
        hintStyle: textTheme.bodyMedium?.copyWith(color: tokens.textMuted),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: tokens.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: tokens.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: tokens.primary, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: tokens.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: tokens.danger, width: 1.4),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: tokens.surfaceSoft,
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
            fontFamily: tokens.fontBody,
            color: states.contains(WidgetState.selected)
                ? colorScheme.primary
                : tokens.textMuted,
            fontWeight: FontWeight.w600,
          );
        }),
      ),
      extensions: [heroTokens, overlayTokens, statusTokens, chipTokens],
    );
  }

  /// 统一把 Pencil 里的标题 / 正文字体层级映射到 Material 文本体系。
  static TextTheme _buildTextTheme(
    ColorScheme colorScheme,
    AppThemeTokens tokens,
  ) {
    final baseTheme =
        Typography.material2021(
          platform: TargetPlatform.android,
          colorScheme: colorScheme,
        ).black.apply(
          bodyColor: tokens.textPrimary,
          displayColor: tokens.textPrimary,
          fontFamily: tokens.fontBody,
        );

    TextStyle? asHeading(TextStyle? style) {
      return style?.copyWith(
        fontFamily: tokens.fontHeading,
        fontWeight: FontWeight.w600,
        height: 1.08,
        letterSpacing: -0.4,
      );
    }

    return baseTheme.copyWith(
      displayLarge: asHeading(baseTheme.displayLarge),
      displayMedium: asHeading(baseTheme.displayMedium),
      displaySmall: asHeading(baseTheme.displaySmall),
      headlineLarge: asHeading(baseTheme.headlineLarge),
      headlineMedium: asHeading(baseTheme.headlineMedium),
      headlineSmall: asHeading(baseTheme.headlineSmall),
      titleLarge: asHeading(baseTheme.titleLarge),
      titleMedium: asHeading(
        baseTheme.titleMedium,
      )?.copyWith(fontWeight: FontWeight.w500),
      titleSmall: asHeading(
        baseTheme.titleSmall,
      )?.copyWith(fontWeight: FontWeight.w500),
      bodyLarge: baseTheme.bodyLarge?.copyWith(
        fontFamily: tokens.fontBody,
        height: 1.45,
      ),
      bodyMedium: baseTheme.bodyMedium?.copyWith(
        fontFamily: tokens.fontBody,
        height: 1.45,
      ),
      bodySmall: baseTheme.bodySmall?.copyWith(
        fontFamily: tokens.fontBody,
        height: 1.4,
      ),
      labelLarge: baseTheme.labelLarge?.copyWith(
        fontFamily: tokens.fontBody,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: baseTheme.labelMedium?.copyWith(
        fontFamily: tokens.fontBody,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: baseTheme.labelSmall?.copyWith(fontFamily: tokens.fontBody),
    );
  }
}
