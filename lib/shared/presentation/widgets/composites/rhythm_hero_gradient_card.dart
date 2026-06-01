import 'package:flutter/material.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';
import 'package:rhythm/shared/presentation/widgets/primitives/rhythm_pill.dart';

/// 统一首启链路的 Hero 渐变卡，承接夜色标题区和顶部价值说明。
class RhythmHeroGradientCard extends StatelessWidget {
  /// 创建 Hero 渐变卡。
  const RhythmHeroGradientCard({
    super.key,
    required this.title,
    required this.description,
    this.eyebrow,
    this.badgeIcon = Icons.nightlight_round,
    this.footer,
  });

  /// 标题文案。
  final String title;

  /// 说明文案。
  final String description;

  /// 可选眉标文案。
  final String? eyebrow;

  /// 顶部徽记图标。
  final IconData badgeIcon;

  /// 可选底部补充内容。
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final heroTokens = theme.extension<RhythmHeroThemeExtension>();
    final overlayTokens = theme.extension<RhythmOverlayThemeExtension>();
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: heroTokens?.gradient,
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color:
              heroTokens?.borderColor ??
              theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: (overlayTokens?.shadowColor ?? theme.colorScheme.shadow)
                .withValues(alpha: 0.12),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.18),
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  badgeIcon,
                  size: 18,
                  color: heroTokens?.textColor ?? theme.colorScheme.onPrimary,
                ),
              ),
              if (eyebrow != null) ...[
                const SizedBox(width: 12),
                Expanded(child: RhythmPill(text: eyebrow!, icon: null)),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: textTheme.headlineMedium?.copyWith(
              color: heroTokens?.textColor ?? theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
              height: 1.08,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: (heroTokens?.textColor ?? theme.colorScheme.onPrimary)
                  .withValues(alpha: 0.9),
              height: 1.45,
            ),
          ),
          if (footer != null) ...[const SizedBox(height: 18), footer!],
        ],
      ),
    );
  }
}
