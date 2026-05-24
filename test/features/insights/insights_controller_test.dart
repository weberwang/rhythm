import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/time/time_context.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/insights/application/insights_controller.dart';
import 'package:rhythm/features/insights/application/insights_view_state.dart';
import 'package:rhythm/features/sleep_records/application/effective_sleep_record_provider.dart';
import 'package:rhythm/features/sleep_records/application/sleep_delay_tag_providers.dart';
import 'package:rhythm/features/sleep_records/data/in_memory_sleep_delay_tag_repository.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';

import '../../support/sleep_records_test_doubles.dart';

/// 验证洞察控制器只输出页面直接消费的聚合状态。
void main() {
  const settings = GoalScheduleSettings(
    targetBedtimeMinutes: 23 * 60 + 30,
    targetWakeMinutes: 7 * 60 + 30,
    lateThresholdMinutes: 30,
    dayStartMinutes: 4 * 60,
  );

  test('无有效记录时输出 empty 状态', () async {
    final container = ProviderContainer(
      overrides: [
        sleepDelayTagRepositoryProvider.overrideWithValue(
          InMemorySleepDelayTagRepository(),
        ),
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          TestGoalScheduleSettingsRepository(settings),
        ),
        recentSevenDayEffectiveSleepRecordsProvider.overrideWith(
          (ref) async => const <EffectiveSleepRecord>[],
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

    final state = await container.read(insightsControllerProvider.future);

    expect(state.status, InsightsStatus.empty);
  });

  test('记录达到样本阈值时输出 ready 状态', () async {
    final repository = InMemorySleepDelayTagRepository();
    await repository.saveTags(
      recordDate: DateTime.utc(2026, 5, 20),
      tags: const <String>['刷手机'],
    );
    await repository.saveTags(
      recordDate: DateTime.utc(2026, 5, 21),
      tags: const <String>['加班'],
    );
    final container = ProviderContainer(
      overrides: [
        sleepDelayTagRepositoryProvider.overrideWithValue(repository),
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          TestGoalScheduleSettingsRepository(settings),
        ),
        recentSevenDayEffectiveSleepRecordsProvider.overrideWith(
          (ref) async => <EffectiveSleepRecord>[
            _record('r1', DateTime.utc(2026, 5, 20), DateTime.utc(2026, 5, 20, 23, 50)),
            _record('r2', DateTime.utc(2026, 5, 21), DateTime.utc(2026, 5, 22, 0, 40)),
            _record('r3', DateTime.utc(2026, 5, 22), DateTime.utc(2026, 5, 23, 1, 20)),
          ],
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

    final state = await container.read(insightsControllerProvider.future);

    expect(state.status, InsightsStatus.ready);
    expect(state.weeklyReport, isNotNull);
    expect(state.recoveryPlan, isNotNull);
  });
}

EffectiveSleepRecord _record(String id, DateTime recordDate, DateTime fellAsleepAt) {
  return EffectiveSleepRecord(
    recordId: id,
    recordDate: recordDate,
    fellAsleepAt: fellAsleepAt,
    wokeUpAt: fellAsleepAt.add(const Duration(hours: 8)),
    durationMinutes: 8 * 60,
    source: SleepRecordSource.healthKit,
    confidence: SleepRecordConfidence.high,
    timezone: 'Asia/Shanghai',
    isUserConfirmed: true,
    sourceRecordId: null,
  );
}
