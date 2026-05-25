import 'package:flutter/material.dart';
import 'package:rhythm/features/today/domain/today_summary.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 渲染今日页顶部状态卡，只负责解释昨晚结果。
class TodayStatusSection extends StatelessWidget {
  /// 创建顶部状态卡。
  const TodayStatusSection({super.key, required this.summary});

  /// 今日页领域摘要。
  final TodaySummary summary;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);
    final resultText = summary.isUserConfirmedRecord
        ? l10n.todayStatusUserConfirmed
        : summary.isGoalMet
        ? l10n.todayStatusGoalMet
        : l10n.todayStatusLateBy(summary.sleepOffsetMinutes.abs());
    final detailText = summary.isGoalMet
        ? l10n.todayStatusWithinThreshold
        : summary.sleepOffsetMinutes < 0
        ? l10n.todayStatusEarlyBy(summary.sleepOffsetMinutes.abs())
        : l10n.todayStatusLateDetail(summary.sleepOffsetMinutes.abs());

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.todayStatusSectionTitle, style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(resultText, style: textTheme.bodyLarge),
            const SizedBox(height: 4),
            Text(detailText, style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
