import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/features/app_shell/application/providers/current_entry_intent_provider.dart';
import 'package:rhythm/features/app_shell/domain/entities/entry_intent.dart';
import 'package:rhythm/features/bedtime/application/providers/bedtime_session_repository_provider.dart';
import 'package:rhythm/features/bedtime/application/providers/bedtime_session_controller.dart';
import 'package:rhythm/features/bedtime/domain/entities/bedtime_session_record.dart';
import 'package:rhythm/features/bedtime/domain/repositories/bedtime_session_repository.dart';
import 'package:rhythm/features/bedtime/presentation/pages/bedtime_page.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/goal_schedule.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/goal_schedule_repository.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 用内存作息仓储隔离 bedtime 页面测试，确保只验证显示层和交互。
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

/// 用内存 session 仓储隔离 bedtime 页面测试，避免 widget 测试等待真实本地库。
class _FakeBedtimeSessionRepository implements BedtimeSessionRepository {
  @override
  Future<BedtimeSessionRecord?> readSessionForDate(DateTime sessionDate) async {
    return null;
  }

  @override
  Future<void> saveSession(BedtimeSessionRecord record) async {}
}

/// 验证 bedtime 已从占位页进入真实单任务执行页。
void main() {
  testWidgets('bedtime page shows countdown choices and one primary action', (
    tester,
  ) async {
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
        bedtimeSessionRepositoryProvider.overrideWithValue(
          _FakeBedtimeSessionRepository(),
        ),
        bedtimeNowProvider.overrideWithValue(DateTime(2026, 6, 6, 22, 20)),
      ],
    );
    addTearDown(container.dispose);
    container
        .read(currentEntryIntentProvider.notifier)
        .setIntent(const EntryIntent.homeWidget(target: 'bedtime'));

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const BedtimePage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('睡前'), findsAtLeastNWidgets(1));
    expect(find.text('距离目标还有 40 分钟'), findsOneWidget);
    expect(find.text('今晚先做哪一种判断？'), findsOneWidget);
    expect(find.text('准备睡了'), findsOneWidget);
    expect(find.text('还要一点收尾'), findsOneWidget);
    expect(find.text('初始化占位'), findsNothing);

    await tester.scrollUntilVisible(find.text('今晚大概率会晚睡'), 120);
    await tester.pumpAndSettle();
    expect(find.text('今晚大概率会晚睡'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('开始 10 分钟收尾'), 120);
    await tester.pumpAndSettle();
    expect(find.text('开始 10 分钟收尾'), findsOneWidget);

    await tester.tap(find.text('今晚大概率会晚睡'));
    await tester.pumpAndSettle();

    expect(find.text('先保住明早起床时间'), findsOneWidget);
    expect(find.text('执行这一步'), findsOneWidget);
  });
}
