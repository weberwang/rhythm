/// 表示手动补录表单的校验错误类型。
enum ManualSleepRecordValidationError {
  /// 起床时间与入睡时间相同，无法形成有效睡眠区间。
  sameSleepAndWakeTime,
}

/// 承载阶段三手动补录表单状态，避免页面直接维护跨字段规则。
class ManualSleepRecordFormState {
  /// 创建手动补录表单状态实例。
  const ManualSleepRecordFormState({
    this.sleepHour = 23,
    this.sleepMinute = 30,
    this.wakeHour = 7,
    this.wakeMinute = 30,
    this.isEditing = false,
    this.timeRangeError,
  });

  /// 入睡小时。
  final int sleepHour;

  /// 入睡分钟。
  final int sleepMinute;

  /// 起床小时。
  final int wakeHour;

  /// 起床分钟。
  final int wakeMinute;

  /// 当前是否处于编辑既有记录场景。
  final bool isEditing;

  /// 表单时间范围错误。
  final ManualSleepRecordValidationError? timeRangeError;

  /// 返回带有更新字段的新状态。
  ManualSleepRecordFormState copyWith({
    int? sleepHour,
    int? sleepMinute,
    int? wakeHour,
    int? wakeMinute,
    bool? isEditing,
    ManualSleepRecordValidationError? timeRangeError,
    bool clearTimeRangeError = false,
  }) {
    return ManualSleepRecordFormState(
      sleepHour: sleepHour ?? this.sleepHour,
      sleepMinute: sleepMinute ?? this.sleepMinute,
      wakeHour: wakeHour ?? this.wakeHour,
      wakeMinute: wakeMinute ?? this.wakeMinute,
      isEditing: isEditing ?? this.isEditing,
      timeRangeError: clearTimeRangeError
          ? null
          : timeRangeError ?? this.timeRangeError,
    );
  }

  /// 统一执行跨字段校验，保证页面不会散落表单规则。
  ManualSleepRecordFormState validate() {
    final hasSameTime =
        sleepHour == wakeHour && sleepMinute == wakeMinute;
    return copyWith(
      timeRangeError: hasSameTime
          ? ManualSleepRecordValidationError.sameSleepAndWakeTime
          : null,
      clearTimeRangeError: !hasSameTime,
    );
  }
}
