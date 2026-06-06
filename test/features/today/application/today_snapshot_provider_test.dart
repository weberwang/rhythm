import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/app_shell/application/providers/current_account_session_provider.dart';
import 'package:rhythm/features/app_shell/domain/entities/account_session.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/sleep_record_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/sleep_data_core_status_provider.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/goal_schedule.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/sleep_record.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/sleep_data_core_status.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/goal_schedule_repository.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/sleep_record_repository.dart';
import 'package:rhythm/features/today/application/providers/today_snapshot_provider.dart';
import 'package:rhythm/features/today/domain/entities/today_snapshot.dart';

/// 用内存仓储稳定 today 聚合输入，避免测试依赖真实本地库。
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

/// 用内存记录仓储驱动 today 聚合，确保首屏趋势与昨晚结果来自真实样本而非静态常量。
class _FakeSleepRecordRepository implements SleepRecordRepository {
  _FakeSleepRecordRepository(this._records);

  final List<SleepRecord> _records;

  @override
  Future<SleepRecord?> readLatestRecord() async {
    if (_records.isEmpty) {
      return null;
    }
    return _records.first;
  }

  @override
  Future<List<SleepRecord>> readRecentRecords({required int limit}) async {
    return _records.take(limit).toList();
  }

  @override
  Future<List<SleepRecord>> readRecordsInRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return _records
        .where(
          (record) =>
              !record.sleepDate.isBefore(startDate) &&
              !record.sleepDate.isAfter(endDate),
        )
        .toList(growable: false);
  }

  @override
  Future<void> saveManualRecord(SleepRecord record) async {
    _records.insert(0, record);
  }
}

/// 验证 today 聚合会先消费共享基线，而不是在页面层临时拼文案。
void main() {
  test(
    'today snapshot exposes no-data summary for anonymous local-first users',
    () async {
      final container = ProviderContainer(
        overrides: [
          goalScheduleRepositoryProvider.overrideWithValue(
            _FakeGoalScheduleRepository(
              GoalSchedule(
                id: 'fixture',
                bedtimeMinutes: 22 * 60 + 30,
                wakeTimeMinutes: 7 * 60,
                createdAt: DateTime(2026, 6, 6),
              ),
            ),
          ),
          sleepRecordRepositoryProvider.overrideWithValue(
            _FakeSleepRecordRepository([]),
          ),
          currentAccountSessionProvider.overrideWith(
            (ref) async => AppAccountSession(
              mode: AppAccountSessionMode.anonymous,
              updatedAt: DateTime(2026, 6, 6),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final snapshot = await container.read(todaySnapshotProvider.future);

      expect(snapshot.displayName, isNull);
      expect(snapshot.lastNight.status, TodayLastNightStatus.noData);
      expect(snapshot.tonightGoal.bedtimeLabel, '10:30 PM');
      expect(snapshot.recovery.status, TodayRecoveryStatus.buildBaseline);
      expect(snapshot.trend.status, TodayTrendStatus.building);
    },
  );

  test(
    'today snapshot surfaces sync recovery messaging when sync is degraded',
    () async {
      final container = ProviderContainer(
        overrides: [
          goalScheduleRepositoryProvider.overrideWithValue(
            _FakeGoalScheduleRepository(
              GoalSchedule(
                id: 'fixture',
                bedtimeMinutes: 23 * 60,
                wakeTimeMinutes: 7 * 60 + 30,
                createdAt: DateTime(2026, 6, 6),
              ),
            ),
          ),
          sleepRecordRepositoryProvider.overrideWithValue(
            _FakeSleepRecordRepository([]),
          ),
          currentAccountSessionProvider.overrideWith(
            (ref) async => AppAccountSession(
              mode: AppAccountSessionMode.connected,
              provider: AppAccountProvider.google,
              displayName: 'Jamie',
              email: 'jamie@example.com',
              updatedAt: DateTime(2026, 6, 6),
            ),
          ),
          sleepDataCoreStatusProvider.overrideWithValue(
            const SleepDataCoreStatus(
              sourceConfidence: SleepSourceConfidence.partial,
              syncStatus: SleepSyncStatus.failedRecoverable,
              timezoneContext: SleepTimezoneContext.stable,
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final snapshot = await container.read(todaySnapshotProvider.future);

      expect(snapshot.displayName, 'Jamie');
      expect(snapshot.lastNight.status, TodayLastNightStatus.syncRecoverable);
      expect(snapshot.recovery.status, TodayRecoveryStatus.syncRecoveryFirst);
      expect(snapshot.quickRecord.status, TodayQuickRecordStatus.recommended);
    },
  );

  test(
    'today snapshot derives real last-night summary and ready trend from sleep records',
    () async {
      final container = ProviderContainer(
        overrides: [
          goalScheduleRepositoryProvider.overrideWithValue(
            _FakeGoalScheduleRepository(
              GoalSchedule(
                id: 'fixture',
                bedtimeMinutes: 22 * 60 + 30,
                wakeTimeMinutes: 7 * 60,
                createdAt: DateTime(2026, 6, 6),
              ),
            ),
          ),
          sleepRecordRepositoryProvider.overrideWithValue(
            _FakeSleepRecordRepository([
              SleepRecord(
                id: 'latest',
                sleepDate: DateTime(2026, 6, 5),
                bedtimeMinutes: 23 * 60 + 54,
                wakeTimeMinutes: 7 * 60 + 24,
                source: SleepRecordSource.manual,
                confidence: SleepRecordConfidence.trusted,
                isManuallyAdjusted: false,
                note: '晚了一些',
                createdAt: DateTime(2026, 6, 6, 7, 24),
              ),
              SleepRecord(
                id: 'older-1',
                sleepDate: DateTime(2026, 6, 4),
                bedtimeMinutes: 22 * 60 + 48,
                wakeTimeMinutes: 7 * 60 + 4,
                source: SleepRecordSource.manual,
                confidence: SleepRecordConfidence.trusted,
                isManuallyAdjusted: false,
                note: null,
                createdAt: DateTime(2026, 6, 5, 7, 4),
              ),
              SleepRecord(
                id: 'older-2',
                sleepDate: DateTime(2026, 6, 3),
                bedtimeMinutes: 22 * 60 + 36,
                wakeTimeMinutes: 6 * 60 + 58,
                source: SleepRecordSource.manual,
                confidence: SleepRecordConfidence.trusted,
                isManuallyAdjusted: false,
                note: null,
                createdAt: DateTime(2026, 6, 4, 6, 58),
              ),
            ]),
          ),
          currentAccountSessionProvider.overrideWith(
            (ref) async => AppAccountSession(
              mode: AppAccountSessionMode.connected,
              provider: AppAccountProvider.apple,
              displayName: 'Chris',
              email: 'chris@example.com',
              updatedAt: DateTime(2026, 6, 6),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final snapshot = await container.read(todaySnapshotProvider.future);

      expect(snapshot.displayName, 'Chris');
      expect(snapshot.lastNight.status, TodayLastNightStatus.majorDelay);
      expect(snapshot.recovery.status, TodayRecoveryStatus.recoverAfterDelay);
      expect(snapshot.quickRecord.status, TodayQuickRecordStatus.recommended);
      expect(snapshot.trend.status, TodayTrendStatus.ready);
      expect(snapshot.trend.points, hasLength(3));
      expect(snapshot.trend.averageScore, isNotNull);
    },
  );
}
