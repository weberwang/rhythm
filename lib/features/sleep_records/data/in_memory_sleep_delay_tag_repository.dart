import 'package:rhythm/features/sleep_records/domain/repositories/sleep_delay_tag_repository.dart';

/// 提供阶段六开发期使用的内存标签仓储，先锁住交互和测试闭环。
class InMemorySleepDelayTagRepository implements SleepDelayTagRepository {
  final Map<DateTime, List<String>> _tagsByDate = <DateTime, List<String>>{};

  @override
  Future<List<String>> readTags({
    required DateTime recordDate,
  }) async {
    return List<String>.from(_tagsByDate[_normalize(recordDate)] ?? const <String>[]);
  }

  @override
  Future<void> saveTags({
    required DateTime recordDate,
    required List<String> tags,
  }) async {
    _tagsByDate[_normalize(recordDate)] = List<String>.from(tags);
  }

  DateTime _normalize(DateTime value) {
    return DateTime.utc(value.year, value.month, value.day);
  }
}
