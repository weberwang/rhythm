import 'package:flutter/material.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

/// 统一浅色面板卡片外观，承接大圆角、柔和描边和低压阴影语义。
class RhythmSurfaceCard extends StatelessWidget {
  /// 创建表层卡片。
  const RhythmSurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.margin,
    this.radius = 24,
    this.backgroundColor,
    this.borderColor,
    this.gradient,
    this.alignment,
    this.onTap,
  });

  /// 卡片主体。
  final Widget child;

  /// 内边距。
  final EdgeInsetsGeometry padding;

  /// 外边距。
  final EdgeInsetsGeometry? margin;

  /// 圆角半径。
  final double radius;

  /// 覆盖默认容器底色。
  final Color? backgroundColor;

  /// 覆盖默认描边色。
  final Color? borderColor;

  /// 需要渐变背景时直接传入，避免页面自行复制渐变定义。
  final Gradient? gradient;

  /// 内容对齐方式。
  final AlignmentGeometry? alignment;

  /// 可点击时统一接入墨水反馈。
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final overlayTokens = theme.extension<RhythmOverlayThemeExtension>();
    final decoration = BoxDecoration(
      color: gradient == null
          ? backgroundColor ?? theme.colorScheme.surface
          : null,
      gradient: gradient,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: borderColor ?? theme.colorScheme.outlineVariant,
      ),
      boxShadow: [
        BoxShadow(
          color:
              overlayTokens?.shadowColor.withValues(alpha: 0.1) ??
              theme.colorScheme.shadow.withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
      ],
    );

    final content = Container(
      margin: margin,
      decoration: decoration,
      child: Padding(
        padding: padding,
        child: Align(
          alignment: alignment ?? Alignment.centerLeft,
          child: child,
        ),
      ),
    );
    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: content,
      ),
    );
  }
}
