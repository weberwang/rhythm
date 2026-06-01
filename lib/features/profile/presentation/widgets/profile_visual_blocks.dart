import 'package:flutter/material.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

/// 我的页玻璃卡，统一承接卡片背景、边框和标题描述层级。
class ProfileGlassCard extends StatelessWidget {
  /// 创建玻璃卡。
  const ProfileGlassCard({
    super.key,
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final panelColor = theme.colorScheme.surface.withValues(
      alpha: theme.brightness == Brightness.light ? 0.82 : 0.9,
    );
    final panelBorderColor = theme.colorScheme.outlineVariant.withValues(
      alpha: theme.brightness == Brightness.light ? 0.18 : 0.72,
    );

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: panelColor,
      shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: panelBorderColor),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.06),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

/// 我的页入口胶囊，统一使用主题语义色而不是页面内写死浅色值。
class ProfileRoutePill extends StatelessWidget {
  /// 创建入口胶囊。
  const ProfileRoutePill({
    super.key,
    required this.label,
    required this.onTap,
    this.backgroundColor,
    this.width,
  });

  final String label;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final resolvedBackgroundColor =
        backgroundColor ??
        colorScheme.surfaceContainerHighest.withValues(alpha: 0.72);
    final child = Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(19),
        onTap: onTap,
        child: Ink(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: resolvedBackgroundColor,
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Center(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );

    if (width == null) {
      return child;
    }

    return SizedBox(width: width, child: child);
  }
}

/// 我的页状态胶囊，集中处理前景色和描边衰减，避免页面自行混色。
class ProfileStatusChip extends StatelessWidget {
  /// 创建状态胶囊。
  const ProfileStatusChip({
    super.key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final borderColor = foregroundColor.withValues(alpha: 0.2);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: foregroundColor),
          const SizedBox(width: 10),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Hero 左上的图标徽记，统一复用 Hero 前景色语义。
class ProfileHeroBadge extends StatelessWidget {
  /// 创建徽记。
  const ProfileHeroBadge({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final heroTokens = theme.extension<RhythmHeroThemeExtension>();
    final heroForeground = heroTokens?.textColor ?? theme.colorScheme.onPrimary;

    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: heroForeground.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: heroForeground.withValues(alpha: 0.18)),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 18, color: heroForeground),
    );
  }
}

/// Hero 底部身份胶囊，统一承接前景色与边框透明度。
class ProfileHeroChip extends StatelessWidget {
  /// 创建 Hero 胶囊。
  const ProfileHeroChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final heroTokens = theme.extension<RhythmHeroThemeExtension>();
    final heroForeground = heroTokens?.textColor ?? theme.colorScheme.onPrimary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: heroForeground.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: heroForeground.withValues(alpha: 0.18)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: heroForeground,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
