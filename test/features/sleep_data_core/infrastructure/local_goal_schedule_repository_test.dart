import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/storage/rhythm_database.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/goal_schedule.dart';
import 'package:rhythm/features/sleep_data_core/infrastructure/repositories/local_goal_schedule_repository.dart';

/// 验证目标作息仓储已经真正接入 Drift，而不是继续返回伪造默认值。
void main() {
  test(
    'LocalGoalScheduleRepository persists and reloads active schedule',
    () async {
      final database = RhythmDatabase.forTesting(NativeDatabase.memory());
      final repository = LocalGoalScheduleRepository(database);
      final schedule = GoalSchedule(
        id: 'fixture',
        bedtimeMinutes: 22 * 60 + 30,
        wakeTimeMinutes: 6 * 60 + 45,
        createdAt: DateTime(2026, 6, 4, 21),
      );

      addTearDown(database.close);

      expect(await repository.readActiveSchedule(), isNull);

      await repository.saveActiveSchedule(schedule);
      final restored = await repository.readActiveSchedule();

      expect(restored, isNotNull);
      expect(restored!.bedtimeMinutes, schedule.bedtimeMinutes);
      expect(restored.wakeTimeMinutes, schedule.wakeTimeMinutes);
      expect(restored.createdAt, schedule.createdAt);
    },
  );
}
