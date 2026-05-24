import '../goal_schedule_settings.dart';

/// 定义目标作息设置读取边界，供今日页和后续统计模块统一依赖。
abstract class GoalScheduleSettingsRepository {
  /// 读取最近一次保存的目标作息设置；若未完成配置则返回空。
  Future<GoalScheduleSettings?> read();

  /// 保存目标作息设置。
  Future<void> save(GoalScheduleSettings settings);
}
