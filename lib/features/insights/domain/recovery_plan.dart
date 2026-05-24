/// 表示恢复计划的当前执行状态。
enum RecoveryPlanStatus {
  /// 尚未查看详情。
  unread,

  /// 已查看但未执行完成。
  viewed,

  /// 已按计划执行完成。
  completed,

  /// 用户选择延后处理。
  snoozed,
}

/// 表示 1 到 3 天恢复计划。
class RecoveryPlan {
  /// 创建恢复计划。
  const RecoveryPlan({
    required this.status,
    required this.horizonDays,
    required this.triggerOffsetMinutes,
    required this.steps,
  });

  /// 计划状态。
  final RecoveryPlanStatus status;

  /// 计划覆盖天数，限制为 1 到 3。
  final int horizonDays;

  /// 触发本次计划的晚睡偏差分钟数。
  final int triggerOffsetMinutes;

  /// 计划步骤，最多 3 天。
  final List<RecoveryPlanStep> steps;
}

/// 定义恢复计划步骤类型，供显示层映射为最终文案。
enum RecoveryPlanStepType {
  /// 更早结束工作或娱乐收尾。
  closeWorkEarlier,

  /// 降低睡前干扰，缩短拖延缓冲。
  reduceNightNoise,

  /// 回看触发原因并确认是否回到阈值内。
  reviewLateTriggers,
}

/// 表示恢复计划中的单日行动步骤。
class RecoveryPlanStep {
  /// 创建恢复计划步骤。
  const RecoveryPlanStep({
    required this.dayIndex,
    required this.type,
  });

  /// 第几天，从 1 开始。
  final int dayIndex;

  /// 步骤类型。
  final RecoveryPlanStepType type;
}
