import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/time/time_context.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/calendar/application/calendar_controller.dart';
import 'package:rhythm/features/calendar/application/calendar_view_state.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_mood.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/domain/calendar_heat_level.dart';
import 'package:rhythm/features/calendar/domain/calendar_month_summary.dart';
import 'package:rhythm/features/calendar/presentation/calendar_page.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/sleep_records/application/effective_sleep_record_provider.dart';
import 'package:rhythm/features/sleep_records/application/sleep_delay_tag_providers.dart';
import 'package:rhythm/features/sleep_records/data/in_memory_sleep_delay_tag_repository.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_rules.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../support/sleep_records_test_doubles.dart';

/// 验证日历页的最小交互链路：打开详情，再进入标签选择。
void main() {
  const settings = GoalScheduleSettings(
    targetBedtimeMinutes: 23 * 60 + 30,
    targetWakeMinutes: 7 * 60 + 30,
    lateThresholdMinutes: 30,
    dayStartMinutes: 4 * 60,
  );

  testWidgets('点击日期后打开详情，再进入标签弹层', (tester) async {
    final repository = InMemorySleepDelayTagRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
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

    expect(find.text('5 月 24 日'), findsOneWidget);
    expect(find.text('添加标签'), findsOneWidget);

    await tester.tap(find.text('添加标签'));
    await tester.pumpAndSettle();

    expect(find.text('补一个晚睡原因'), findsOneWidget);
    expect(find.text('刷手机'), findsOneWidget);

    await tester.tap(find.text('刷手机').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存标签'));
    await tester.pumpAndSettle();

    expect(await repository.readTags(recordDate: DateTime.utc(2026, 5, 24)), [
      '刷手机',
    ]);
  });

  testWidgets('保存标签后日历页仍保持 pen 的纯日期格显示', (tester) async {
    final repository = InMemorySleepDelayTagRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sleepDelayTagRepositoryProvider.overrideWithValue(repository),
          goalScheduleSettingsRepositoryProvider.overrideWithValue(
            TestGoalScheduleSettingsRepository(settings),
          ),
          recentThirtyDayEffectiveSleepRecordsProvider.overrideWith(
            (ref) async => <EffectiveSleepRecord>[
              _buildRecord(
                id: 'r24',
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
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: CalendarPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('calendar-mood-paper-24')), findsNothing);

    await tester.ensureVisible(find.text('24').first);
    await tester.tap(find.text('24').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('添加标签'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('刷手机').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存标签'));
    await tester.pumpAndSettle();

    expect(await repository.readTags(recordDate: DateTime.utc(2026, 5, 24)), [
      '刷手机',
    ]);
    expect(find.byKey(const Key('calendar-mood-paper-24')), findsNothing);
  });

  testWidgets('保存标签后不会回到整页加载态', (tester) async {
    final repository = InMemorySleepDelayTagRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sleepDelayTagRepositoryProvider.overrideWithValue(repository),
          goalScheduleSettingsRepositoryProvider.overrideWithValue(
            TestGoalScheduleSettingsRepository(settings),
          ),
          recentThirtyDayEffectiveSleepRecordsProvider.overrideWith(
            (ref) async => <EffectiveSleepRecord>[
              _buildRecord(
                id: 'r24',
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
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('颜色不是坏消息，而是你与目标时间的距离。'), findsOneWidget);
  });

  testWidgets('自定义标签输入无效时在真实交互链路里展示错误', (tester) async {
    final repository = InMemorySleepDelayTagRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
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
    await tester.tap(find.text('自定义标签'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '   ');
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存自定义标签'));
    await tester.pumpAndSettle();

    expect(find.text('请输入原因标签'), findsOneWidget);
    expect(
      await repository.readTags(recordDate: DateTime.utc(2026, 5, 24)),
      isEmpty,
    );
  });
}

/// 构造带入睡时间的测试记录，用于验证标签保存后的日历状态重算。
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

/// 构造已加载完成的日历状态，让交互测试聚焦页面行为。
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

/// 提供固定日历状态的测试控制器，避免页面基础交互依赖真实加载链路。
class _FakeCalendarController extends CalendarController {
  /// 使用固定状态初始化测试控制器。
  _FakeCalendarController(this._state);

  final CalendarViewState _state;

  /// 返回预设状态，便于稳定验证页面点击和弹层交互。
  @override
  Future<CalendarViewState> build() async {
    return _state;
  }

  /// 测试替身不需要重载数据，只保留页面调用入口。
  @override
  Future<void> reload() async {}
}
