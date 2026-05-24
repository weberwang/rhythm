import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sleep_records/domain/manual_sleep_record_form_state.dart';

/// 验证手动补录表单的默认状态和基础校验。
void main() {
  test('起床时间与入睡时间相同时返回表单错误', () {
    const state = ManualSleepRecordFormState(
      sleepHour: 23,
      sleepMinute: 30,
      wakeHour: 23,
      wakeMinute: 30,
    );

    expect(
      state.validate().timeRangeError,
      ManualSleepRecordValidationError.sameSleepAndWakeTime,
    );
  });

  test('默认手动补录表单提供阶段三初始值', () {
    const state = ManualSleepRecordFormState();

    expect(state.sleepHour, 23);
    expect(state.sleepMinute, 30);
    expect(state.wakeHour, 7);
    expect(state.wakeMinute, 30);
    expect(state.isEditing, isFalse);
  });
}
