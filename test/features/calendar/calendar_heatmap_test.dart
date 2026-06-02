import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_mood.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/domain/calendar_heat_level.dart';
import 'package:rhythm/features/calendar/presentation/widgets/calendar_heatmap.dart';

void main() {
  testWidgets('日期格按照 pen 使用 12 号等宽数字、14 圆角和 10 像素圆点', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CalendarHeatmap(
            days: <CalendarDaySummary>[
              CalendarDaySummary(
                date: DateTime.utc(2026, 5, 1),
                record: null,
                sleepOffsetMinutes: 10,
                heatLevel: CalendarHeatLevel.onTarget,
                tags: const <String>[],
                primaryMood: null,
                hasSecondaryMood: false,
              ),
            ],
            onTapDay: (_) {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final gridView = tester.widget<GridView>(find.byType(GridView));
    final gridDelegate =
        gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
    final dateText = tester.widget<Text>(find.text('1'));
    final dotFinder = find.byWidgetPredicate((widget) {
      return widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).borderRadius != null;
    }).last;
    final dotRenderBox = tester.renderObject<RenderBox>(dotFinder);
    final cell = tester.widget<DecoratedBox>(find.byType(DecoratedBox).first);
    final decoration = cell.decoration as BoxDecoration;

    expect(gridDelegate.childAspectRatio, closeTo(0.88, 0.001));
    expect(dateText.style?.fontFamily, 'IBM Plex Mono');
    expect(dateText.style?.fontSize, 12);
    expect(dateText.style?.fontWeight, FontWeight.w700);
    expect(dotRenderBox.size.width, 10);
    expect(dotRenderBox.size.height, 10);
    expect((decoration.borderRadius! as BorderRadius).topLeft.x, 14);
  });

  testWidgets('日期格按 pen 只保留背景与小圆点，不再渲染纸片叠层', (tester) async {
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

    expect(find.byKey(const Key('calendar-mood-paper-2')), findsNothing);
    expect(find.byKey(const Key('calendar-mood-paper-secondary-2')), findsNothing);
    expect(find.byKey(const Key('calendar-mood-paper-1')), findsNothing);
  });
}
