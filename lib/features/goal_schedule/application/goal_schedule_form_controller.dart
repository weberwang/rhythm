import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/goal_schedule_form_state.dart';

part 'goal_schedule_form_controller.g.dart';

/// 管理目标作息表单草稿与提交校验，避免页面直接处理字段联动。
@riverpod
class GoalScheduleFormController extends _$GoalScheduleFormController {
  /// 初始化目标作息表单默认值。
  @override
  GoalScheduleFormState build() {
    return const GoalScheduleFormState();
  }

  /// 更新目标入睡时间，并清理旧校验状态避免误导用户。
  void updateBedtime({required int hour, required int minute}) {
    state = state.copyWith(
      bedtimeHour: hour,
      bedtimeMinute: minute,
      wakeTimeError: null,
    );
  }

  /// 更新目标起床时间，并在后续提交时统一做跨字段校验。
  void updateWakeTime({required int hour, required int minute}) {
    state = state.copyWith(
      wakeHour: hour,
      wakeMinute: minute,
      wakeTimeError: null,
    );
  }

  /// 更新熬夜阈值，保持表单草稿同步。
  void updateLateThreshold(int minutes) {
    state = state.copyWith(
      lateThresholdMinutes: minutes,
      wakeTimeError: null,
    );
  }

  /// 更新一天起始时间，后续统计页可直接复用这一配置字段。
  void updateDayStart({required int hour, required int minute}) {
    state = state.copyWith(
      dayStartHour: hour,
      dayStartMinute: minute,
      wakeTimeError: null,
    );
  }

  /// 提交前统一执行校验，只有通过时才允许路由推进到下一步。
  bool submit() {
    final validated = state.validate();
    state = validated;
    return validated.wakeTimeError == null;
  }
}
