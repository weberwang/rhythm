import '../bedtime_session.dart';

/// 睡前会话仓储接口，隔离页面和应用层对具体持久化方案的依赖。
abstract class BedtimeSessionRepository {
  /// 读取指定业务日期的睡前会话。
  Future<BedtimeSession?> findByDate(DateTime date);

  /// 保存睡前会话，供状态选择和后续复盘读取。
  Future<void> save(BedtimeSession session);
}
