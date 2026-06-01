import 'package:flutter/material.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

/// 统一浅色胶囊标签，承接首启页、设置页和提示位的轻强调语义。
class RhythmPill extends StatelessWidget {
  /// 创建胶囊标签。
  const RhythmPill({super.key, required this.text, this.icon});

  /// 胶囊文案。
  final String text;

  /// 可选前置图标。
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chipTokens = theme.extension<RhythmChipThemeExtension>();
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color:
            chipTokens?.selectedBackgroundColor ??
            theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color:
              chipTokens?.selectedBorderColor ??
              theme.colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 14,
              color:
                  chipTokens?.selectedForegroundColor ??
                  theme.colorScheme.primary,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: textTheme.labelLarge?.copyWith(
              color:
                  chipTokens?.selectedForegroundColor ??
                  theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
