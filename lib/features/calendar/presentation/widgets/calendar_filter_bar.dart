import 'package:flutter/material.dart';
import 'package:rhythm/app/theme/app_theme_tokens.dart';
import 'package:rhythm/features/calendar/domain/calendar_filter.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 承接日历页顶部筛选栏，明确区分只读摘要区与唯一操作入口。
class CalendarFilterBar extends StatelessWidget {
  /// 创建顶部筛选栏实例。
  const CalendarFilterBar({
    super.key,
    required this.l10n,
    required this.tokens,
    required this.activeFilter,
    required this.lateCount,
    required this.onOpenFilter,
  });

  final AppLocalizations l10n;
  final AppThemeTokens tokens;
  final CalendarFilter activeFilter;
  final int lateCount;
  final VoidCallback onOpenFilter;

  @override
  Widget build(BuildContext context) {
    final conditionLabel = buildCalendarFilterConditionLabel(
      l10n,
      activeFilter,
    );
    final hasActiveFilter =
        activeFilter.onlyRecordedDays || activeFilter.lateOnly;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _CalendarSummaryChip(
                label: conditionLabel,
                backgroundColor: tokens.successSurface,
                foregroundColor: tokens.primary,
              ),
              _CalendarSummaryChip(
                label: l10n.calendarFilterLateCountSummary(lateCount),
                backgroundColor: tokens.surface,
                foregroundColor: tokens.textSecondary,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        _CalendarFilterButton(
          label: l10n.calendarFilterOpen,
          semanticsLabel: hasActiveFilter
              ? l10n.calendarFilterOpenActiveSemantics
              : l10n.calendarFilterOpenSemantics,
          isActive: hasActiveFilter,
          tokens: tokens,
          onPressed: onOpenFilter,
        ),
      ],
    );
  }
}

/// 根据当前筛选状态输出顶部条件摘要，避免多个条件并列时信息噪声过高。
String buildCalendarFilterConditionLabel(
  AppLocalizations l10n,
  CalendarFilter activeFilter,
) {
  final activeCount = [
    activeFilter.onlyRecordedDays,
    activeFilter.lateOnly,
  ].where((value) => value).length;

  if (activeCount > 1) {
    return l10n.calendarFilterSummaryAppliedCount(activeCount);
  }
  if (activeFilter.onlyRecordedDays) {
    return l10n.calendarFilterSummaryRecorded;
  }
  if (activeFilter.lateOnly) {
    return l10n.calendarFilterSummaryLateOnly;
  }
  return l10n.calendarFilterAllDays;
}

/// 只读摘要胶囊，只用于展示当前条件或统计，不承接交互。
class _CalendarSummaryChip extends StatelessWidget {
  const _CalendarSummaryChip({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      readOnly: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 顶部唯一筛选操作按钮，统一承接交互语义与激活态样式。
class _CalendarFilterButton extends StatelessWidget {
  const _CalendarFilterButton({
    required this.label,
    required this.semanticsLabel,
    required this.isActive,
    required this.tokens,
    required this.onPressed,
  });

  final String label;
  final String semanticsLabel;
  final bool isActive;
  final AppThemeTokens tokens;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticsLabel,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          side: BorderSide(color: isActive ? tokens.primary : tokens.divider),
          backgroundColor: isActive ? tokens.surfaceElevated : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.tune_rounded, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: tokens.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
