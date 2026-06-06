import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/today_snapshot.dart';
import 'today_dashboard_style.dart';

/// today 趋势图只负责解释趋势方向，不抢首屏主判断。
class TodayTrendChart extends StatelessWidget {
  /// 创建趋势图。
  const TodayTrendChart({required this.summary, super.key});

  /// 趋势摘要。
  final TodayTrendSummary summary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84,
      child: LineChart(_buildData(context), duration: Duration.zero),
    );
  }

  /// 使用 `fl_chart` 统一管理折线、节点与顶部标签，减少手写坐标误差。
  LineChartData _buildData(BuildContext context) {
    final points = summary.points.isEmpty
        ? const [
            TodayTrendPoint(dayLabel: 'Mon', score: 72),
            TodayTrendPoint(dayLabel: 'Tue', score: 76),
            TodayTrendPoint(dayLabel: 'Wed', score: 81),
            TodayTrendPoint(dayLabel: 'Thu', score: 85),
            TodayTrendPoint(dayLabel: 'Fri', score: 79),
            TodayTrendPoint(dayLabel: 'Sat', score: 83),
            TodayTrendPoint(dayLabel: 'Sun', score: 82),
          ]
        : summary.points;
    final minScore = points
        .map((point) => point.score)
        .reduce((left, right) => left < right ? left : right);
    final maxScore = points
        .map((point) => point.score)
        .reduce((left, right) => left > right ? left : right);

    return LineChartData(
      minX: 0,
      maxX: (points.length - 1).toDouble(),
      minY: (minScore - 6).toDouble(),
      maxY: (maxScore + 6).toDouble(),
      clipData: const FlClipData.all(),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      lineTouchData: const LineTouchData(enabled: false),
      titlesData: const FlTitlesData(
        leftTitles: AxisTitles(),
        rightTitles: AxisTitles(),
        bottomTitles: AxisTitles(),
        topTitles: AxisTitles(),
      ),
      extraLinesData: const ExtraLinesData(),
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          curveSmoothness: 0.22,
          color: TodayDashboardStyle.trendLine,
          barWidth: 2.8,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, bar, index) {
              return FlDotCirclePainter(
                radius: 4.2,
                color: TodayDashboardStyle.trendLine,
                strokeWidth: 1.8,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(show: false),
          spots: List.generate(
            points.length,
            (index) => FlSpot(index.toDouble(), points[index].score.toDouble()),
          ),
        ),
      ],
    );
  }
}
