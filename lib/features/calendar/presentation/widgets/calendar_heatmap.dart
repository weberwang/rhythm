import 'package:flutter/material.dart';
import 'package:rhythm/app/theme/app_theme_tokens.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/domain/calendar_heat_level.dart';

/// 渲染日历页热力网格，按日摘要真实映射颜色和日期。
class CalendarHeatmap extends StatelessWidget {
  /// 创建热力图组件。
  const CalendarHeatmap({
    super.key,
    required this.days,
    required this.onTapDay,
  });

  /// 当前月摘要中的日期集合。
  final List<CalendarDaySummary> days;

  /// 点击日期格时的回调。
  final ValueChanged<CalendarDaySummary> onTapDay;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: days.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final day = days[index];
        return Container(
          decoration: BoxDecoration(
            color: _resolveCellColor(context, day.heatLevel),
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => onTapDay(day),
            child: Center(
              child: Text(
                '${day.date.day}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _resolveCellColor(BuildContext context, CalendarHeatLevel heatLevel) {
    final tokens = Theme.of(context).brightness == Brightness.dark
        ? AppThemeTokens.dark
        : AppThemeTokens.light;
    switch (heatLevel) {
      case CalendarHeatLevel.noRecord:
        return tokens.surface;
      case CalendarHeatLevel.onTarget:
        return tokens.successSurface;
      case CalendarHeatLevel.slightlyLate:
        return tokens.warningSurface;
      case CalendarHeatLevel.late:
        return tokens.dangerSurface;
      case CalendarHeatLevel.severelyLate:
        return tokens.danger;
    }
  }
}
