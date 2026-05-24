import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/data/local/rhythm_database.dart';
import 'package:rhythm/features/sleep_records/data/drift_sleep_delay_tag_repository.dart';

/// 验证本地数据库底座可以承载阶段六标签表。
void main() {
  test('内存数据库可创建并完成基础读写', () async {
    final database = RhythmDatabase.inMemory();
    addTearDown(database.close);
    final repository = DriftSleepDelayTagRepository(database);

    await repository.saveTags(
      recordDate: DateTime.utc(2026, 5, 24),
      tags: const <String>['刷手机'],
    );

    final tags = await repository.readTags(
      recordDate: DateTime.utc(2026, 5, 24),
    );

    expect(tags, ['刷手机']);
  });
}
