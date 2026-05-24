import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/features/sleep_records/application/sleep_delay_tag_providers.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_delay_tag_rules.dart';

/// 提供原因标签控制器，统一收口默认标签与自定义标签保存。
final sleepDelayTagControllerProvider =
    Provider<SleepDelayTagController>((ref) {
  return SleepDelayTagController(ref);
});

/// 承接标签读取、保存和自定义标签校验逻辑。
class SleepDelayTagController {
  /// 创建标签控制器。
  SleepDelayTagController(this._ref);

  final Ref _ref;

  /// 读取指定日期已保存的标签。
  Future<List<String>> loadTags({
    required DateTime recordDate,
  }) {
    return _ref.read(sleepDelayTagRepositoryProvider).readTags(
          recordDate: recordDate,
        );
  }

  /// 保存标签集合。
  Future<void> saveTags({
    required DateTime recordDate,
    required List<String> tags,
  }) {
    return _ref.read(sleepDelayTagRepositoryProvider).saveTags(
          recordDate: recordDate,
          tags: tags,
        );
  }

  /// 保存自定义标签，并在保存前执行规范化与校验。
  Future<void> saveCustomTag({
    required DateTime recordDate,
    required String input,
  }) async {
    final normalized = SleepDelayTagRules.validateCustomTag(input);
    await saveTags(recordDate: recordDate, tags: <String>[normalized]);
  }
}
