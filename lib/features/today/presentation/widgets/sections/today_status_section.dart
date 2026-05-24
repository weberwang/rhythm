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
        ? '用户确认结果'
        : summary.isGoalMet
            ? '昨晚基本达标'
            : '昨晚比目标晚了 ${summary.sleepOffsetMinutes.abs()} 分钟';
    final detailText = summary.isGoalMet
        ? '已控制在阈值内'
        : summary.sleepOffsetMinutes < 0
            ? '比目标提前 ${summary.sleepOffsetMinutes.abs()} 分钟'
            : '比目标晚了 ${summary.sleepOffsetMinutes.abs()} 分钟';

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
