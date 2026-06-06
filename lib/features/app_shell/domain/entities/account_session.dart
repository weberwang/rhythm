import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_session.freezed.dart';
part 'account_session.g.dart';

/// 标记当前设备上的账号模式，供引导完成后和设置页读取统一语义。
enum AppAccountSessionMode {
  /// 仍处于本地优先模式，尚未连接云端账号。
  anonymous,

  /// 已通过账号入口完成连接，可用于后续同步与资料展示。
  connected,
}

/// 统一描述当前账号来源，避免各页面直接依赖 onboarding 内部枚举。
enum AppAccountProvider {
  /// Apple 账号入口。
  apple,

  /// Google 账号入口。
  google,
}

/// 记录当前设备上的最小账号快照，作为引导、设置和后续同步的共享基线。
@freezed
abstract class AppAccountSession with _$AppAccountSession {
  /// 创建共享账号快照。
  const factory AppAccountSession({
    required AppAccountSessionMode mode,
    AppAccountProvider? provider,
    String? displayName,
    String? email,
    required DateTime updatedAt,
  }) = _AppAccountSession;

  /// 从持久化 JSON 恢复共享账号快照。
  factory AppAccountSession.fromJson(Map<String, dynamic> json) =>
      _$AppAccountSessionFromJson(json);
}
