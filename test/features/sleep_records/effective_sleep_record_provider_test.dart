import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/time/time_context.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/data/local/rhythm_database.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/sleep_records/application/effective_sleep_record_provider.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/data/drift_sleep_record_repository.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';

import '../../support/sleep_records_test_doubles.dart';

/// 验证有效记录 Provider 会按业务归属日窗口返回最近 7 天和 30 天结果。
void main() {
  late DriftSleepRecordRepository repository;
  late RhythmDatabase database;

  setUp(() {
    database = RhythmDatabase.inMemory();
    repository = DriftSleepRecordRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('最近 7 天 Provider 会按一天起始时间裁剪业务窗口', () async {
    await repository.saveRecord(
      _buildRecord(id: 'old-1', recordDate: DateTime.utc(2026, 5, 16)),
    );
    await repository.saveRecord(
      _buildRecord(id: 'in-1', recordDate: DateTime.utc(2026, 5, 17)),
    );
    await repository.saveRecord(
      _buildRecord(id: 'in-2', recordDate: DateTime.utc(2026, 5, 23)),
    );
    await repository.saveRecord(
      _buildRecord(id: 'future-1', recordDate: DateTime.utc(2026, 5, 24)),
    );

    final container = ProviderContainer(
      overrides: [
        rhythmDatabaseProvider.overrideWithValue(database),
        sleepRecordRepositoryProvider.overrideWith((ref) => repository),
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          TestGoalScheduleSettingsRepository(
            const GoalScheduleSettings(
              targetBedtimeMinutes: 23 * 60 + 30,
              targetWakeMinutes: 7 * 60 + 30,
              lateThresholdMinutes: 30,
              dayStartMinutes: 4 * 60,
            ),
          ),
        ),
        timeContextProvider.overrideWithValue(
          TimeContext(
            now: DateTime.utc(2026, 5, 24, 3, 30),
            timezoneName: 'Asia/Shanghai',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final records = await container.read(
      recentSevenDayEffectiveSleepRecordsProvider.future,
    );

    expect(records.map((record) => record.recordId).toList(), ['in-1', 'in-2']);
  });

  test('最近 30 天 Provider 只返回窗口内的有效记录', () async {
    await repository.saveRecord(
      _buildRecord(id: 'out-30', recordDate: DateTime.utc(2026, 4, 23)),
    );
    await repository.saveRecord(
      _buildRecord(id: 'in-30-a', recordDate: DateTime.utc(2026, 4, 25)),
    );
    await repository.saveRecord(
      _buildRecord(id: 'in-30-b', recordDate: DateTime.utc(2026, 5, 23)),
    );

    final container = ProviderContainer(
      overrides: [
        rhythmDatabaseProvider.overrideWithValue(database),
        sleepRecordRepositoryProvider.overrideWith((ref) => repository),
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          TestGoalScheduleSettingsRepository(
            const GoalScheduleSettings(
              targetBedtimeMinutes: 23 * 60 + 30,
              targetWakeMinutes: 7 * 60 + 30,
              lateThresholdMinutes: 30,
              dayStartMinutes: 4 * 60,
            ),
          ),
        ),
        timeContextProvider.overrideWithValue(
          TimeContext(
            now: DateTime.utc(2026, 5, 24, 20),
            timezoneName: 'Asia/Shanghai',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final records = await container.read(
      recentThirtyDayEffectiveSleepRecordsProvider.future,
    );

    expect(
      records.map((record) => record.recordId).toList(),
      ['in-30-a', 'in-30-b'],
    );
  });
}

/// 构造测试用底层睡眠记录，保证查询窗口测试只关注归属日过滤。
SleepRecord _buildRecord({
  required String id,
  required DateTime recordDate,
}) {
  final fellAsleepAt = recordDate.add(const Duration(days: 1, hours: 1));
  final wokeUpAt = fellAsleepAt.add(const Duration(hours: 7, minutes: 30));
  return SleepRecord(
    id: id,
    recordDate: recordDate,
    fellAsleepAt: fellAsleepAt,
    wokeUpAt: wokeUpAt,
    durationMinutes: wokeUpAt.difference(fellAsleepAt).inMinutes,
    source: SleepRecordSource.healthKit,
    confidence: SleepRecordConfidence.high,
    timezone: 'Asia/Shanghai',
    isUserEdited: false,
    sourceRecordId: null,
    createdAt: wokeUpAt,
    updatedAt: wokeUpAt,
  );
}
