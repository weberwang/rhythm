import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/calendar/application/calendar_controller.dart';
import 'package:rhythm/features/calendar/application/calendar_view_state.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_mood.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/domain/calendar_heat_level.dart';
import 'package:rhythm/features/calendar/domain/calendar_month_summary.dart';
import 'package:rhythm/features/calendar/presentation/calendar_page.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_rules.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证日历页会根据控制器状态渲染 Pencil 风格的显示层结构。
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

  testWidgets('ready 状态展示 Pencil 风格标题、热力图卡和预览卡', (tester) async {
    await pumpPage(tester, state: _readyState());

    expect(find.text('五月的节律分布'), findsOneWidget);
    expect(find.text('颜色不是坏消息，而是你与目标时间的距离。'), findsOneWidget);
    expect(find.text('本月已有 3 天在轨道里，更多 2 天有偏航。'), findsOneWidget);
    expect(find.text('2026 年 5 月'), findsOneWidget);
    expect(find.text('达标率'), findsOneWidget);
    expect(find.text('最晚一晚'), findsOneWidget);
    expect(find.text('5 月 3 日预览'), findsOneWidget);
    expect(find.text('点击展开详情弹层'), findsOneWidget);
  });

  testWidgets('当月还没有记录时顶部摘要显示空态提示', (tester) async {
    await pumpPage(
      tester,
      state: _readyState(
        onTargetDays: 0,
        recordedDays: 0,
        latestLateDayIndex: null,
      ),
    );

    expect(find.text('本月还没有可用节律样本。先记录几天，再回来看走势。'), findsAtLeastNWidgets(1));
  });

  testWidgets('日历页不再显示筛选入口', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 720));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await pumpPage(tester, state: _readyState());

    expect(tester.takeException(), isNull);
    expect(find.text('全部日期'), findsNothing);
    expect(find.text('筛选'), findsNothing);
  });

  testWidgets('不同热力等级日期格使用不同颜色语义', (tester) async {
    await pumpPage(tester, state: _readyState());

    final containers = tester
        .widgetList<Container>(
          find.descendant(
            of: find.byType(GridView),
            matching: find.byType(Container),
          ),
        )
        .toList();

    final decorated = containers
        .where((item) => item.decoration is BoxDecoration)
        .toList();

    final colors = decorated
        .map((item) => (item.decoration as BoxDecoration).color)
        .whereType<Color>()
        .toSet();

    expect(colors.length, greaterThan(1));
  });

  testWidgets('页面级 ready 状态不再渲染情绪纸片叠层', (tester) async {
    await pumpPage(tester, state: _readyState());

    expect(find.byKey(const Key('calendar-mood-paper-3')), findsNothing);
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

/// 构造页面测试用 ready 状态，统一复用 5 月样例数据。
CalendarViewState _readyStateBase() {
  final days = List<CalendarDaySummary>.generate(31, (index) {
    if (index == 0) {
      return CalendarDaySummary(
        date: DateTime.utc(2026, 5, 1),
        record: null,
        sleepOffsetMinutes: null,
        heatLevel: CalendarHeatLevel.noRecord,
        tags: const <String>[],
        primaryMood: null,
        hasSecondaryMood: false,
      );
    }
    if (index == 1) {
      return CalendarDaySummary(
        date: DateTime.utc(2026, 5, 2),
        record: null,
        sleepOffsetMinutes: 10,
        heatLevel: CalendarHeatLevel.onTarget,
        tags: const <String>[],
        primaryMood: null,
        hasSecondaryMood: false,
      );
    }
    if (index == 2) {
      return CalendarDaySummary(
        date: DateTime.utc(2026, 5, 3),
        record: null,
        sleepOffsetMinutes: 42,
        heatLevel: CalendarHeatLevel.late,
        tags: const <String>['加班', '游戏'],
        primaryMood: CalendarDayMood.restless,
        hasSecondaryMood: true,
      );
    }
    return CalendarDaySummary(
      date: DateTime.utc(2026, 5, index + 1),
      record: null,
      sleepOffsetMinutes: null,
      heatLevel: CalendarHeatLevel.noRecord,
      tags: const <String>[],
      primaryMood: null,
      hasSecondaryMood: false,
    );
  });
  return CalendarViewState(
    status: CalendarViewStatus.ready,
    monthSummary: CalendarMonthSummary(
      month: DateTime.utc(2026, 5),
      days: days,
      onTargetDays: 16,
      recordedDays: 25,
      latestLateDay: days[2],
    ),
    availableTags: SleepDelayTagRules.defaultTags,
  );
}

/// 兼容现有测试调用方式，便于覆盖空态和摘要差异。
CalendarViewState _readyState({
  int onTargetDays = 3,
  int recordedDays = 5,
  int? latestLateDayIndex = 2,
}) {
  final baseState = _readyStateBase();
  final monthSummary = baseState.monthSummary!;
  return CalendarViewState(
    status: baseState.status,
    monthSummary: CalendarMonthSummary(
      month: monthSummary.month,
      days: monthSummary.days,
      onTargetDays: onTargetDays,
      recordedDays: recordedDays,
      latestLateDay: latestLateDayIndex == null
          ? null
          : monthSummary.days[latestLateDayIndex],
    ),
    availableTags: baseState.availableTags,
  );
}
