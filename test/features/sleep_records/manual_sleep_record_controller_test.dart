import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sleep_records/application/manual_sleep_record_controller.dart';
import 'package:rhythm/features/sleep_records/domain/manual_sleep_record_form_state.dart';

/// 验证手动补录控制器会维护草稿和提交校验。
void main() {
  test('更新入睡时间后草稿同步变化', () {
    final controller = ManualSleepRecordController();

    controller.updateSleepTime(hour: 22, minute: 45);

    expect(controller.state.sleepHour, 22);
    expect(controller.state.sleepMinute, 45);
  });

  test('提交时遇到相同起止时间返回失败并写入错误状态', () {
    final controller = ManualSleepRecordController(
      initialState: const ManualSleepRecordFormState(
        sleepHour: 23,
        sleepMinute: 30,
        wakeHour: 23,
        wakeMinute: 30,
      ),
    );

    final success = controller.submit();

    expect(success, isFalse);
    expect(
      controller.state.timeRangeError,
      ManualSleepRecordValidationError.sameSleepAndWakeTime,
    );
  });

  test('更新起床时间后草稿同步变化', () {
    final controller = ManualSleepRecordController();

    controller.updateWakeTime(hour: 8, minute: 5);

    expect(controller.state.wakeHour, 8);
    expect(controller.state.wakeMinute, 5);
  });
}
