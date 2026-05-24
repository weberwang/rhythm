import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/calendar/application/calendar_controller.dart';
import 'package:rhythm/features/calendar/application/calendar_view_state.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/domain/calendar_filter.dart';
import 'package:rhythm/features/calendar/domain/calendar_heat_level.dart';
import 'package:rhythm/features/calendar/domain/calendar_month_summary.dart';
import 'package:rhythm/features/calendar/presentation/calendar_page.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_rules.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证阶段六日历页会根据控制器状态渲染真实页面结构。
void main() {
  Future<void> pumpPage(
    WidgetTester tester, {
    required CalendarViewState state,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          calendarControllerProvider.overrideWith(
            () => _FakeCalendarController(state),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: CalendarPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('ready 状态显示标题、筛选和摘要卡', (tester) async {
    await pumpPage(tester, state: _readyState());

    expect(find.text('颜色不是坏消息，而是你与目标时间的距离。'), findsOneWidget);
    expect(find.text('全部日期'), findsOneWidget);
    expect(find.text('达标率'), findsOneWidget);
    expect(find.text('最晚一晚'), findsOneWidget);
  });

  testWidgets('已应用筛选时显示对应筛选摘要', (tester) async {
    await pumpPage(
      tester,
      state: _readyState(
        activeFilter: const CalendarFilter(
          onlyRecordedDays: true,
          lateOnly: true,
        ),
      ),
    );

    expect(find.text('只看有记录日期'), findsOneWidget);
    expect(find.text('只看晚睡日期'), findsOneWidget);
    expect(find.text('全部日期'), findsNothing);
  });

  testWidgets('不同热力等级日期格使用不同颜色语义', (tester) async {
    await pumpPage(tester, state: _readyState());

    final containers = tester.widgetList<Container>(
      find.descendant(
        of: find.byType(GridView),
        matching: find.byType(Container),
      ),
    ).toList();

    final decorated = containers
        .where((item) => item.decoration is BoxDecoration)
        .toList();

    final colors = decorated
        .map((item) => (item.decoration as BoxDecoration).color)
        .whereType<Color>()
        .toSet();

    expect(colors.length, greaterThan(1));
  });

  testWidgets('goalMissing 状态显示缺少目标空态', (tester) async {
    await pumpPage(
      tester,
      state: const CalendarViewState(status: CalendarViewStatus.goalMissing),
    );

    expect(find.text('还没有设置作息目标'), findsOneWidget);
  });
}

class _FakeCalendarController extends CalendarController {
  _FakeCalendarController(this._state);

  final CalendarViewState _state;

  @override
  Future<CalendarViewState> build() async {
    return _state;
  }
}

/// 构造页面测试用 ready 状态，并允许显式指定当前筛选条件。
CalendarViewState _readyStateWithFilter(CalendarFilter activeFilter) {
  final days = List<CalendarDaySummary>.generate(31, (index) {
    if (index == 0) {
      return CalendarDaySummary(
        date: DateTime.utc(2026, 5, 1),
        record: null,
        sleepOffsetMinutes: null,
        heatLevel: CalendarHeatLevel.noRecord,
        tags: const <String>[],
      );
    }
    if (index == 1) {
      return CalendarDaySummary(
        date: DateTime.utc(2026, 5, 2),
        record: null,
        sleepOffsetMinutes: 10,
        heatLevel: CalendarHeatLevel.onTarget,
        tags: const <String>[],
      );
    }
    if (index == 2) {
      return CalendarDaySummary(
        date: DateTime.utc(2026, 5, 3),
        record: null,
        sleepOffsetMinutes: 42,
        heatLevel: CalendarHeatLevel.late,
        tags: const <String>[],
      );
    }
    return CalendarDaySummary(
      date: DateTime.utc(2026, 5, index + 1),
      record: null,
      sleepOffsetMinutes: null,
      heatLevel: CalendarHeatLevel.noRecord,
      tags: const <String>[],
    );
  });
  return CalendarViewState(
    status: CalendarViewStatus.ready,
    monthSummary: CalendarMonthSummary(
      month: DateTime.utc(2026, 5),
      days: days,
      onTargetDays: 16,
      recordedDays: 25,
      latestLateDay: days[23],
    ),
    availableTags: SleepDelayTagRules.defaultTags,
    activeFilter: activeFilter,
  );
}

/// 兼容现有测试调用方式，便于逐步补齐筛选态断言。
CalendarViewState _readyState({
  CalendarFilter activeFilter = const CalendarFilter(),
}) {
  return _readyStateWithFilter(activeFilter);
}
