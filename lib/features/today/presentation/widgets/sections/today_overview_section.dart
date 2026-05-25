import 'package:flutter/material.dart';
import 'package:rhythm/features/today/domain/today_summary.dart';

import 'today_action_section.dart';
import 'today_status_section.dart';

/// 渲染今日页顶部总览主卡，合并昨晚结果与今晚行动，保证首屏只有一个视觉重心。
class TodayOverviewSection extends StatelessWidget {
  /// 创建顶部总览主卡。
  const TodayOverviewSection({
    super.key,
    required this.summary,
    required this.onPressed,
  });

  /// 今日页领域摘要。
  final TodaySummary summary;

  /// 顶部主行动点击回调。
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TodayStatusSection(summary: summary),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Divider(
                height: 1,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            TodayActionSection(
              primaryAction: summary.primaryAction,
              targetBedtimeMinutes: summary.targetBedtimeMinutes,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
