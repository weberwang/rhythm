import 'package:freezed_annotation/freezed_annotation.dart';

import '../../features/app_shell/domain/entities/entry_intent.dart';

part 'launch_state.freezed.dart';
part 'launch_state.g.dart';

/// 定义启动完成后应该进入的根级目的地。
enum LaunchDestination {
  /// 进入首次激活引导。
  onboarding,

  /// 进入五标签主壳。
  shell,
}

/// 聚合启动期所需的最小分发状态，避免主壳直接猜测入口。
@freezed
abstract class LaunchSnapshot with _$LaunchSnapshot {
  /// 创建启动状态快照。
  const factory LaunchSnapshot({
    required LaunchDestination destination,
    required EntryIntent entryIntent,
  }) = _LaunchSnapshot;

  /// 从 JSON 恢复启动快照，便于后续扩展持久化或调试场景。
  factory LaunchSnapshot.fromJson(Map<String, dynamic> json) =>
      _$LaunchSnapshotFromJson(json);
}
