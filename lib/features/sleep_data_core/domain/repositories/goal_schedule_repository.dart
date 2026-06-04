import '../entities/goal_schedule.dart';

/// 统一约束目标作息的读取与持久化边界。
abstract class GoalScheduleRepository {
  /// 读取当前激活中的目标作息。
  Future<GoalSchedule?> readActiveSchedule();

  /// 保存当前激活中的目标作息。
  Future<void> saveActiveSchedule(GoalSchedule schedule);
}
