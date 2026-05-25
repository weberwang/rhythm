import 'package:collection/collection.dart';

import 'sync_queue_item.dart';

/// 标记冲突解决后应采用哪一侧结果，供同步服务记录冲突统计。
enum SyncConflictWinner {
  /// 保留本地结果。
  local,

  /// 采用远端结果。
  remote,
}

/// 描述一次冲突解决的结果，统一承载采用侧和最终合并后的队列项。
class SyncConflictResolution {
  /// 创建同步冲突解决结果。
  const SyncConflictResolution({
    required this.winner,
    required this.mergedItem,
    this.isDuplicate = false,
  });

  /// 最终采用的一侧。
  final SyncConflictWinner winner;

  /// 合并后的最终同步项。
  final SyncQueueItem mergedItem;

  /// 当前冲突是否只是重复载荷，不需要额外处理。
  final bool isDuplicate;
}

/// 根据阶段八约定统一处理同步冲突，优先保护用户手动确认过的结果。
class SyncConflictPolicy {
  /// 创建同步冲突策略。
  const SyncConflictPolicy();

  /// 解决同一实体在本地与远端之间的冲突。
  ///
  /// 这里先保护用户手动修改结果，再比较删除意图和更新时间，避免重复同步覆盖已确认数据。
  SyncConflictResolution resolve({
    required SyncQueueItem local,
    required SyncQueueItem remote,
  }) {
    final payloadEquals = const DeepCollectionEquality().equals(
      local.payload,
      remote.payload,
    );
    if (local.operation == remote.operation && payloadEquals) {
      final mergedItem = local.copyWith(
        updatedAt: _laterOf(local.updatedAt, remote.updatedAt),
      );
      return SyncConflictResolution(
        winner: SyncConflictWinner.local,
        mergedItem: mergedItem,
        isDuplicate: true,
      );
    }

    if (local.userEdited) {
      return SyncConflictResolution(
        winner: SyncConflictWinner.local,
        mergedItem: local,
      );
    }

    if (local.operation == SyncOperation.delete ||
        remote.operation == SyncOperation.delete) {
      if (local.operation == SyncOperation.delete &&
          !remote.updatedAt.isAfter(local.updatedAt)) {
        return SyncConflictResolution(
          winner: SyncConflictWinner.local,
          mergedItem: local,
        );
      }
      if (remote.operation == SyncOperation.delete) {
        return SyncConflictResolution(
          winner: SyncConflictWinner.remote,
          mergedItem: remote,
        );
      }
      return SyncConflictResolution(
        winner: SyncConflictWinner.local,
        mergedItem: local,
      );
    }

    if (remote.updatedAt.isAfter(local.updatedAt)) {
      return SyncConflictResolution(
        winner: SyncConflictWinner.remote,
        mergedItem: remote,
      );
    }

    return SyncConflictResolution(
      winner: SyncConflictWinner.local,
      mergedItem: local,
    );
  }

  DateTime _laterOf(DateTime left, DateTime right) {
    return left.isAfter(right) ? left : right;
  }
}
