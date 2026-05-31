import 'package:flutter/material.dart';

/// 定义 Rhythm 主题语义色，避免页面直接依赖原始十六进制颜色。
class AppThemeTokens {
  const AppThemeTokens({
    required this.brightness,
    required this.seed,
    required this.fontHeading,
    required this.fontBody,
    required this.background,
    required this.surface,
    required this.surfaceSoft,
    required this.surfaceElevated,
    required this.surfaceInverse,
    required this.primary,
    required this.primaryMuted,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textInverse,
    required this.divider,
    required this.borderSoft,
    required this.heroTop,
    required this.heroBottom,
    required this.overlayScrim,
    required this.warning,
    required this.warningSurface,
    required this.danger,
    required this.dangerSurface,
    required this.success,
    required this.successSurface,
    required this.info,
    required this.infoSurface,
    required this.moodCalmPaper,
    required this.moodRestlessPaper,
    required this.moodDrainedPaper,
    required this.moodExcitedPaper,
  });

  /// 主题明暗模式，用于统一生成 ColorScheme。
  final Brightness brightness;

  /// 品牌种子色，给 Material 组件派生基础色盘。
  final Color seed;

  /// 重点标题字体，承接 Pencil 里的衬线标题气质。
  final String fontHeading;

  /// 正文字体，负责按钮、说明文案和表单信息。
  final String fontBody;

  /// 页面主背景色。
  final Color background;

  /// 常规容器背景色。
  final Color surface;

  /// 轻雾层背景色，用于次级卡片和浮层。
  final Color surfaceSoft;

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

  /// Hero 和浮层常用的柔和描边色。
  final Color borderSoft;

  /// Hero 渐变顶部颜色。
  final Color heroTop;

  /// Hero 渐变底部颜色。
  final Color heroBottom;

  /// 通用遮罩层颜色。
  final Color overlayScrim;

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

  /// 信息语义色。
  final Color info;

  /// 信息容器底色。
  final Color infoSurface;

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
    seed: Color(0xFF4A567F),
    fontHeading: 'Newsreader',
    fontBody: 'Inter',
    background: Color(0xFFEDF1F8),
    surfaceElevated: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    surfaceSoft: Color(0xCCFFFFFF),
    surfaceInverse: Color(0xFF1E2742),
    primary: Color(0xFF3D4673),
    primaryMuted: Color(0xFFD7DDF0),
    textPrimary: Color(0xFF182033),
    textSecondary: Color(0xFF6F7891),
    textMuted: Color(0xFF8D97AE),
    textInverse: Color(0xFFFFFFFF),
    divider: Color(0xFFDCE3F0),
    borderSoft: Color(0x4DFFFFFF),
    heroTop: Color(0xFF3D4673),
    heroBottom: Color(0xFF7C88C9),
    overlayScrim: Color(0x40182033),
    warning: Color(0xFFD59A48),
    warningSurface: Color(0xFFF7E8CD),
    danger: Color(0xFFD7847B),
    dangerSurface: Color(0xFFF8E2DF),
    success: Color(0xFF5C8D83),
    successSurface: Color(0xFFE2F1EC),
    info: Color(0xFF6773BA),
    infoSurface: Color(0xFFE5E9FB),
    moodCalmPaper: Color(0xFFC5E3DB),
    moodRestlessPaper: Color(0xFFF1C98A),
    moodDrainedPaper: Color(0xFFD7DEEE),
    moodExcitedPaper: Color(0xFFF0B6A7),
  );

  /// 基于 Pencil 深色睡前页语义反推出的暗色 token，避免简单反色导致压迫感过强。
  static const AppThemeTokens dark = AppThemeTokens(
    brightness: Brightness.dark,
    seed: Color(0xFF7C88C9),
    fontHeading: 'Newsreader',
    fontBody: 'Inter',
    background: Color(0xFF12182A),
    surface: Color(0xFF1B2238),
    surfaceSoft: Color(0xE6232B45),
    surfaceElevated: Color(0xFF252E4B),
    surfaceInverse: Color(0xFFE7EBF7),
    primary: Color(0xFFC4CCF3),
    primaryMuted: Color(0xFF313A5E),
    textPrimary: Color(0xFFF2F4FF),
    textSecondary: Color(0xFFBCC4DC),
    textMuted: Color(0xFF8E98B4),
    textInverse: Color(0xFF141B30),
    divider: Color(0xFF313A58),
    borderSoft: Color(0x4DFFFFFF),
    heroTop: Color(0xFF28304F),
    heroBottom: Color(0xFF5665A1),
    overlayScrim: Color(0x80121828),
    warning: Color(0xFFF0CA7A),
    warningSurface: Color(0xFF453922),
    danger: Color(0xFFE2A198),
    dangerSurface: Color(0xFF452B31),
    success: Color(0xFFA8D3C8),
    successSurface: Color(0xFF223B3F),
    info: Color(0xFFC7D0FF),
    infoSurface: Color(0xFF293350),
    moodCalmPaper: Color(0xFF476C6C),
    moodRestlessPaper: Color(0xFF7B6332),
    moodDrainedPaper: Color(0xFF57617D),
    moodExcitedPaper: Color(0xFF7C4E54),
  );
}
