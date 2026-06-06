import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../sleep_data_core/application/providers/sleep_record_repository_provider.dart';
import '../../../sleep_data_core/domain/entities/sleep_record.dart';
import 'today_snapshot_provider.dart';

part 'today_quick_record_controller.g.dart';

/// 承接 today 快捷补录提交，避免页面直接依赖仓储或生成业务 id。
@riverpod
class TodayQuickRecordController extends _$TodayQuickRecordController {
  /// 当前控制器只负责提交动作，不长期持有表单内容。
  @override
  FutureOr<void> build() {}

  /// 保存一条最小手动记录，并在成功后刷新 today 首页聚合。
  Future<void> submit({
    required DateTime sleepDate,
    required int bedtimeMinutes,
    required int wakeTimeMinutes,
    String? note,
  }) async {
    final repository = ref.read(sleepRecordRepositoryProvider);
    final trimmedNote = note?.trim();

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await repository.saveManualRecord(
        SleepRecord(
          id: const Uuid().v4(),
          sleepDate: DateTime(sleepDate.year, sleepDate.month, sleepDate.day),
          bedtimeMinutes: bedtimeMinutes,
          wakeTimeMinutes: wakeTimeMinutes,
          source: SleepRecordSource.manual,
          confidence: SleepRecordConfidence.trusted,
          isManuallyAdjusted: true,
          note: trimmedNote == null || trimmedNote.isEmpty ? null : trimmedNote,
          createdAt: DateTime.now(),
        ),
      );
      ref.invalidate(todaySnapshotProvider);
    });
  }
}
