import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal_schedule_form_state.freezed.dart';

/// 表示目标作息表单的校验错误类型，避免展示层直接依赖硬编码错误文案。
enum GoalScheduleValidationError {
  /// 起床时间与目标入睡时间相同，无法形成有效作息窗口。
  sameAsBedtime,
}

/// 承载首次引导中的目标作息草稿，当前只保留 MVP 需要的核心字段。
@freezed
abstract class GoalScheduleFormState with _$GoalScheduleFormState {
  /// 创建目标作息表单状态实例。
  const factory GoalScheduleFormState({
    @Default(23) int bedtimeHour,
    @Default(30) int bedtimeMinute,
    @Default(7) int wakeHour,
    @Default(30) int wakeMinute,
    @Default(30) int lateThresholdMinutes,
    @Default(4) int dayStartHour,
    @Default(0) int dayStartMinute,
    GoalScheduleValidationError? wakeTimeError,
  }) = _GoalScheduleFormState;
}

/// 目标作息表单校验扩展，集中维护跨字段规则且不污染展示层。
extension GoalScheduleFormStateX on GoalScheduleFormState {
  /// 统一执行跨字段校验，保证提交时的业务规则集中收口。
  GoalScheduleFormState validate() {
    final sameAsBedtime =
        bedtimeHour == wakeHour && bedtimeMinute == wakeMinute;

    return copyWith(
      wakeTimeError: sameAsBedtime
          ? GoalScheduleValidationError.sameAsBedtime
          : null,
    );
  }
}
