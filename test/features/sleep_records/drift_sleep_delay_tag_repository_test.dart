import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/data/local/rhythm_database.dart';
import 'package:rhythm/features/sleep_records/data/drift_sleep_delay_tag_repository.dart';

/// 验证基于数据库的晚睡原因标签仓储会按日期持久化。
void main() {
  late RhythmDatabase database;
  late DriftSleepDelayTagRepository repository;

  setUp(() {
    database = RhythmDatabase.inMemory();
    repository = DriftSleepDelayTagRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('保存后可重新读取对应日期标签', () async {
    await repository.saveTags(
      recordDate: DateTime.utc(2026, 5, 24),
      tags: const <String>['刷手机', '加班'],
    );

    final tags = await repository.readTags(
      recordDate: DateTime.utc(2026, 5, 24),
    );

    expect(tags, ['刷手机', '加班']);
  });

  test('同一天不同时区时间会命中同一份标签', () async {
    await repository.saveTags(
      recordDate: DateTime.utc(2026, 5, 24, 1, 20),
      tags: const <String>['追剧'],
    );

    final tags = await repository.readTags(
      recordDate: DateTime.utc(2026, 5, 24, 23, 40),
    );

    expect(tags, ['追剧']);
  });

  test('再次保存同一天标签时会覆盖旧值', () async {
    await repository.saveTags(
      recordDate: DateTime.utc(2026, 5, 24),
      tags: const <String>['刷手机'],
    );
    await repository.saveTags(
      recordDate: DateTime.utc(2026, 5, 24, 23, 59),
      tags: const <String>['加班'],
    );

    final tags = await repository.readTags(
      recordDate: DateTime.utc(2026, 5, 24),
    );

    expect(tags, ['加班']);
  });
}
