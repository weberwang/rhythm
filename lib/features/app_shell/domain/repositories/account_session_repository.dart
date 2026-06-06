import '../entities/account_session.dart';

/// 约束共享账号快照的读取与写入边界，避免页面直接处理本地持久化细节。
abstract class AccountSessionRepository {
  /// 读取当前设备上最近一次落下的账号快照。
  Future<AppAccountSession?> read();

  /// 保存当前设备上的账号快照，供后续启动与设置页复用。
  Future<void> save(AppAccountSession session);

  /// 清空账号快照，供后续退出登录或重置场景使用。
  Future<void> clear();
}
