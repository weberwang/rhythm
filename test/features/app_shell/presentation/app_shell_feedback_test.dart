import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/app/rhythm_app.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/sleep_data_core_status_provider.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/goal_schedule.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/sleep_data_core_status.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/goal_schedule_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 用假仓储固定主壳进入条件，避免反馈层测试依赖真实持久化。
class _FakeGoalScheduleRepository implements GoalScheduleRepository {
  /// 创建测试仓储。
  _FakeGoalScheduleRepository(this._schedule);

  GoalSchedule? _schedule;

  @override
  Future<GoalSchedule?> readActiveSchedule() async => _schedule;

  @override
  Future<void> saveActiveSchedule(GoalSchedule schedule) async {
    _schedule = schedule;
  }
}

/// 验证主壳会把共享同步异常挂到全局反馈层。
void main() {
  testWidgets('app shell shows sync failure feedback banner', (tester) async {
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
        sleepSyncStatusProvider.overrideWithValue(
          SleepSyncStatus.failedRecoverable,
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

    expect(find.text('Sync paused locally'), findsOneWidget);
    expect(
      find.text(
        'Your recent updates are still stored on this device. Review sync settings when you are ready.',
      ),
      findsOneWidget,
    );
  });
}
