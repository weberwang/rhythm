import '../domain/bedtime_session.dart';
import '../domain/repositories/bedtime_session_repository.dart';

/// 提供测试阶段使用的内存会话仓储，避免在控制器验证时依赖真实数据库。
class InMemoryBedtimeSessionRepository implements BedtimeSessionRepository {
  final Map<DateTime, BedtimeSession> _sessions = <DateTime, BedtimeSession>{};

  @override
  Future<BedtimeSession?> findByDate(DateTime date) async {
    return _sessions[_normalizeDate(date)];
  }

  @override
  Future<void> save(BedtimeSession session) async {
    _sessions[_normalizeDate(session.startedAt)] = session;
  }

  /// 统一归一化到业务日期，避免同一天多次进入生成多条主会话。
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
