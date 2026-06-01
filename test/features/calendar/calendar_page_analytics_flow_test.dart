import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/analytics/analytics_event.dart';
import 'package:rhythm/core/analytics/in_memory_analytics_gateway.dart';
import 'package:rhythm/features/calendar/application/calendar_analytics.dart';
import 'package:rhythm/features/calendar/application/calendar_controller.dart';
import 'package:rhythm/features/calendar/application/calendar_view_state.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_mood.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/domain/calendar_heat_level.dart';
import 'package:rhythm/features/calendar/domain/calendar_month_summary.dart';
import 'package:rhythm/features/calendar/presentation/calendar_page.dart';
import 'package:rhythm/features/sleep_records/application/sleep_delay_tag_providers.dart';
import 'package:rhythm/features/sleep_records/data/in_memory_sleep_delay_tag_repository.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_rules.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证阶段六页面交互会触发日历埋点。
void main() {
  testWidgets('进入页面、打开详情、保存标签会记录事件', (tester) async {
    final analytics = InMemoryAnalyticsGateway();
    final repository = InMemorySleepDelayTagRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          calendarAnalyticsGatewayProvider.overrideWithValue(analytics),
          sleepDelayTagRepositoryProvider.overrideWithValue(repository),
          calendarControllerProvider.overrideWith(
            () => _FakeCalendarController(_readyState()),
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

    await tester.ensureVisible(find.text('24').first);
    await tester.tap(find.text('24').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('添加标签'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('刷手机').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存标签'));
    await tester.pumpAndSettle();

    expect(analytics.events.map((event) => event.name).toList(), [
      AnalyticsEventName.calendarViewed,
      AnalyticsEventName.dayDetailViewed,
      AnalyticsEventName.delayTagAdded,
    ]);
  });
}

CalendarViewState _readyState() {
  final days = List<CalendarDaySummary>.generate(31, (index) {
    if (index == 23) {
      return CalendarDaySummary(
        date: DateTime.utc(2026, 5, 24),
        record: EffectiveSleepRecord(
          recordId: 'r24',
          recordDate: DateTime.utc(2026, 5, 24),
          fellAsleepAt: DateTime.utc(2026, 5, 25, 0, 20),
          wokeUpAt: DateTime.utc(2026, 5, 25, 8, 20),
          durationMinutes: 8 * 60,
          source: SleepRecordSource.healthKit,
          confidence: SleepRecordConfidence.high,
          timezone: 'Asia/Shanghai',
          isUserConfirmed: false,
          sourceRecordId: null,
        ),
        sleepOffsetMinutes: 50,
        heatLevel: CalendarHeatLevel.late,
        tags: const <String>['刷手机'],
        primaryMood: CalendarDayMood.drained,
        hasSecondaryMood: false,
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
      latestLateDay: days[23],
    ),
    availableTags: SleepDelayTagRules.defaultTags,
  );
}

class _FakeCalendarController extends CalendarController {
  _FakeCalendarController(this._state);

  final CalendarViewState _state;

  @override
  Future<CalendarViewState> build() async {
    return _state;
  }

  @override
  Future<void> reload() async {}
}
