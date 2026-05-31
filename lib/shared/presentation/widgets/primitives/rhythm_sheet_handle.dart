import 'package:flutter/material.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

/// 统一底部弹层的拖拽手柄，避免不同弹层出现高度和颜色漂移。
class RhythmSheetHandle extends StatelessWidget {
  /// 创建底部弹层拖拽手柄。
  const RhythmSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final overlayTokens = Theme.of(
      context,
    ).extension<RhythmOverlayThemeExtension>();
    final color =
        overlayTokens?.scrimColor.withValues(alpha: 0.18) ??
        Theme.of(context).colorScheme.outlineVariant;

    return Center(
      child: Container(
        width: 44,
        height: 4,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}
