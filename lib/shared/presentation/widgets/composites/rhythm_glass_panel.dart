import 'package:flutter/material.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

/// 统一首启链路和弹层里的柔雾面板外观，避免每页重复实现玻璃材质。
class RhythmGlassPanel extends StatelessWidget {
  /// 创建柔雾面板。
  const RhythmGlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.radius = 28,
  });

  /// 面板内容。
  final Widget child;

  /// 内边距。
  final EdgeInsetsGeometry padding;

  /// 圆角半径。
  final double radius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final overlayTokens = theme.extension<RhythmOverlayThemeExtension>();

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: overlayTokens?.sheetColor ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: (overlayTokens?.shadowColor ?? theme.colorScheme.shadow)
                .withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: child,
    );
  }
}
