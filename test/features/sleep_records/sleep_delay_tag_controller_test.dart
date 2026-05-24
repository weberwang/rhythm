import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sleep_records/application/sleep_delay_tag_controller.dart';
import 'package:rhythm/features/sleep_records/application/sleep_delay_tag_providers.dart';
import 'package:rhythm/features/sleep_records/data/in_memory_sleep_delay_tag_repository.dart';
import 'package:rhythm/data/local/rhythm_database.dart';

/// 验证阶段六标签控制器会保存默认标签与自定义标签。
void main() {
  test('保存默认标签后可重新读取', () async {
    final repository = InMemorySleepDelayTagRepository();
    final container = ProviderContainer(
      overrides: [
        sleepDelayTagRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(sleepDelayTagControllerProvider);
    final date = DateTime.utc(2026, 5, 24);

    await controller.saveTags(recordDate: date, tags: const <String>['刷手机']);
    final tags = await controller.loadTags(recordDate: date);

    expect(tags, ['刷手机']);
  });

  test('保存自定义标签时会先规范化输入', () async {
    final repository = InMemorySleepDelayTagRepository();
    final container = ProviderContainer(
      overrides: [
        sleepDelayTagRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(sleepDelayTagControllerProvider);
    final date = DateTime.utc(2026, 5, 24);

    await controller.saveCustomTag(recordDate: date, input: '  临时项目  ');
    final tags = await controller.loadTags(recordDate: date);

    expect(tags, ['临时项目']);
  });

  test('默认仓储会把标签持久化到 shared preferences', () async {
    final database = RhythmDatabase.inMemory();
    final container = ProviderContainer(
      overrides: [
        rhythmDatabaseProvider.overrideWithValue(database),
      ],
    );
    addTearDown(() async {
      container.dispose();
      await database.close();
    });

    final controller = container.read(sleepDelayTagControllerProvider);
    final date = DateTime.utc(2026, 5, 24);

    await controller.saveTags(recordDate: date, tags: const <String>['刷手机']);

    final repository = container.read(sleepDelayTagRepositoryProvider);
    final tags = await repository.readTags(recordDate: date);

    expect(tags, ['刷手机']);
  });
}
