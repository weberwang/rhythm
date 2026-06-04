import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal_schedule.freezed.dart';
part 'goal_schedule.g.dart';

/// 目标作息是所有核心体验共享的最小业务实体。
@freezed
abstract class GoalSchedule with _$GoalSchedule {
  /// 创建目标作息实体。
  const factory GoalSchedule({
    required String id,
    required int bedtimeMinutes,
    required int wakeTimeMinutes,
    required DateTime createdAt,
  }) = _GoalSchedule;

  /// 从 JSON 恢复实体，便于后续缓存、同步和测试夹具复用。
  factory GoalSchedule.fromJson(Map<String, dynamic> json) =>
      _$GoalScheduleFromJson(json);
}
