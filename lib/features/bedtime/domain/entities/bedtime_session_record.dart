import 'package:freezed_annotation/freezed_annotation.dart';

import 'bedtime_session_draft.dart';

part 'bedtime_session_record.freezed.dart';

/// 描述当晚睡前会话的最小持久化记录，用于草稿恢复与完成态写回。
@freezed
abstract class BedtimeSessionRecord with _$BedtimeSessionRecord {
  /// 创建睡前会话记录。
  const factory BedtimeSessionRecord({
    required DateTime sessionDate,
    required BedtimeStatusChoice? selectedChoice,
    required BedtimeEntrySource entrySource,
    required bool isCompleted,
    required DateTime updatedAt,
  }) = _BedtimeSessionRecord;
}
