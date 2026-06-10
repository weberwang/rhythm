import 'package:flutter/material.dart';
import 'package:rhythm/app/theme/rhythm_theme.dart';
import 'package:rhythm/features/app_shell/domain/app_shell_models.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 根壳层底部 tab bar。
class RootTabBar extends StatelessWidget {
  /// 创建底部 tab bar。
  const RootTabBar({
    required this.currentTab,
    required this.onSelect,
    super.key,
  });

  /// 当前选中的 tab。
  final AppShellTab currentTab;

  /// 选择 tab 时的回调。
  final ValueChanged<AppShellTab> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = [
      _TabItemData(
        icon: Icons.wb_sunny_outlined,
        label: l10n.appShellTabToday,
        tab: AppShellTab.today,
      ),
      _TabItemData(
        icon: Icons.calendar_month_outlined,
        label: l10n.appShellTabCalendar,
        tab: AppShellTab.calendar,
      ),
      _TabItemData(
        icon: Icons.nightlight_outlined,
        label: l10n.appShellTabBedtime,
        tab: AppShellTab.bedtime,
      ),
      _TabItemData(
        icon: Icons.bar_chart_outlined,
        label: l10n.appShellTabInsights,
        tab: AppShellTab.insights,
      ),
      _TabItemData(
        icon: Icons.person_outline,
        label: l10n.appShellTabProfile,
        tab: AppShellTab.profile,
      ),
    ];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: RhythmColors.surfaceElevated,
            borderRadius: BorderRadius.circular(RhythmRadius.card),
            border: Border.all(color: RhythmColors.borderSubtle),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              children: [
                for (final item in items)
                  Expanded(
                    child: _RootTabItem(
                      data: item,
                      isActive: item.tab == currentTab,
                      onTap: () => onSelect(item.tab),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 单个底部 tab 的静态描述。
class _TabItemData {
  /// 创建 tab 描述。
  const _TabItemData({
    required this.icon,
    required this.label,
    required this.tab,
  });

  /// 图标。
  final IconData icon;

  /// 文案。
  final String label;

  /// 语义 tab。
  final AppShellTab tab;
}

/// 根壳层底部 tab 项。
class _RootTabItem extends StatelessWidget {
  /// 创建底部 tab 项。
  const _RootTabItem({
    required this.data,
    required this.isActive,
    required this.onTap,
  });

  final _TabItemData data;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconColor = isActive
        ? RhythmColors.brandPrimary
        : RhythmColors.textSecondary;
    final textColor = isActive
        ? RhythmColors.brandPrimary
        : RhythmColors.textSecondary;

    return InkWell(
      borderRadius: BorderRadius.circular(RhythmRadius.control),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(data.icon, color: iconColor),
            const SizedBox(height: RhythmSpacing.xs),
            Text(
              data.label,
              style: RhythmTextStyles.tabLabel.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
