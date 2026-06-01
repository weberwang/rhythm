import 'package:flutter/material.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 渲染今日页快捷记录卡，提供补录、修改和管理入口。
class TodayQuickActionsSection extends StatelessWidget {
  /// 创建快捷记录卡。
  const TodayQuickActionsSection({
    super.key,
    required this.onManualRecord,
    required this.onEditRecord,
    required this.onOpenRecordsHub,
  });

  /// 进入手动补录。
  final VoidCallback onManualRecord;

  /// 修改昨晚记录。
  final VoidCallback onEditRecord;

  /// 打开睡眠记录管理。
  final VoidCallback onOpenRecordsHub;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return _TodaySectionCard(
      icon: Icons.edit_calendar_outlined,
      title: l10n.todayQuickActionsTitle,
      description: l10n.todayOpenSleepRecordsButton,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 340;
          final pills = [
            Expanded(
              child: _TodayQuickPill(
                icon: Icons.add_circle_outline,
                label: l10n.todayQuickActionManualButton,
                onTap: onManualRecord,
              ),
            ),
            Expanded(
              child: _TodayQuickPill(
                icon: Icons.edit_outlined,
                label: l10n.todayQuickActionEditButton,
                onTap: onEditRecord,
              ),
            ),
            Expanded(
              child: _TodayQuickPill(
                icon: Icons.folder_open_outlined,
                label: l10n.todayQuickActionOpenHubButton,
                onTap: onOpenRecordsHub,
              ),
            ),
          ];

          if (compact) {
            return Column(
              children: [
                Row(
                  children: [pills[0], const SizedBox(width: 10), pills[1]],
                ),
                const SizedBox(height: 10),
                Row(children: [pills[2]]),
              ],
            );
          }

          return Row(
            children: [
              pills[0],
              const SizedBox(width: 10),
              pills[1],
              const SizedBox(width: 10),
              pills[2],
            ],
          );
        },
      ),
    );
  }
}

/// 今日页区块统一卡片，保证拆分后仍保持相同材质和留白。
class _TodaySectionCard extends StatelessWidget {
  /// 创建区块卡片。
  const _TodaySectionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.child,
  });

  final IconData icon;
  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white.withValues(alpha: 0.82),
      shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withValues(alpha: 0.86)),
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
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF3FF),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    size: 18,
                    color: const Color(0xFF4F5E9A),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF182033),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF6F7891),
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

/// 快捷入口胶囊允许按内容增高，避免多语言文案在窄宽度下挤爆高度。
class _TodayQuickPill extends StatelessWidget {
  /// 创建快捷胶囊。
  const _TodayQuickPill({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 72),
          child: Ink(
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFF),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE7ECF6)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 18, color: const Color(0xFF4F5E9A)),
                  const SizedBox(height: 6),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelMedium?.copyWith(
                      color: const Color(0xFF182033),
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
