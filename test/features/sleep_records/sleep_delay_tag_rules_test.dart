import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_rules.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_validation_error.dart';

/// 验证阶段六晚睡原因标签规则。
void main() {
  test('默认标签固定为八个轻量标签', () {
    expect(SleepDelayTagRules.defaultTags.length, 8);
    expect(
      SleepDelayTagRules.defaultTags.map((tag) => tag.name).toList(),
      ['刷手机', '加班', '游戏', '追剧', '情绪', '聚会', '时差', '其他'],
    );
  });

  test('自定义标签会去除首尾空白', () {
    final result = SleepDelayTagRules.validateCustomTag('  临时项目  ');

    expect(result, '临时项目');
  });

  test('自定义标签不能为空', () {
    expect(
      () => SleepDelayTagRules.validateCustomTag('   '),
      throwsA(
        isA<SleepDelayTagValidationException>().having(
          (error) => error.error,
          'error',
          SleepDelayTagValidationError.empty,
        ),
      ),
    );
  });

  test('自定义标签不能与默认标签重复', () {
    expect(
      () => SleepDelayTagRules.validateCustomTag('刷手机'),
      throwsA(
        isA<SleepDelayTagValidationException>().having(
          (error) => error.error,
          'error',
          SleepDelayTagValidationError.duplicateDefault,
        ),
      ),
    );
  });
}
