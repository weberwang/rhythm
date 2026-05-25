import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/sync_queue_item.dart';

/// 定义同步队列读取与写回边界，避免同步服务直接依赖具体存储细节。
abstract class SyncQueueRepository {
  /// 读取当前所有待处理的同步项。
  Future<List<SyncQueueItem>> readPendingItems();

  /// 以“按 id 覆盖”的方式保存待同步项，便于失败重试时更新状态。
  Future<void> savePendingItems(List<SyncQueueItem> pendingItems);

  /// 从待同步队列中移除指定项。
  Future<void> removeItemsByIds(List<String> ids);
}

/// 提供默认的内存队列仓储，先稳定阶段八同步契约，避免把状态散落到页面层。
final syncQueueRepositoryProvider = Provider<SyncQueueRepository>((ref) {
  return MemorySyncQueueRepository();
});

/// 基于进程内内存维护同步队列，适合作为阶段八本地优先链路的默认实现。
class MemorySyncQueueRepository implements SyncQueueRepository {
  final List<SyncQueueItem> _items = <SyncQueueItem>[];

  @override
  Future<List<SyncQueueItem>> readPendingItems() async {
    return _items
        .where((item) => item.status != SyncQueueStatus.completed)
        .toList(growable: false);
  }

  @override
  Future<void> removeItemsByIds(List<String> ids) async {
    _items.removeWhere((item) => ids.contains(item.id));
  }

  @override
  Future<void> savePendingItems(List<SyncQueueItem> pendingItems) async {
    for (final pendingItem in pendingItems) {
      final index = _items.indexWhere((item) => item.id == pendingItem.id);
      if (index == -1) {
        _items.add(pendingItem);
        continue;
      }
      _items[index] = pendingItem;
    }
  }
}
