import 'package:flutter/material.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/presentation/widgets/calendar_mood_style.dart';

/// 渲染日期格内部的情绪纸片层。
class CalendarMoodPaper extends StatelessWidget {
  /// 创建单日情绪纸片。
  const CalendarMoodPaper({super.key, required this.day});

  /// 当前日期摘要，纸片只消费已计算好的情绪结果。
  final CalendarDaySummary day;

  @override
  Widget build(BuildContext context) {
    final mood = day.primaryMood;
    if (mood == null) {
      return const SizedBox.shrink();
    }

    final style = resolveCalendarMoodStyle(context, mood);
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final paperWidth = constraints.maxWidth * style.widthFactor;
          final paperHeight = constraints.maxHeight * style.heightFactor;
          final recordOpacity = day.hasRecord ? 1.0 : 0.55;
          final paperColor = style.fillColor.withValues(
            alpha: style.opacity * recordOpacity,
          );
          return Stack(
            children: [
              Positioned(
                right: constraints.maxWidth * 0.12,
                bottom: constraints.maxHeight * 0.12,
                child: Transform.rotate(
                  angle: style.rotationRadians,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      if (day.hasSecondaryMood)
                        Positioned(
                          right: -2,
                          bottom: -2,
                          child: Container(
                            key: Key(
                              'calendar-mood-paper-secondary-${day.date.day}',
                            ),
                            width: paperWidth * 0.78,
                            height: 3,
                            decoration: BoxDecoration(
                              color: style.edgeColor.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                      Container(
                        key: Key('calendar-mood-paper-${day.date.day}'),
                        width: paperWidth,
                        height: paperHeight,
                        decoration: BoxDecoration(
                          color: paperColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
