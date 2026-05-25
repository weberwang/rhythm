import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 渲染今日页最近 7 天趋势区的最小占位结构。
class TodayTrendSection extends StatelessWidget {
  /// 创建趋势区。
  const TodayTrendSection({super.key, required this.offsets});

  /// 最近几天的入睡偏差分钟数。
  final List<int> offsets;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.todayTrendSectionTitle),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: offsets.isEmpty
                  ? Center(child: Text(l10n.todayTrendEmptyState))
                  : BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        titlesData: const FlTitlesData(
                          leftTitles: AxisTitles(),
                          bottomTitles: AxisTitles(),
                          topTitles: AxisTitles(),
                          rightTitles: AxisTitles(),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: const FlGridData(show: false),
                        barGroups: [
                          for (var index = 0; index < offsets.length; index++)
                            BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: offsets[index].toDouble(),
                                  color: offsets[index] <= 0
                                      ? const Color(0xFF2D5E3A)
                                      : const Color(0xFFC87A36),
                                  width: 14,
                                  borderRadius: BorderRadius.circular(6),
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
