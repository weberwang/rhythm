import 'package:freezed_annotation/freezed_annotation.dart';

part 'today_snapshot.freezed.dart';

/// 描述昨晚结果卡的主状态，确保 today 首屏对“昨晚怎么样”给出单一解释。
enum TodayLastNightStatus {
  /// 当前还没有首晚结果，页面应引导用户先完成一晚记录。
  noData,

  /// 昨晚基本贴近目标作息，首页应给出克制的正向反馈。
  onTarget,

  /// 昨晚有轻微偏移，首页需要提示但不应制造失败感。
  slightDelay,

  /// 昨晚偏移明显，恢复建议必须进入主路径。
  majorDelay,

  /// 同步暂时失败，但本地数据仍安全，页面应把修复放在次级动作里。
  syncRecoverable,

  /// 结果已被手动修正，需要显式解释来源变化。
  manualAdjusted,
}

/// 描述恢复建议卡的主语义，避免页面自己临时拼装不同优先级。
enum TodayRecoveryStatus {
  /// 当前先建立首晚样本，不急着给复杂恢复动作。
  buildBaseline,

  /// 当前优先保持本地节奏，再让用户稍后处理同步问题。
  syncRecoveryFirst,

  /// 当前已经出现明显偏移，首页应优先给出恢复节奏建议。
  recoverAfterDelay,

  /// 当前已具备基础结果，只需给出轻量延续建议。
  protectMomentum,
}

/// 描述快捷记录入口的当前姿态，供页面区分推荐入口与普通入口。
enum TodayQuickRecordStatus {
  /// 当前建议用户补一条快速记录，帮助形成今晚上下文。
  recommended,

  /// 当前入口只作为补充动作展示。
  optional,
}

/// 描述趋势区块当前是否已具备可解释样本。
enum TodayTrendStatus {
  /// 首周样本仍在建立中，趋势区块应以解释为主。
  building,

  /// 趋势已可解释，可以展示更完整的变化摘要。
  ready,
}

/// 定义 today 首页需要的一次性聚合快照，供显示层一次消费。
@freezed
abstract class TodaySnapshot with _$TodaySnapshot {
  /// 创建 today 首页快照。
  const factory TodaySnapshot({
    String? displayName,
    required TodayLastNightSummary lastNight,
    required TodayTonightGoalSummary tonightGoal,
    required TodayRecoverySummary recovery,
    required TodayQuickRecordSummary quickRecord,
    required TodayTrendSummary trend,
  }) = _TodaySnapshot;
}

/// 描述昨晚结果卡所需的最小摘要。
@freezed
abstract class TodayLastNightSummary with _$TodayLastNightSummary {
  /// 创建昨晚结果摘要。
  const factory TodayLastNightSummary({
    required TodayLastNightStatus status,
    required String scoreLabel,
    required String primaryMetricLabel,
    required String primaryMetricValue,
    required String secondaryMetricLabel,
    required String secondaryMetricValue,
    required String tertiaryMetricLabel,
    required String tertiaryMetricValue,
  }) = _TodayLastNightSummary;
}

/// 描述今晚目标卡所需的最小摘要。
@freezed
abstract class TodayTonightGoalSummary with _$TodayTonightGoalSummary {
  /// 创建今晚目标摘要。
  const factory TodayTonightGoalSummary({
    required int bedtimeMinutes,
    required int wakeTimeMinutes,
    required int windDownMinutes,
    required String bedtimeLabel,
    required String wakeTimeLabel,
    required String windDownLabel,
  }) = _TodayTonightGoalSummary;
}

/// 描述恢复建议卡所需的最小摘要。
@freezed
abstract class TodayRecoverySummary with _$TodayRecoverySummary {
  /// 创建恢复建议摘要。
  const factory TodayRecoverySummary({required TodayRecoveryStatus status}) =
      _TodayRecoverySummary;
}

/// 描述快捷记录卡所需的最小摘要。
@freezed
abstract class TodayQuickRecordSummary with _$TodayQuickRecordSummary {
  /// 创建快捷记录摘要。
  const factory TodayQuickRecordSummary({
    required TodayQuickRecordStatus status,
  }) = _TodayQuickRecordSummary;
}

/// 描述趋势区块所需的最小摘要。
@freezed
abstract class TodayTrendSummary with _$TodayTrendSummary {
  /// 创建趋势摘要。
  const factory TodayTrendSummary({
    required TodayTrendStatus status,
    required List<TodayTrendPoint> points,
    required int? averageScore,
  }) = _TodayTrendSummary;
}

/// 描述趋势图单点所需的最小摘要。
@freezed
abstract class TodayTrendPoint with _$TodayTrendPoint {
  /// 创建趋势点摘要。
  const factory TodayTrendPoint({
    required String dayLabel,
    required int score,
  }) = _TodayTrendPoint;
}
