import 'package:flutter/material.dart';
import 'package:rhythm/app/theme/app_theme_tokens.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/domain/calendar_heat_level.dart';

/// 渲染日历页热力网格，按 Pencil 的竖向圆角日期卡映射颜色和日期。
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
        childAspectRatio: 0.88,
      ),
      itemBuilder: (context, index) {
        final day = days[index];
        return DecoratedBox(
          decoration: BoxDecoration(
            color: _resolveCellColor(context, day.heatLevel),
            borderRadius: BorderRadius.circular(14),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => onTapDay(day),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${day.date.day}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontFamily: 'IBM Plex Mono',
                    color: const Color(0xFF1B3A28),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _resolveDotColor(context, day.heatLevel),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ],
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
        return const Color(0xFFE3EEE0);
      case CalendarHeatLevel.slightlyLate:
        return tokens.successSurface;
      case CalendarHeatLevel.late:
        return tokens.warningSurface;
      case CalendarHeatLevel.severelyLate:
        return tokens.dangerSurface;
    }
  }

  Color _resolveDotColor(BuildContext context, CalendarHeatLevel heatLevel) {
    final tokens = Theme.of(context).brightness == Brightness.dark
        ? AppThemeTokens.dark
        : AppThemeTokens.light;
    switch (heatLevel) {
      case CalendarHeatLevel.noRecord:
        return const Color(0x00000000);
      case CalendarHeatLevel.onTarget:
        return tokens.primary;
      case CalendarHeatLevel.slightlyLate:
        return tokens.success;
      case CalendarHeatLevel.late:
        return tokens.warning;
      case CalendarHeatLevel.severelyLate:
        return tokens.danger;
    }
  }
}
