import 'package:flutter/material.dart';
import 'package:rhythm/features/today/domain/today_summary.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 渲染今日页顶部状态摘要，负责解释昨晚结果并生成辅助状态标签。
class TodayStatusSection extends StatelessWidget {
  /// 创建顶部状态摘要。
  const TodayStatusSection({super.key, required this.summary});

  /// 今日页领域摘要。
  final TodaySummary summary;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);
    final resultText = summary.isGoalMet
        ? l10n.todayStatusGoalMet
        : summary.sleepOffsetMinutes < 0
        ? l10n.todayStatusEarlyBy(summary.sleepOffsetMinutes.abs())
        : l10n.todayStatusLateBy(summary.sleepOffsetMinutes.abs());
    final detailText = summary.isGoalMet
        ? l10n.todayStatusWithinThreshold
        : summary.sleepOffsetMinutes < 0
        ? l10n.todayStatusEarlyBy(summary.sleepOffsetMinutes.abs())
        : l10n.todayStatusLateDetail(summary.sleepOffsetMinutes.abs());
    final badges = <_TodayStatusBadgeData>[
      if (summary.isUserConfirmedRecord)
        _TodayStatusBadgeData(
          label: l10n.todayStatusUserConfirmed,
          backgroundColor: colorScheme.surfaceContainerHighest,
          foregroundColor: colorScheme.onSurfaceVariant,
        ),
      if (detailText != resultText)
        _TodayStatusBadgeData(
          label: detailText,
          backgroundColor: summary.isGoalMet
              ? colorScheme.secondaryContainer
              : colorScheme.tertiaryContainer,
          foregroundColor: summary.isGoalMet
              ? colorScheme.onSecondaryContainer
              : colorScheme.onTertiaryContainer,
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.todayStatusSectionTitle,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 14),
        Text(
          resultText,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        if (badges.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final badge in badges)
                _TodayStatusBadge(
                  label: badge.label,
                  backgroundColor: badge.backgroundColor,
                  foregroundColor: badge.foregroundColor,
                ),
            ],
          ),
        ],
      ],
    );
  }
}

/// 描述状态标签的文案与语义色，避免展示层散落条件分支。
class _TodayStatusBadgeData {
  /// 创建状态标签描述。
  const _TodayStatusBadgeData({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
}

/// 渲染顶部状态区的轻量标签，用于承接来源和阈值信息。
class _TodayStatusBadge extends StatelessWidget {
  /// 创建状态标签。
  const _TodayStatusBadge({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
