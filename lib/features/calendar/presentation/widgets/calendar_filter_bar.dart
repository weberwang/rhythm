import 'package:flutter/material.dart';
import 'package:rhythm/app/theme/app_theme_tokens.dart';
import 'package:rhythm/features/calendar/domain/calendar_filter.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

/// 承接日历页顶部筛选栏，明确区分只读摘要区与唯一操作入口。
class CalendarFilterBar extends StatelessWidget {
  /// 创建顶部筛选栏实例。
  const CalendarFilterBar({
    super.key,
    required this.l10n,
    required this.tokens,
    required this.activeFilter,
    required this.onOpenFilter,
  });

  final AppLocalizations l10n;
  final AppThemeTokens tokens;
  final CalendarFilter activeFilter;
  final VoidCallback onOpenFilter;

  @override
  Widget build(BuildContext context) {
    final selectedMode = resolveCalendarFilterMode(activeFilter);
    final pills = [
      _CalendarModePill(
        mode: CalendarFilterMode.sleepTime,
        label: l10n.calendarFilterAllDays,
        selected: selectedMode == CalendarFilterMode.sleepTime,
        tokens: tokens,
        onTap: onOpenFilter,
      ),
      _CalendarModePill(
        mode: CalendarFilterMode.stability,
        label: l10n.calendarFilterSummaryRecorded,
        selected: selectedMode == CalendarFilterMode.stability,
        tokens: tokens,
        onTap: onOpenFilter,
      ),
      _CalendarModePill(
        mode: CalendarFilterMode.lateCount,
        label: l10n.calendarFilterDataSource,
        selected: selectedMode == CalendarFilterMode.lateCount,
        tokens: tokens,
        onTap: onOpenFilter,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 300) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var index = 0; index < pills.length; index++) ...[
                pills[index],
                if (index != pills.length - 1) const SizedBox(height: 10),
              ],
            ],
          );
        }

        return Row(
          children: [
            for (var index = 0; index < pills.length; index++) ...[
              Expanded(child: pills[index]),
              if (index != pills.length - 1) const SizedBox(width: 10),
            ],
          ],
        );
      },
    );
  }
}

/// 日历页顶部视觉模式，只用于映射设计稿里的三段 pill。
enum CalendarFilterMode { sleepTime, stability, lateCount }

/// 依据现有筛选条件推导当前设计态 pill，高保真优先于原先摘要文案。
CalendarFilterMode resolveCalendarFilterMode(CalendarFilter activeFilter) {
  if (activeFilter.lateOnly) {
    return CalendarFilterMode.lateCount;
  }
  if (activeFilter.onlyRecordedDays) {
    return CalendarFilterMode.stability;
  }
  return CalendarFilterMode.sleepTime;
}

/// 设计稿里的模式 pill，所有点击统一回到现有筛选入口。
class _CalendarModePill extends StatelessWidget {
  const _CalendarModePill({
    required this.mode,
    required this.label,
    required this.selected,
    required this.tokens,
    required this.onTap,
  });

  final CalendarFilterMode mode;
  final String label;
  final bool selected;
  final AppThemeTokens tokens;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final chipTokens = Theme.of(context).extension<RhythmChipThemeExtension>();
    final content = SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: selected
                ? chipTokens?.selectedForegroundColor ?? tokens.primary
                : chipTokens?.foregroundColor ?? tokens.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Ink(
          key: Key('calendar-filter-pill-${mode.name}'),
          decoration: BoxDecoration(
            color: selected
                ? chipTokens?.selectedBackgroundColor ?? tokens.primaryMuted
                : chipTokens?.backgroundColor ??
                      Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: selected
                  ? chipTokens?.selectedBorderColor ?? tokens.divider
                  : chipTokens?.borderColor ?? tokens.divider,
            ),
          ),
          child: content,
        ),
      ),
    );
  }
}
