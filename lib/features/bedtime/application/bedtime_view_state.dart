import '../domain/bedtime_action.dart';
import '../domain/bedtime_status.dart';

/// 定义睡前页的页面状态，避免展示层自行拼装空态和数据态。
enum BedtimeViewStatus {
  /// 数据仍在加载中。
  loading,

  /// 页面已有完整可展示数据。
  ready,

  /// 尚未完成目标作息设置。
  goalMissing,

  /// 通知权限缺失，当前只能展示受限状态。
  notificationPermissionMissing,
}

/// 承载睡前页展示层直接消费的聚合状态。
class BedtimeViewState {
  /// 创建睡前页视图状态。
  const BedtimeViewState({
    required this.status,
    this.sessionId,
    this.now,
    this.targetBedtime,
    this.minutesUntilTarget = 0,
    this.progress = 0,
    this.selectedStatus,
    this.recommendedStatus,
    this.actions = const <BedtimeAction>[],
  });

  /// 当前页面状态。
  final BedtimeViewStatus status;

  /// 当前会话主键。
  final String? sessionId;

  /// 当前时间。
  final DateTime? now;

  /// 今晚目标入睡时间。
  final DateTime? targetBedtime;

  /// 距离目标入睡时间的分钟差。
  final int minutesUntilTarget;

  /// 倒计时进度。
  final double progress;

  /// 当前已选择状态。
  final BedtimeStatus? selectedStatus;

  /// 当前推荐状态。
  final BedtimeStatus? recommendedStatus;

  /// 页面当前要展示的动作建议。
  final List<BedtimeAction> actions;
}
