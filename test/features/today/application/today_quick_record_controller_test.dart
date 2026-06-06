import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/sleep_record_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/sleep_record.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/sleep_record_repository.dart';
import 'package:rhythm/features/today/application/providers/today_quick_record_controller.dart';

/// 用内存仓储验证 today 快捷补录会落到共享记录边界，而不是页面层临时缓存。
class _FakeSleepRecordRepository implements SleepRecordRepository {
  final List<SleepRecord> savedRecords = <SleepRecord>[];

  @override
  Future<SleepRecord?> readLatestRecord() async {
    if (savedRecords.isEmpty) {
      return null;
    }
    return savedRecords.last;
  }

  @override
  Future<List<SleepRecord>> readRecentRecords({required int limit}) async {
    return savedRecords.reversed.take(limit).toList();
  }

  @override
  Future<void> saveManualRecord(SleepRecord record) async {
    savedRecords.add(record);
  }
}

/// 验证快捷补录通过应用层控制器写入共享仓储，并保留“手动修正”来源语义。
void main() {
  test(
    'today quick record controller persists a manual sleep record',
    () async {
      final repository = _FakeSleepRecordRepository();
      final container = ProviderContainer(
        overrides: [
          sleepRecordRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(
        todayQuickRecordControllerProvider.notifier,
      );

      await controller.submit(
        sleepDate: DateTime(2026, 6, 5),
        bedtimeMinutes: 23 * 60 + 32,
        wakeTimeMinutes: 7 * 60 + 8,
        note: '今晚先手动补录',
      );

      expect(repository.savedRecords, hasLength(1));
      expect(repository.savedRecords.single.source, SleepRecordSource.manual);
      expect(repository.savedRecords.single.isManuallyAdjusted, isTrue);
      expect(repository.savedRecords.single.note, '今晚先手动补录');
    },
  );
}
