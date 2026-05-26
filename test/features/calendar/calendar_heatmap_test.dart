import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_mood.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/domain/calendar_heat_level.dart';
import 'package:rhythm/features/calendar/presentation/widgets/calendar_heatmap.dart';

void main() {
  testWidgets('有主情绪的日期格会渲染纸片，多标签时露出第二层纸边', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CalendarHeatmap(
            days: <CalendarDaySummary>[
              CalendarDaySummary(
                date: DateTime.utc(2026, 5),
                record: null,
                sleepOffsetMinutes: null,
                heatLevel: CalendarHeatLevel.noRecord,
                tags: const <String>[],
                primaryMood: null,
                hasSecondaryMood: false,
              ),
              CalendarDaySummary(
                date: DateTime.utc(2026, 5, 2),
                record: null,
                sleepOffsetMinutes: 40,
                heatLevel: CalendarHeatLevel.late,
                tags: const <String>['加班', '游戏'],
                primaryMood: CalendarDayMood.restless,
                hasSecondaryMood: true,
              ),
            ],
            onTapDay: (_) {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('calendar-mood-paper-2')), findsOneWidget);
    expect(
      find.byKey(const Key('calendar-mood-paper-secondary-2')),
      findsOneWidget,
    );
    expect(find.byKey(const Key('calendar-mood-paper-1')), findsNothing);
  });
}
