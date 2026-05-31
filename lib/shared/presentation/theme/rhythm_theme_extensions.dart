import 'package:flutter/material.dart';

/// 承接 Hero 渐变区的语义颜色，避免页面自行拼装品牌渐变。
@immutable
class RhythmHeroThemeExtension
    extends ThemeExtension<RhythmHeroThemeExtension> {
  /// 创建 Hero 语义扩展。
  const RhythmHeroThemeExtension({
    required this.topColor,
    required this.bottomColor,
    required this.textColor,
    required this.borderColor,
  });

  /// Hero 顶部渐变色。
  final Color topColor;

  /// Hero 底部渐变色。
  final Color bottomColor;

  /// Hero 区域上的高对比文字色。
  final Color textColor;

  /// Hero 区域常用的柔和描边色。
  final Color borderColor;

  /// 对外暴露统一的 Hero 渐变定义，保证页面复用时方向一致。
  LinearGradient get gradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [topColor, bottomColor],
  );

  @override
  RhythmHeroThemeExtension copyWith({
    Color? topColor,
    Color? bottomColor,
    Color? textColor,
    Color? borderColor,
  }) {
    return RhythmHeroThemeExtension(
      topColor: topColor ?? this.topColor,
      bottomColor: bottomColor ?? this.bottomColor,
      textColor: textColor ?? this.textColor,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  @override
  RhythmHeroThemeExtension lerp(
    covariant ThemeExtension<RhythmHeroThemeExtension>? other,
    double t,
  ) {
    if (other is! RhythmHeroThemeExtension) {
      return this;
    }
    return RhythmHeroThemeExtension(
      topColor: Color.lerp(topColor, other.topColor, t) ?? topColor,
      bottomColor: Color.lerp(bottomColor, other.bottomColor, t) ?? bottomColor,
      textColor: Color.lerp(textColor, other.textColor, t) ?? textColor,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
    );
  }
}

/// 承接弹层、对话框和轻提示的表层语义，避免每个叠层重新定义阴影与底色。
@immutable
class RhythmOverlayThemeExtension
    extends ThemeExtension<RhythmOverlayThemeExtension> {
  /// 创建叠层语义扩展。
  const RhythmOverlayThemeExtension({
    required this.sheetColor,
    required this.dialogColor,
    required this.bannerColor,
    required this.scrimColor,
    required this.shadowColor,
  });

  /// 底部弹层默认底色。
  final Color sheetColor;

  /// 对话框默认底色。
  final Color dialogColor;

  /// 轻提示横幅默认底色。
  final Color bannerColor;

  /// 遮罩层颜色。
  final Color scrimColor;

  /// 低压阴影颜色。
  final Color shadowColor;

  @override
  RhythmOverlayThemeExtension copyWith({
    Color? sheetColor,
    Color? dialogColor,
    Color? bannerColor,
    Color? scrimColor,
    Color? shadowColor,
  }) {
    return RhythmOverlayThemeExtension(
      sheetColor: sheetColor ?? this.sheetColor,
      dialogColor: dialogColor ?? this.dialogColor,
      bannerColor: bannerColor ?? this.bannerColor,
      scrimColor: scrimColor ?? this.scrimColor,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }

  @override
  RhythmOverlayThemeExtension lerp(
    covariant ThemeExtension<RhythmOverlayThemeExtension>? other,
    double t,
  ) {
    if (other is! RhythmOverlayThemeExtension) {
      return this;
    }
    return RhythmOverlayThemeExtension(
      sheetColor: Color.lerp(sheetColor, other.sheetColor, t) ?? sheetColor,
      dialogColor: Color.lerp(dialogColor, other.dialogColor, t) ?? dialogColor,
      bannerColor: Color.lerp(bannerColor, other.bannerColor, t) ?? bannerColor,
      scrimColor: Color.lerp(scrimColor, other.scrimColor, t) ?? scrimColor,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t) ?? shadowColor,
    );
  }
}

/// 集中管理成功、提醒、风险和信息态配色，避免轻提示和状态卡各自发散。
@immutable
class RhythmStatusThemeExtension
    extends ThemeExtension<RhythmStatusThemeExtension> {
  /// 创建状态语义扩展。
  const RhythmStatusThemeExtension({
    required this.success,
    required this.successSurface,
    required this.warning,
    required this.warningSurface,
    required this.danger,
    required this.dangerSurface,
    required this.info,
    required this.infoSurface,
  });

  /// 成功态主色。
  final Color success;

  /// 成功态容器底色。
  final Color successSurface;

  /// 提醒态主色。
  final Color warning;

  /// 提醒态容器底色。
  final Color warningSurface;

  /// 风险态主色。
  final Color danger;

  /// 风险态容器底色。
  final Color dangerSurface;

  /// 信息态主色。
  final Color info;

  /// 信息态容器底色。
  final Color infoSurface;

  @override
  RhythmStatusThemeExtension copyWith({
    Color? success,
    Color? successSurface,
    Color? warning,
    Color? warningSurface,
    Color? danger,
    Color? dangerSurface,
    Color? info,
    Color? infoSurface,
  }) {
    return RhythmStatusThemeExtension(
      success: success ?? this.success,
      successSurface: successSurface ?? this.successSurface,
      warning: warning ?? this.warning,
      warningSurface: warningSurface ?? this.warningSurface,
      danger: danger ?? this.danger,
      dangerSurface: dangerSurface ?? this.dangerSurface,
      info: info ?? this.info,
      infoSurface: infoSurface ?? this.infoSurface,
    );
  }

  @override
  RhythmStatusThemeExtension lerp(
    covariant ThemeExtension<RhythmStatusThemeExtension>? other,
    double t,
  ) {
    if (other is! RhythmStatusThemeExtension) {
      return this;
    }
    return RhythmStatusThemeExtension(
      success: Color.lerp(success, other.success, t) ?? success,
      successSurface:
          Color.lerp(successSurface, other.successSurface, t) ?? successSurface,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      warningSurface:
          Color.lerp(warningSurface, other.warningSurface, t) ?? warningSurface,
      danger: Color.lerp(danger, other.danger, t) ?? danger,
      dangerSurface:
          Color.lerp(dangerSurface, other.dangerSurface, t) ?? dangerSurface,
      info: Color.lerp(info, other.info, t) ?? info,
      infoSurface: Color.lerp(infoSurface, other.infoSurface, t) ?? infoSurface,
    );
  }
}

/// 管理胶囊、筛选标签等低层级可选态配色，避免不同页面各自定义选中逻辑。
@immutable
class RhythmChipThemeExtension
    extends ThemeExtension<RhythmChipThemeExtension> {
  /// 创建胶囊语义扩展。
  const RhythmChipThemeExtension({
    required this.backgroundColor,
    required this.selectedBackgroundColor,
    required this.borderColor,
    required this.selectedBorderColor,
    required this.foregroundColor,
    required this.selectedForegroundColor,
  });

  /// 默认背景色。
  final Color backgroundColor;

  /// 选中态背景色。
  final Color selectedBackgroundColor;

  /// 默认描边色。
  final Color borderColor;

  /// 选中态描边色。
  final Color selectedBorderColor;

  /// 默认文字色。
  final Color foregroundColor;

  /// 选中态文字色。
  final Color selectedForegroundColor;

  @override
  RhythmChipThemeExtension copyWith({
    Color? backgroundColor,
    Color? selectedBackgroundColor,
    Color? borderColor,
    Color? selectedBorderColor,
    Color? foregroundColor,
    Color? selectedForegroundColor,
  }) {
    return RhythmChipThemeExtension(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedBackgroundColor:
          selectedBackgroundColor ?? this.selectedBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      selectedForegroundColor:
          selectedForegroundColor ?? this.selectedForegroundColor,
    );
  }

  @override
  RhythmChipThemeExtension lerp(
    covariant ThemeExtension<RhythmChipThemeExtension>? other,
    double t,
  ) {
    if (other is! RhythmChipThemeExtension) {
      return this;
    }
    return RhythmChipThemeExtension(
      backgroundColor:
          Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      selectedBackgroundColor:
          Color.lerp(
            selectedBackgroundColor,
            other.selectedBackgroundColor,
            t,
          ) ??
          selectedBackgroundColor,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      selectedBorderColor:
          Color.lerp(selectedBorderColor, other.selectedBorderColor, t) ??
          selectedBorderColor,
      foregroundColor:
          Color.lerp(foregroundColor, other.foregroundColor, t) ??
          foregroundColor,
      selectedForegroundColor:
          Color.lerp(
            selectedForegroundColor,
            other.selectedForegroundColor,
            t,
          ) ??
          selectedForegroundColor,
    );
  }
}
