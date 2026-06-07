import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/features/calendar/application/providers/calendar_overview_provider.dart';
import 'package:rhythm/features/calendar/domain/entities/calendar_overview.dart';
import 'package:rhythm/features/calendar/presentation/pages/calendar_page.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/sleep_record_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/goal_schedule.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/sleep_record.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/goal_schedule_repository.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/sleep_record_repository.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 用内存作息仓储隔离 calendar 页面测试。
class _FakeGoalScheduleRepository implements GoalScheduleRepository {
  _FakeGoalScheduleRepository(this._schedule);

  GoalSchedule? _schedule;

  @override
  Future<GoalSchedule?> readActiveSchedule() async => _schedule;

  @override
  Future<void> saveActiveSchedule(GoalSchedule schedule) async {
    _schedule = schedule;
  }
}

/// 用内存记录仓储承接 calendar 页面测试，避免依赖真实数据库。
class _FakeSleepRecordRepository implements SleepRecordRepository {
  _FakeSleepRecordRepository(this.records);

  final List<SleepRecord> records;

  @override
  Future<SleepRecord?> readLatestRecord() async => null;

  @override
  Future<List<SleepRecord>> readRecentRecords({required int limit}) async {
    return records.take(limit).toList(growable: false);
  }

  @override
  Future<List<SleepRecord>> readRecordsInRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return records
        .where(
          (record) =>
              !record.sleepDate.isBefore(startDate) &&
              !record.sleepDate.isAfter(endDate),
        )
        .toList(growable: false);
  }

  @override
  Future<void> saveManualRecord(SleepRecord record) async {}
}

/// 验证 calendar 页面已从占位页进入真实月视图与单日详情体验。
void main() {
  void usePhoneViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Future<void> pumpCalendarPage(
    WidgetTester tester, {
    required ProviderContainer container,
  }) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const CalendarPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  ProviderContainer createContainer() {
    return ProviderContainer(
      overrides: [
        goalScheduleRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleRepository(
            GoalSchedule(
              id: 'fixture',
              bedtimeMinutes: 23 * 60,
              wakeTimeMinutes: 7 * 60,
              createdAt: DateTime(2026, 6, 6),
            ),
          ),
        ),
        sleepRecordRepositoryProvider.overrideWithValue(
          _FakeSleepRecordRepository([
            SleepRecord(
              id: 'record-1',
              sleepDate: DateTime(2026, 6, 2),
              bedtimeMinutes: 23 * 60,
              wakeTimeMinutes: 7 * 60,
              source: SleepRecordSource.health,
              confidence: SleepRecordConfidence.trusted,
              isManuallyAdjusted: false,
              note: null,
              createdAt: DateTime(2026, 6, 3, 7),
            ),
            SleepRecord(
              id: 'record-2',
              sleepDate: DateTime(2026, 6, 3),
              bedtimeMinutes: 23 * 60 + 35,
              wakeTimeMinutes: 7 * 60 + 10,
              source: SleepRecordSource.manual,
              confidence: SleepRecordConfidence.partial,
              isManuallyAdjusted: true,
              note: '手动修正',
              createdAt: DateTime(2026, 6, 4, 7),
            ),
          ]),
        ),
        calendarNowProvider.overrideWithValue(DateTime(2026, 6, 18, 8)),
      ],
    );
  }

  testWidgets('calendar page matches populated high-fidelity layout', (
    tester,
  ) async {
    usePhoneViewport(tester);
    final container = createContainer();
    addTearDown(container.dispose);

    await pumpCalendarPage(tester, container: container);

    expect(find.text('Rhythm'), findsOneWidget);
    expect(find.text('2026年6月'), findsOneWidget);
    expect(find.byKey(const Key('calendar-monthly-summary-card')), findsOneWidget);
    expect(find.byKey(const Key('calendar-summary-metric-average-delay')), findsOneWidget);
    expect(find.byKey(const Key('calendar-summary-metric-average-sleep')), findsOneWidget);
    expect(find.byKey(const Key('calendar-summary-metric-average-wake')), findsOneWidget);
    expect(find.byKey(const Key('calendar-summary-metric-tracked-days')), findsOneWidget);
    expect(find.byKey(const Key('calendar-heatmap-grid')), findsOneWidget);
    expect(find.byKey(const Key('calendar-filter-strip')), findsOneWidget);
    expect(find.byKey(const Key('calendar-day-detail-card')), findsOneWidget);
    expect(find.text('初始化占位'), findsNothing);
  });

  testWidgets('calendar page keeps locked state and selected day detail semantics', (
    tester,
  ) async {
    usePhoneViewport(tester);
    final container = createContainer();
    addTearDown(container.dispose);

    await pumpCalendarPage(tester, container: container);

    container
        .read(calendarFilterControllerProvider.notifier)
        .select(CalendarFilterMode.lockedInsights);
    await tester.pumpAndSettle();

    expect(find.text('更早历史与原因分布将在洞察页解锁'), findsOneWidget);
    expect(find.byKey(const Key('calendar-heatmap-grid')), findsOneWidget);

    expect(find.byKey(const Key('calendar-day-detail-card')), findsOneWidget);
    expect(find.text('手动补录'), findsOneWidget);
    expect(find.text('手动修正'), findsAtLeastNWidgets(1));
  });

  testWidgets('calendar page keeps empty month structure without overflow', (
    tester,
  ) async {
    usePhoneViewport(tester);

    final container = ProviderContainer(
      overrides: [
        goalScheduleRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleRepository(
            GoalSchedule(
              id: 'fixture',
              bedtimeMinutes: 23 * 60,
              wakeTimeMinutes: 7 * 60,
              createdAt: DateTime(2026, 6, 6),
            ),
          ),
        ),
        sleepRecordRepositoryProvider.overrideWithValue(
          _FakeSleepRecordRepository(const []),
        ),
        calendarNowProvider.overrideWithValue(DateTime(2026, 6, 18, 8)),
      ],
    );
    addTearDown(container.dispose);

    await pumpCalendarPage(tester, container: container);

    expect(find.text('Rhythm'), findsOneWidget);
    expect(find.byKey(const Key('calendar-monthly-summary-card')), findsOneWidget);
    expect(find.byKey(const Key('calendar-heatmap-grid')), findsOneWidget);
    expect(find.text('本月还没有睡眠记录'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
