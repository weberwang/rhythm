import '../domain/manual_sleep_record_form_state.dart';

/// 管理阶段三手动补录草稿，避免页面自己维护跨字段联动与校验。
class ManualSleepRecordController {
  /// 创建手动补录控制器实例。
  ManualSleepRecordController({
    ManualSleepRecordFormState initialState =
        const ManualSleepRecordFormState(),
  }) : _state = initialState;

  ManualSleepRecordFormState _state;

  /// 当前表单状态。
  ManualSleepRecordFormState get state => _state;

  /// 更新入睡时间，并清理旧错误状态。
  void updateSleepTime({required int hour, required int minute}) {
    _state = _state.copyWith(
      sleepHour: hour,
      sleepMinute: minute,
      clearTimeRangeError: true,
    );
  }

  /// 更新起床时间，并清理旧错误状态。
  void updateWakeTime({required int hour, required int minute}) {
    _state = _state.copyWith(
      wakeHour: hour,
      wakeMinute: minute,
      clearTimeRangeError: true,
    );
  }

  /// 提交前统一执行校验，只有通过时才允许继续保存。
  bool submit() {
    _state = _state.validate();
    return _state.timeRangeError == null;
  }
}
