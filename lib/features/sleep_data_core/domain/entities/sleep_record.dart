import 'package:freezed_annotation/freezed_annotation.dart';

part 'sleep_record.freezed.dart';

/// 标记睡眠记录的来源，确保 today、calendar 等页面共享同一套来源语义。
enum SleepRecordSource {
  /// 代表记录来自用户的快速补录或后续手动修正。
  manual,

  /// 代表记录来自后续健康数据同步。
  health,
}

/// 标记当前睡眠记录可信度，避免页面层自行发明“部分数据”语义。
enum SleepRecordConfidence {
  /// 数据足够完整，可直接参与今日反馈与趋势计算。
  trusted,

  /// 数据仍有缺口，页面应保留轻提示而不是假装完全可靠。
  partial,
}

/// 睡眠记录是 `sleep-data-core` 暴露给各页面的最小共享事实对象。
@freezed
abstract class SleepRecord with _$SleepRecord {
  /// 创建睡眠记录实体。
  const factory SleepRecord({
    required String id,
    required DateTime sleepDate,
    required int bedtimeMinutes,
    required int wakeTimeMinutes,
    required SleepRecordSource source,
    required SleepRecordConfidence confidence,
    required bool isManuallyAdjusted,
    required String? note,
    required DateTime createdAt,
  }) = _SleepRecord;
}
