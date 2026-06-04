import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/app/rhythm_app.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/app_shell/application/providers/current_entry_intent_provider.dart';
import 'package:rhythm/features/app_shell/domain/entities/entry_intent.dart';
import 'package:rhythm/features/bedtime/presentation/pages/bedtime_page.dart';
import 'package:rhythm/features/onboarding_activation/presentation/pages/onboarding_flow_page.dart';
import 'package:rhythm/features/profile_settings/presentation/pages/profile_settings_page.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/goal_schedule.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/goal_schedule_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 用可控仓储隔离目标作息状态，确保路由测试只验证 guard 行为。
class _FakeGoalScheduleRepository implements GoalScheduleRepository {
  /// 创建用于测试的作息仓储。
  _FakeGoalScheduleRepository(this._schedule);

  GoalSchedule? _schedule;

  @override
  Future<GoalSchedule?> readActiveSchedule() async => _schedule;

  @override
  Future<void> saveActiveSchedule(GoalSchedule schedule) async {
    _schedule = schedule;
  }
}

/// 验证根路由会在启动 guard 收敛后拦截非法入口。
void main() {
  testWidgets('shell routes redirect back to onboarding when setup is incomplete',
      (tester) async {
    SharedPreferences.setMockInitialValues({'onboarding_completed': false});
    final container = ProviderContainer(
      overrides: [
        goalScheduleRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleRepository(null),
        ),
      ],
    );

    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const RhythmApp(),
      ),
    );
    await tester.pumpAndSettle();

    final router = container.read(appRouterProvider);
    router.go(ProfileSettingsPage.routePath);
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingFlowPage), findsOneWidget);
    expect(find.byType(ProfileSettingsPage), findsNothing);
  });

  testWidgets(
    'shell ready users cannot navigate back to onboarding route',
    (tester) async {
      SharedPreferences.setMockInitialValues({'onboarding_completed': true});
      final container = ProviderContainer(
        overrides: [
          goalScheduleRepositoryProvider.overrideWithValue(
            _FakeGoalScheduleRepository(
              GoalSchedule(
                id: 'fixture',
                bedtimeMinutes: 23 * 60,
                wakeTimeMinutes: 7 * 60,
                createdAt: DateTime(2026, 6, 4),
              ),
            ),
          ),
          currentEntryIntentProvider.overrideWithValue(
            const EntryIntent.notification(target: 'bedtime'),
          ),
        ],
      );

      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const RhythmApp(),
        ),
      );
      await tester.pumpAndSettle();

      final router = container.read(appRouterProvider);
      router.go(OnboardingFlowPage.routePath);
      await tester.pumpAndSettle();

      expect(find.byType(BedtimePage), findsOneWidget);
      expect(find.byType(OnboardingFlowPage), findsNothing);
    },
  );
}
