import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/sync_queue_item.dart';
import 'sync_service.dart';

/// 提供账号与同步页控制器，统一把同步服务摘要转换为页面可消费的状态字段。
final accountSyncControllerProvider =
    AsyncNotifierProvider.autoDispose<
      AccountSyncController,
      AccountSyncViewState
    >(AccountSyncController.new);

/// 标记账号与同步页当前所处的主状态，供显示层切换卡片文案与操作入口。
enum AccountSyncStatus {
  /// 当前保持本地优先模式，没有进入远端同步。
  localOnly,

  /// 当前需要先登录账号，才能开始多端同步。
  signInRequired,

  /// 最近一次同步失败，允许用户手动重试。
  failed,

  /// 最近一次同步已完成，页面只需要展示摘要。
  synced,
}

/// 承载账号与同步页需要展示的最小状态字段，避免应用层直接拼装最终展示文案。
class AccountSyncViewState {
  /// 创建账号与同步页状态。
  const AccountSyncViewState({
    required this.status,
    required this.hasLinkedAccount,
    this.email,
    this.lastSyncedAt,
  });

  /// 页面当前主状态。
  final AccountSyncStatus status;

  /// 当前设备是否已经绑定可恢复的远端账号。
  final bool hasLinkedAccount;

  /// 若当前账号可读出邮箱，则提供给显示层直接展示。
  final String? email;

  /// 最近一次成功同步完成时间。
  final DateTime? lastSyncedAt;
}

/// 负责读取当前同步摘要，并在用户点击重试后刷新账号与同步页状态。
class AccountSyncController extends AsyncNotifier<AccountSyncViewState> {
  @override
  Future<AccountSyncViewState> build() async {
    final summary = await ref.read(syncServiceProvider).inspect();
    return _fromSummary(summary);
  }

  /// 触发一次同步重试，并把结果重新映射成页面状态。
  Future<void> retrySync() async {
    state = const AsyncLoading();
    final summary = await ref.read(syncServiceProvider).sync();
    state = AsyncData(_fromSummary(summary));
  }

  /// 应用层只保留状态与账号字段，最终文案交由显示层按语言环境解析。
  AccountSyncViewState _fromSummary(SyncRunSummary summary) {
    if (summary.hadFailure) {
      return AccountSyncViewState(
        status: AccountSyncStatus.failed,
        hasLinkedAccount: summary.signedIn || summary.email != null,
        email: summary.email,
        lastSyncedAt: summary.lastSyncedAt,
      );
    }

    if (summary.requiresSignIn) {
      return AccountSyncViewState(
        status: AccountSyncStatus.signInRequired,
        hasLinkedAccount: false,
        email: summary.email,
        lastSyncedAt: summary.lastSyncedAt,
      );
    }

    if (summary.localOnly) {
      return AccountSyncViewState(
        status: AccountSyncStatus.localOnly,
        hasLinkedAccount: summary.signedIn || summary.email != null,
        email: summary.email,
        lastSyncedAt: summary.lastSyncedAt,
      );
    }

    return AccountSyncViewState(
      status: AccountSyncStatus.synced,
      hasLinkedAccount: summary.signedIn || summary.email != null,
      email: summary.email,
      lastSyncedAt: summary.lastSyncedAt,
    );
  }
}
