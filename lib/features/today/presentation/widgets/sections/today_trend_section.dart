import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 渲染今日页最近 7 天趋势区，保持一屏内可扫读的文字与图表密度。
class TodayTrendSection extends StatelessWidget {
  /// 创建趋势区。
  const TodayTrendSection({super.key, required this.offsets});

  /// 最近几天的入睡偏差分钟数。
  final List<int> offsets;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final visibleOffsets = offsets.take(7).toList();

    return _TodayTrendCard(
      title: l10n.todayTrendSectionTitle,
      description: visibleOffsets.isEmpty
          ? l10n.todayTrendEmptyState
          : _trendNarrative(visibleOffsets, l10n),
      child: visibleOffsets.isEmpty
          ? Text(
              l10n.todayTrendEmptyState,
              style: textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF6F7891),
              ),
            )
          : SizedBox(
              height: 84,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _trendNarrative(visibleOffsets, l10n),
                      style: textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF6F7891),
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  SizedBox(
                    width: 124,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceBetween,
                        minY: _minTrendY(visibleOffsets),
                        maxY: _maxTrendY(visibleOffsets),
                        titlesData: const FlTitlesData(
                          leftTitles: AxisTitles(),
                          bottomTitles: AxisTitles(),
                          topTitles: AxisTitles(),
                          rightTitles: AxisTitles(),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: const FlGridData(show: false),
                        barTouchData: BarTouchData(enabled: false),
                        barGroups: [
                          for (var index = 0; index < visibleOffsets.length; index++)
                            BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: visibleOffsets[index].toDouble(),
                                  width: 10,
                                  borderRadius: BorderRadius.circular(6),
                                  color: visibleOffsets[index] <= 0
                                      ? const Color(0xFF8EBA8F)
                                      : const Color(0xFFBFC8E9),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

/// 趋势区复用统一玻璃卡材质，避免拆文件后丢失视觉层级。
class _TodayTrendCard extends StatelessWidget {
  /// 创建趋势卡。
  const _TodayTrendCard({
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
                  child: const Icon(
                    Icons.bar_chart_rounded,
                    size: 18,
                    color: Color(0xFF4F5E9A),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
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
              style: theme.textTheme.bodyMedium?.copyWith(
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

/// 趋势摘要只保留一个结论句，防止图表区被解释文本淹没。
String _trendNarrative(List<int> offsets, AppLocalizations l10n) {
  final average = offsets.reduce((left, right) => left + right) / offsets.length;
  if (average <= 0) {
    return l10n.todayStatusWithinThreshold;
  }
  if (average <= 20) {
    return l10n.todayRecoveryDescription;
  }
  return l10n.todayCardDescription;
}

/// 图表最小值加入缓冲，避免柱体贴边后失去可读性。
double _minTrendY(List<int> offsets) {
  final minimum = offsets.reduce(math.min).toDouble();
  return math.min(minimum - 8, -8);
}

/// 图表最大值加入缓冲，保证极值不会顶到容器顶部。
double _maxTrendY(List<int> offsets) {
  final maximum = offsets.reduce(math.max).toDouble();
  return math.max(maximum + 8, 8);
}
