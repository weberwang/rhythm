import 'package:drift/drift.dart';

import '../../../../core/storage/rhythm_database.dart';
import '../../domain/entities/goal_schedule.dart';
import '../../domain/repositories/goal_schedule_repository.dart';

/// 基于 Drift 提供目标作息本地仓储，实现 Stage 1 的真实持久化基线。
class LocalGoalScheduleRepository implements GoalScheduleRepository {
  /// 创建本地仓储实现。
  LocalGoalScheduleRepository(this._database);

  final RhythmDatabase _database;

  @override
  Future<GoalSchedule?> readActiveSchedule() async {
    final query = _database.select(_database.goalScheduleEntries)
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)])
      ..limit(1);

    final row = await query.getSingleOrNull();
    if (row == null) {
      return null;
    }

    return GoalSchedule(
      id: row.id.toString(),
      bedtimeMinutes: row.bedtimeMinutes,
      wakeTimeMinutes: row.wakeTimeMinutes,
      createdAt: row.createdAt,
    );
  }

  @override
  Future<void> saveActiveSchedule(GoalSchedule schedule) async {
    final existing =
        await (_database.select(_database.goalScheduleEntries)
              ..orderBy([(table) => OrderingTerm.desc(table.createdAt)])
              ..limit(1))
            .getSingleOrNull();

    // 当前 schema 只承载一个激活作息，因此优先复用现有行，避免在 Stage 1
    // 就引入额外迁移或“多条激活记录”语义分叉。
    if (existing != null) {
      await (_database.update(
        _database.goalScheduleEntries,
      )..where((table) => table.id.equals(existing.id))).write(
        GoalScheduleEntriesCompanion(
          bedtimeMinutes: Value(schedule.bedtimeMinutes),
          wakeTimeMinutes: Value(schedule.wakeTimeMinutes),
          createdAt: Value(schedule.createdAt),
        ),
      );
      return;
    }

    await _database
        .into(_database.goalScheduleEntries)
        .insert(
          GoalScheduleEntriesCompanion.insert(
            bedtimeMinutes: schedule.bedtimeMinutes,
            wakeTimeMinutes: schedule.wakeTimeMinutes,
            createdAt: schedule.createdAt,
          ),
        );
  }
}
