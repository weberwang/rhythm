import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/effective_sleep_record_repository.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/sleep_record_repository.dart';

/// 验证阶段三已建立睡眠记录仓储边界，避免后续页面直接依赖底层实现。
void main() {
  test('睡眠记录仓储接口可被实例化为契约类型', () {
    SleepRecordRepository? repository;
    EffectiveSleepRecordRepository? effectiveRepository;

    expect(repository, isNull);
    expect(effectiveRepository, isNull);
  });
}
