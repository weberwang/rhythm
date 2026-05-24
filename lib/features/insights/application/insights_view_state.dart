import 'package:rhythm/features/insights/domain/recovery_plan.dart';
import 'package:rhythm/features/insights/domain/stability_score_rules.dart';
import 'package:rhythm/features/insights/domain/weekly_report.dart';

/// 定义洞察页聚合状态，避免页面层散落样本和规则判断。
enum InsightsStatus {
  /// 仍在加载。
  loading,

  /// 数据不足，展示空态或轻提示。
  empty,

  /// 已准备好首页和详情页可消费的数据。
  ready,
}

/// 洞察页、详情页和历史页共享的显示层状态。
class InsightsViewState {
  /// 创建洞察状态实例。
  const InsightsViewState({
    required this.status,
    this.weeklyReport,
    this.stabilityScore,
    this.recoveryPlan,
    this.history = const <WeeklyReport>[],
  });

  /// 当前状态。
  final InsightsStatus status;

  /// 当前一周正式周报。
  final WeeklyReport? weeklyReport;

  /// 首页稳定度摘要。
  final StabilityScore? stabilityScore;

  /// 恢复计划详情。
  final RecoveryPlan? recoveryPlan;

  /// 历史周报列表，按时间倒序。
  final List<WeeklyReport> history;
}
