import '../domain/today_summary.dart';

/// 定义今日页的页面状态，避免展示层自行拼空判断。
enum TodayViewStatus {
  /// 数据仍在加载中。
  loading,

  /// 页面已有完整可展示数据。
  ready,

  /// 缺少昨晚记录，需要引导补录。
  empty,

  /// 权限或平台状态导致当前只能先看权限说明。
  permissionFailed,

  /// 尚未完成目标作息设置。
  goalMissing,
}

/// 承载今日页展示层直接消费的聚合状态。
class TodayViewState {
  /// 创建今日页视图状态实例。
  const TodayViewState({
    required this.status,
    required this.prioritizeRecoveryCard,
    this.summary,
  });

  /// 当前页面状态。
  final TodayViewStatus status;

  /// 是否需要在首屏优先展示恢复建议卡。
  final bool prioritizeRecoveryCard;

  /// 今日页领域摘要；部分空态下可以为空。
  final TodaySummary? summary;
}
