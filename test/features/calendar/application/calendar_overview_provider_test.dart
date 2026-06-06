import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/features/calendar/application/providers/calendar_overview_provider.dart';
import 'package:rhythm/features/calendar/domain/entities/calendar_overview.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/sleep_record_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/goal_schedule.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/sleep_record.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/goal_schedule_repository.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/sleep_record_repository.dart';

/// 用内存作息仓储隔离 calendar 聚合测试，避免依赖真实本地库。
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

/// 用内存记录仓储驱动 calendar 聚合测试，验证月度查询和筛选语义。
class _FakeSleepRecordRepository implements SleepRecordRepository {
  _FakeSleepRecordRepository(this.records);

  final List<SleepRecord> records;

  @override
  Future<SleepRecord?> readLatestRecord() async {
    if (records.isEmpty) {
      return null;
    }

    return records.reduce(
      (left, right) => left.createdAt.isAfter(right.createdAt) ? left : right,
    );
  }

  @override
  Future<List<SleepRecord>> readRecentRecords({required int limit}) async {
    final sorted = [...records]
      ..sort((left, right) => right.sleepDate.compareTo(left.sleepDate));
    return sorted.take(limit).toList(growable: false);
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

/// 验证 calendar 聚合先把“月视图 + 锁定态 + 单日解释”收敛成稳定状态对象。
void main() {
  ProviderContainer createContainer(List<SleepRecord> records) {
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
          _FakeSleepRecordRepository(records),
        ),
        calendarNowProvider.overrideWithValue(DateTime(2026, 6, 18, 8)),
      ],
    );
  }

  test('builds overview from monthly records', () async {
    final container = createContainer([
      SleepRecord(
        id: 'record-1',
        sleepDate: DateTime(2026, 6, 1),
        bedtimeMinutes: 23 * 60,
        wakeTimeMinutes: 7 * 60,
        source: SleepRecordSource.health,
        confidence: SleepRecordConfidence.trusted,
        isManuallyAdjusted: false,
        note: null,
        createdAt: DateTime(2026, 6, 2, 7),
      ),
      SleepRecord(
        id: 'record-2',
        sleepDate: DateTime(2026, 6, 2),
        bedtimeMinutes: 23 * 60 + 28,
        wakeTimeMinutes: 7 * 60 + 10,
        source: SleepRecordSource.manual,
        confidence: SleepRecordConfidence.partial,
        isManuallyAdjusted: true,
        note: '手动修正',
        createdAt: DateTime(2026, 6, 3, 7),
      ),
      SleepRecord(
        id: 'record-3',
        sleepDate: DateTime(2026, 6, 3),
        bedtimeMinutes: 0 * 60 + 35,
        wakeTimeMinutes: 7 * 60 + 25,
        source: SleepRecordSource.health,
        confidence: SleepRecordConfidence.trusted,
        isManuallyAdjusted: false,
        note: '聚会晚睡',
        createdAt: DateTime(2026, 6, 4, 7),
      ),
    ]);
    addTearDown(container.dispose);

    final overview = await container.read(calendarOverviewProvider.future);

    expect(overview.state, CalendarOverviewState.ready);
    expect(overview.month.year, 2026);
    expect(overview.month.month, 6);
    expect(overview.summary.recordedNights, 3);
    expect(overview.summary.onTargetNights, 1);
    expect(overview.summary.delayedNights, 2);
    expect(
      overview.days.firstWhere((day) => day.dayOfMonth == 2).visualState,
      CalendarDayVisualState.partial,
    );
    expect(
      overview.days.firstWhere((day) => day.dayOfMonth == 3).detail,
      isNotNull,
    );
  });

  test('returns no-data overview when monthly records are empty', () async {
    final container = createContainer([]);
    addTearDown(container.dispose);

    final overview = await container.read(calendarOverviewProvider.future);

    expect(overview.state, CalendarOverviewState.noData);
    expect(overview.summary.recordedNights, 0);
    expect(overview.days, isNotEmpty);
  });

  test('returns locked history state for premium filter outside free window', () async {
    final container = createContainer([
      SleepRecord(
        id: 'record-1',
        sleepDate: DateTime(2026, 6, 2),
        bedtimeMinutes: 23 * 60 + 35,
        wakeTimeMinutes: 7 * 60 + 10,
        source: SleepRecordSource.health,
        confidence: SleepRecordConfidence.trusted,
        isManuallyAdjusted: false,
        note: null,
        createdAt: DateTime(2026, 6, 3, 7),
      ),
    ]);
    addTearDown(container.dispose);

    container
        .read(calendarFilterControllerProvider.notifier)
        .select(CalendarFilterMode.lockedInsights);

    final overview = await container.read(calendarOverviewProvider.future);

    expect(overview.accessState, CalendarHistoryAccessState.locked);
    expect(overview.days.where((day) => day.hasRecord), isNotEmpty);
  });
}
