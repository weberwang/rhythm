import '../entities/bedtime_session_record.dart';

/// 统一约束睡前会话的草稿恢复与完成态写回边界。
abstract class BedtimeSessionRepository {
  /// 读取指定会话日的睡前记录。
  Future<BedtimeSessionRecord?> readSessionForDate(DateTime sessionDate);

  /// 保存或更新指定会话日的睡前记录。
  Future<void> saveSession(BedtimeSessionRecord record);
}
