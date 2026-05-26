import 'package:flutter/material.dart';

/// 定义 Rhythm 主题语义色，避免页面直接依赖原始十六进制颜色。
class AppThemeTokens {
  const AppThemeTokens({
    required this.brightness,
    required this.seed,
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.surfaceInverse,
    required this.primary,
    required this.primaryMuted,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textInverse,
    required this.divider,
    required this.warning,
    required this.warningSurface,
    required this.danger,
    required this.dangerSurface,
    required this.success,
    required this.successSurface,
    required this.moodCalmPaper,
    required this.moodRestlessPaper,
    required this.moodDrainedPaper,
    required this.moodExcitedPaper,
  });

  /// 主题明暗模式，用于统一生成 ColorScheme。
  final Brightness brightness;

  /// 品牌种子色，给 Material 组件派生基础色盘。
  final Color seed;

  /// 页面主背景色。
  final Color background;

  /// 常规容器背景色。
  final Color surface;

  /// 浮起层级卡片背景色。
  final Color surfaceElevated;

  /// 反色高对比容器背景色。
  final Color surfaceInverse;

  /// 主操作品牌色。
  final Color primary;

  /// 弱化品牌色，用于低强调状态。
  final Color primaryMuted;

  /// 主文字颜色。
  final Color textPrimary;

  /// 次级文字颜色。
  final Color textSecondary;

  /// 弱提示文字颜色。
  final Color textMuted;

  /// 反色容器上的文字颜色。
  final Color textInverse;

  /// 分割线和描边颜色。
  final Color divider;

  /// 提醒语义色。
  final Color warning;

  /// 提醒容器底色。
  final Color warningSurface;

  /// 风险语义色。
  final Color danger;

  /// 风险容器底色。
  final Color dangerSurface;

  /// 成功语义色。
  final Color success;

  /// 成功容器底色。
  final Color successSurface;

  /// 平静情绪纸片雾层色。
  final Color moodCalmPaper;

  /// 烦躁情绪纸片雾层色。
  final Color moodRestlessPaper;

  /// 空耗情绪纸片雾层色。
  final Color moodDrainedPaper;

  /// 兴奋情绪纸片雾层色。
  final Color moodExcitedPaper;

  /// 基于 Pencil 亮色稿整理出的主题语义 token。
  static const AppThemeTokens light = AppThemeTokens(
    brightness: Brightness.light,
    seed: Color(0xFF2D5E3A),
    background: Color(0xFFF5F3EE),
    surface: Color(0xFFF9FBF6),
    surfaceElevated: Color(0xFFFFFFFF),
    surfaceInverse: Color(0xFF1B3A28),
    primary: Color(0xFF2D5E3A),
    primaryMuted: Color(0xFF5F8768),
    textPrimary: Color(0xFF1B3A28),
    textSecondary: Color(0xFF4A6B52),
    textMuted: Color(0xFF7A9A80),
    textInverse: Color(0xFFFFFFFF),
    divider: Color(0xFFD5DFCE),
    warning: Color(0xFFC8913C),
    warningSurface: Color(0xFFF4E8CF),
    danger: Color(0xFFC97D68),
    dangerSurface: Color(0xFFF4DED7),
    success: Color(0xFF4F7B5A),
    successSurface: Color(0xFFD7E7DA),
    moodCalmPaper: Color(0xFFC9E5C8),
    moodRestlessPaper: Color(0xFFF0D18F),
    moodDrainedPaper: Color(0xFFD7CBBE),
    moodExcitedPaper: Color(0xFFF2B8A6),
  );

  /// 基于 Pencil 深色睡前页语义反推出的暗色 token，避免简单反色导致压迫感过强。
  static const AppThemeTokens dark = AppThemeTokens(
    brightness: Brightness.dark,
    seed: Color(0xFF5F8768),
    background: Color(0xFF102419),
    surface: Color(0xFF173324),
    surfaceElevated: Color(0xFF1E3D2B),
    surfaceInverse: Color(0xFFE8F0E1),
    primary: Color(0xFF7FA286),
    primaryMuted: Color(0xFF5F8768),
    textPrimary: Color(0xFFEAF2E4),
    textSecondary: Color(0xFFD7E7DA),
    textMuted: Color(0xFF9DB3A2),
    textInverse: Color(0xFF102419),
    divider: Color(0xFF295140),
    warning: Color(0xFFD9B066),
    warningSurface: Color(0xFF3B3422),
    danger: Color(0xFFD79A89),
    dangerSurface: Color(0xFF3D2A28),
    success: Color(0xFF8AB295),
    successSurface: Color(0xFF223A2D),
    moodCalmPaper: Color(0xFF5E8A61),
    moodRestlessPaper: Color(0xFF8F6A28),
    moodDrainedPaper: Color(0xFF7B6C61),
    moodExcitedPaper: Color(0xFF956255),
  );
}
