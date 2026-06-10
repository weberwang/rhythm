import 'package:flutter/material.dart';

/// Rhythm 共享颜色角色。
abstract final class RhythmColors {
  /// 页面主背景。
  static const Color backgroundPrimary = Color(0xFFF7F4EC);

  /// 卡片主表面。
  static const Color surfaceCard = Color(0xFFFFFDF8);

  /// 轻抬升表面。
  static const Color surfaceElevated = Color(0xFFFFFFFF);

  /// 主文本颜色。
  static const Color textPrimary = Color(0xFF17352B);

  /// 次级文本颜色。
  static const Color textSecondary = Color(0xFF6C746D);

  /// 三级文本颜色。
  static const Color textTertiary = Color(0xFF97A098);

  /// 品牌主色。
  static const Color brandPrimary = Color(0xFF234D3D);

  /// 警示强调色。
  static const Color brandAccent = Color(0xFFC89B4A);

  /// 成功色。
  static const Color success = Color(0xFF5D8B60);

  /// 错误色。
  static const Color error = Color(0xFFEE8E6D);

  /// 浅边框颜色。
  static const Color borderSubtle = Color(0xFFE7E1D6);

  /// 聚焦环颜色。
  static const Color focusRing = Color(0xFF8BAF95);

  /// 深色模式背景。
  static const Color darkBackgroundPrimary = Color(0xFF151915);

  /// 深色模式表面。
  static const Color darkSurfaceCard = Color(0xFF1D231E);

  /// 深色模式主文本。
  static const Color darkTextPrimary = Color(0xFFF3F0E8);

  /// 深色模式次级文本。
  static const Color darkTextSecondary = Color(0xFFC6CDC6);
}

/// Rhythm 共享圆角。
abstract final class RhythmRadius {
  /// 卡片圆角。
  static const double card = 24;

  /// 控件圆角。
  static const double control = 16;

  /// 胶囊圆角。
  static const double pill = 9999;
}

/// Rhythm 共享间距。
abstract final class RhythmSpacing {
  /// 4pt。
  static const double xs = 4;

  /// 8pt。
  static const double s = 8;

  /// 16pt。
  static const double m = 16;

  /// 24pt。
  static const double l = 24;

  /// 40pt。
  static const double xl = 40;
}

/// Rhythm 共享文字样式。
abstract final class RhythmTextStyles {
  /// 页面大标题。
  static const TextStyle pageTitle = TextStyle(
    fontSize: 48,
    height: 1.08,
    fontWeight: FontWeight.w600,
    color: RhythmColors.textPrimary,
  );

  /// 页面元信息。
  static const TextStyle pageMeta = TextStyle(
    fontSize: 16,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: RhythmColors.textSecondary,
  );

  /// 卡片标题。
  static const TextStyle cardTitle = TextStyle(
    fontSize: 18,
    height: 1.35,
    fontWeight: FontWeight.w600,
    color: RhythmColors.textPrimary,
  );

  /// 正文。
  static const TextStyle body = TextStyle(
    fontSize: 16,
    height: 1.45,
    fontWeight: FontWeight.w400,
    color: RhythmColors.textSecondary,
  );

  /// 底部导航文案。
  static const TextStyle tabLabel = TextStyle(
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w500,
    color: RhythmColors.textSecondary,
  );
}

/// 构建浅色主题。
ThemeData buildRhythmLightTheme() {
  final scheme = ColorScheme(
    brightness: Brightness.light,
    primary: RhythmColors.brandPrimary,
    onPrimary: const Color(0xFFF9F7F0),
    secondary: const Color(0xFF74836E),
    onSecondary: Colors.white,
    error: RhythmColors.error,
    onError: Colors.white,
    surface: RhythmColors.surfaceCard,
    onSurface: RhythmColors.textPrimary,
    tertiary: RhythmColors.brandAccent,
    onTertiary: Colors.white,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: RhythmColors.backgroundPrimary,
    cardColor: RhythmColors.surfaceCard,
    textTheme: const TextTheme(
      displayLarge: RhythmTextStyles.pageTitle,
      titleLarge: RhythmTextStyles.cardTitle,
      bodyLarge: RhythmTextStyles.body,
      bodyMedium: RhythmTextStyles.body,
      labelMedium: RhythmTextStyles.tabLabel,
    ),
    cardTheme: CardThemeData(
      color: RhythmColors.surfaceCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RhythmRadius.card),
        side: const BorderSide(color: RhythmColors.borderSubtle),
      ),
      margin: EdgeInsets.zero,
    ),
  );
}

/// 构建深色主题。
ThemeData buildRhythmDarkTheme() {
  final scheme = ColorScheme(
    brightness: Brightness.dark,
    primary: const Color(0xFF8FB39A),
    onPrimary: const Color(0xFF13261E),
    secondary: const Color(0xFFA1AF9D),
    onSecondary: const Color(0xFF18201B),
    error: const Color(0xFFF0A187),
    onError: const Color(0xFF2F150E),
    surface: RhythmColors.darkSurfaceCard,
    onSurface: RhythmColors.darkTextPrimary,
    tertiary: const Color(0xFFD5B06A),
    onTertiary: const Color(0xFF231706),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: RhythmColors.darkBackgroundPrimary,
    cardColor: RhythmColors.darkSurfaceCard,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        height: 1.08,
        fontWeight: FontWeight.w600,
        color: RhythmColors.darkTextPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        height: 1.35,
        fontWeight: FontWeight.w600,
        color: RhythmColors.darkTextPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.45,
        fontWeight: FontWeight.w400,
        color: RhythmColors.darkTextSecondary,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        height: 1.45,
        fontWeight: FontWeight.w400,
        color: RhythmColors.darkTextSecondary,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        height: 1.33,
        fontWeight: FontWeight.w500,
        color: RhythmColors.darkTextSecondary,
      ),
    ),
    cardTheme: CardThemeData(
      color: RhythmColors.darkSurfaceCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RhythmRadius.card),
        side: const BorderSide(color: Color(0xFF323A34)),
      ),
      margin: EdgeInsets.zero,
    ),
  );
}
