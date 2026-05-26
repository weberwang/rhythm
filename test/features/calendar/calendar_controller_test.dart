import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/time/time_context.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/calendar/application/calendar_controller.dart';
import 'package:rhythm/features/calendar/application/calendar_view_state.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_mood.dart';
import 'package:rhythm/features/calendar/domain/calendar_filter.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/sleep_records/application/effective_sleep_record_provider.dart';
import 'package:rhythm/features/sleep_records/application/sleep_delay_tag_providers.dart';
import 'package:rhythm/features/sleep_records/data/in_memory_sleep_delay_tag_repository.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_rules.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';

import '../../support/sleep_records_test_doubles.dart';

/// 验证阶段六日历控制器会聚合目标作息、有效记录和热力摘要。
void main() {
  const settings = GoalScheduleSettings(
    targetBedtimeMinutes: 23 * 60 + 30,
    targetWakeMinutes: 7 * 60 + 30,
    lateThresholdMinutes: 30,
    dayStartMinutes: 4 * 60,
  );

  test('有记录时输出月份摘要和热力日列表', () async {
    final container = ProviderContainer(
      overrides: [
        sleepDelayTagRepositoryProvider.overrideWithValue(
          InMemorySleepDelayTagRepository(),
        ),
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          TestGoalScheduleSettingsRepository(settings),
        ),
        recentThirtyDayEffectiveSleepRecordsProvider.overrideWith(
          (ref) async => <EffectiveSleepRecord>[
            _buildRecord(
              id: 'r1',
              recordDate: DateTime.utc(2026, 5, 1),
              fellAsleepAt: DateTime.utc(2026, 5, 1, 23, 45),
            ),
            _buildRecord(
              id: 'r2',
              recordDate: DateTime.utc(2026, 5, 4),
              fellAsleepAt: DateTime.utc(2026, 5, 5, 0, 40),
            ),
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

    final state = await container.read(calendarControllerProvider.future);

    expect(state.status, CalendarViewStatus.ready);
    expect(state.monthSummary, isNotNull);
    expect(state.monthSummary!.recordedDays, 2);
    expect(state.monthSummary!.days.length, 31);
  });

  test('缺少目标作息时输出 goalMissing 状态', () async {
    final container = ProviderContainer(
      overrides: [
        sleepDelayTagRepositoryProvider.overrideWithValue(
          InMemorySleepDelayTagRepository(),
        ),
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          TestGoalScheduleSettingsRepository(null),
        ),
        recentThirtyDayEffectiveSleepRecordsProvider.overrideWith(
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

    final state = await container.read(calendarControllerProvider.future);

    expect(state.status, CalendarViewStatus.goalMissing);
  });

  test('无记录时月份摘要仍会生成完整日期网格', () async {
    final container = ProviderContainer(
      overrides: [
        sleepDelayTagRepositoryProvider.overrideWithValue(
          InMemorySleepDelayTagRepository(),
        ),
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          TestGoalScheduleSettingsRepository(settings),
        ),
        recentThirtyDayEffectiveSleepRecordsProvider.overrideWith(
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

    final state = await container.read(calendarControllerProvider.future);

    expect(state.status, CalendarViewStatus.ready);
    expect(state.monthSummary, isNotNull);
    expect(state.monthSummary!.recordedDays, 0);
    expect(
      state.availableTags.map((tag) => tag.name).toList(),
      SleepDelayTagRules.defaultTags.map((tag) => tag.name).toList(),
    );
  });

  test('控制器会把已保存标签合并进对应日期摘要', () async {
    final repository = InMemorySleepDelayTagRepository();
    await repository.saveTags(
      recordDate: DateTime.utc(2026, 5, 24),
      tags: const <String>['刷手机'],
    );
    final container = ProviderContainer(
      overrides: [
        sleepDelayTagRepositoryProvider.overrideWithValue(repository),
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          TestGoalScheduleSettingsRepository(settings),
        ),
        recentThirtyDayEffectiveSleepRecordsProvider.overrideWith(
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

    final state = await container.read(calendarControllerProvider.future);
    final day = state.monthSummary!.days.firstWhere(
      (item) => item.date == DateTime.utc(2026, 5, 24),
    );

    expect(day.tags, ['刷手机']);
  });

  test('控制器会把已保存标签映射成主情绪和叠层标记', () async {
    final repository = InMemorySleepDelayTagRepository();
    await repository.saveTags(
      recordDate: DateTime.utc(2026, 5, 24),
      tags: const <String>['加班', '游戏'],
    );
    final container = ProviderContainer(
      overrides: [
        sleepDelayTagRepositoryProvider.overrideWithValue(repository),
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          TestGoalScheduleSettingsRepository(settings),
        ),
        recentThirtyDayEffectiveSleepRecordsProvider.overrideWith(
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

    final state = await container.read(calendarControllerProvider.future);
    final day = state.monthSummary!.days.firstWhere(
      (item) => item.date == DateTime.utc(2026, 5, 24),
    );

    expect(day.primaryMood, CalendarDayMood.restless);
    expect(day.hasSecondaryMood, isTrue);
  });

  test('应用仅看有记录筛选后只保留有记录日期', () async {
    final container = ProviderContainer(
      overrides: [
        sleepDelayTagRepositoryProvider.overrideWithValue(
          InMemorySleepDelayTagRepository(),
        ),
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          TestGoalScheduleSettingsRepository(settings),
        ),
        recentThirtyDayEffectiveSleepRecordsProvider.overrideWith(
          (ref) async => <EffectiveSleepRecord>[
            _buildRecord(
              id: 'r1',
              recordDate: DateTime.utc(2026, 5, 4),
              fellAsleepAt: DateTime.utc(2026, 5, 5, 0, 40),
            ),
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

    final controller = container.read(calendarControllerProvider.notifier);
    controller.updateFilter(const CalendarFilter(onlyRecordedDays: true));
    final state = await container.read(calendarControllerProvider.future);

    expect(state.activeFilter.onlyRecordedDays, isTrue);
    expect(state.monthSummary!.days.where((day) => day.hasRecord), isNotEmpty);
  });

  test('应用仅看晚睡筛选后只保留晚睡日期', () async {
    final container = ProviderContainer(
      overrides: [
        sleepDelayTagRepositoryProvider.overrideWithValue(
          InMemorySleepDelayTagRepository(),
        ),
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          TestGoalScheduleSettingsRepository(settings),
        ),
        recentThirtyDayEffectiveSleepRecordsProvider.overrideWith(
          (ref) async => <EffectiveSleepRecord>[
            _buildRecord(
              id: 'on-time',
              recordDate: DateTime.utc(2026, 5, 2),
              fellAsleepAt: DateTime.utc(2026, 5, 2, 23, 40),
            ),
            _buildRecord(
              id: 'late',
              recordDate: DateTime.utc(2026, 5, 4),
              fellAsleepAt: DateTime.utc(2026, 5, 5, 0, 40),
            ),
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

    final controller = container.read(calendarControllerProvider.notifier);
    await controller.updateFilter(const CalendarFilter(lateOnly: true));
    final state = await container.read(calendarControllerProvider.future);

    expect(state.activeFilter.lateOnly, isTrue);
    expect(state.monthSummary!.days, isNotEmpty);
    expect(state.monthSummary!.days.every((day) => day.isLate), isTrue);
  });

  test('保存标签后仅局部回写状态且不会先进入 loading', () async {
    final repository = InMemorySleepDelayTagRepository();
    final container = ProviderContainer(
      overrides: [
        sleepDelayTagRepositoryProvider.overrideWithValue(repository),
        goalScheduleSettingsRepositoryProvider.overrideWithValue(
          TestGoalScheduleSettingsRepository(settings),
        ),
        recentThirtyDayEffectiveSleepRecordsProvider.overrideWith(
          (ref) async => <EffectiveSleepRecord>[
            _buildRecord(
              id: 'late',
              recordDate: DateTime.utc(2026, 5, 24),
              fellAsleepAt: DateTime.utc(2026, 5, 25, 0, 20),
            ),
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

    await container.read(calendarControllerProvider.future);
    final transitions = <AsyncValue<CalendarViewState>>[];
    final subscription = container.listen<AsyncValue<CalendarViewState>>(
      calendarControllerProvider,
      (previous, next) {
        transitions.add(next);
      },
      fireImmediately: false,
    );
    addTearDown(subscription.close);

    await repository.saveTags(
      recordDate: DateTime.utc(2026, 5, 24),
      tags: const <String>['刷手机'],
    );
    await container
        .read(calendarControllerProvider.notifier)
        .refreshDayTags(DateTime.utc(2026, 5, 24));

    final state = await container.read(calendarControllerProvider.future);
    final day = state.monthSummary!.days.firstWhere(
      (item) => item.date == DateTime.utc(2026, 5, 24),
    );

    expect(
      transitions.any((value) => value is AsyncLoading<CalendarViewState>),
      isFalse,
    );
    expect(day.tags, ['刷手机']);
    expect(day.primaryMood, CalendarDayMood.drained);
  });
}

/// 构造日历控制器测试用有效记录。
EffectiveSleepRecord _buildRecord({
  required String id,
  required DateTime recordDate,
  required DateTime fellAsleepAt,
}) {
  return EffectiveSleepRecord(
    recordId: id,
    recordDate: recordDate,
    fellAsleepAt: fellAsleepAt,
    wokeUpAt: fellAsleepAt.add(const Duration(hours: 8)),
    durationMinutes: 8 * 60,
    source: SleepRecordSource.healthKit,
    confidence: SleepRecordConfidence.high,
    timezone: 'Asia/Shanghai',
    isUserConfirmed: false,
    sourceRecordId: null,
  );
}
