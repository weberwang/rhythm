import 'package:collection/collection.dart';

/// 标记阶段八最小同步边界内的业务实体类型。
enum SyncEntityType {
  /// 目标作息设置。
  goalSettings,

  /// 睡眠记录。
  sleepRecord,

  /// 晚睡原因标签。
  sleepDelayTag,

  /// 周报摘要。
  weeklyReportSummary,
}

/// 标记同步项对远端的意图，当前只保留更新和删除两种最小操作。
enum SyncOperation {
  /// 新增或更新同一实体。
  upsert,

  /// 删除同一实体。
  delete,
}

/// 承载单条同步项在本地队列中的状态。
enum SyncQueueStatus {
  /// 等待下一次同步处理。
  pending,

  /// 本次同步失败，等待用户稍后重试。
  failed,

  /// 已完成当前批次同步，不再保留在待同步队列中。
  completed,
}

/// 表示一条待同步或刚处理完成的队列项，统一承载最小同步边界内的载荷。
class SyncQueueItem {
  /// 创建同步队列项。
  const SyncQueueItem({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payload,
    required this.updatedAt,
    this.status = SyncQueueStatus.pending,
    this.retryCount = 0,
    this.userEdited = false,
    this.lastErrorMessage,
  });

  /// 同步项唯一标识。
  final String id;

  /// 实体类型。
  final SyncEntityType entityType;

  /// 业务实体标识。
  final String entityId;

  /// 本次同步操作。
  final SyncOperation operation;

  /// 统一以结构化 Map 承载最小同步载荷，便于服务层与测试共享。
  final Map<String, Object?> payload;

  /// 本地最近一次修改时间，用于冲突策略比较新旧。
  final DateTime updatedAt;

  /// 当前队列状态。
  final SyncQueueStatus status;

  /// 已重试次数。
  final int retryCount;

  /// 是否来自用户明确确认的修改；冲突时优先保留这类结果。
  final bool userEdited;

  /// 最近一次失败摘要。
  final String? lastErrorMessage;

  /// 生成带更新字段的新同步项，避免服务层直接手写整对象复制。
  SyncQueueItem copyWith({
    String? id,
    SyncEntityType? entityType,
    String? entityId,
    SyncOperation? operation,
    Map<String, Object?>? payload,
    DateTime? updatedAt,
    SyncQueueStatus? status,
    int? retryCount,
    bool? userEdited,
    String? lastErrorMessage,
    bool clearLastErrorMessage = false,
  }) {
    return SyncQueueItem(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      userEdited: userEdited ?? this.userEdited,
      lastErrorMessage: clearLastErrorMessage
          ? null
          : lastErrorMessage ?? this.lastErrorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SyncQueueItem &&
        id == other.id &&
        entityType == other.entityType &&
        entityId == other.entityId &&
        operation == other.operation &&
        const DeepCollectionEquality().equals(payload, other.payload) &&
        updatedAt == other.updatedAt &&
        status == other.status &&
        retryCount == other.retryCount &&
        userEdited == other.userEdited &&
        lastErrorMessage == other.lastErrorMessage;
  }

  @override
  int get hashCode => Object.hash(
        id,
        entityType,
        entityId,
        operation,
        const DeepCollectionEquality().hash(payload),
        updatedAt,
        status,
        retryCount,
        userEdited,
        lastErrorMessage,
      );
}

/// 汇总一次同步执行结果，供账号与同步页和测试统一读取状态。
class SyncRunSummary {
  /// 创建同步执行摘要。
  const SyncRunSummary({
    required this.configured,
    required this.signedIn,
    required this.supportsRemoteSync,
    required this.pendingCount,
    this.email,
    this.uploadedCount = 0,
    this.downloadedCount = 0,
    this.conflictCount = 0,
    this.lastSyncedAt,
    this.failureReason,
  });

  /// 当前环境是否已完成 Supabase 配置。
  final bool configured;

  /// 当前是否存在可用登录态。
  final bool signedIn;

  /// 当前环境是否允许真正执行远端读写。
  final bool supportsRemoteSync;

  /// 当前用户邮箱或身份摘要。
  final String? email;

  /// 本次执行前剩余的待同步项数量。
  final int pendingCount;

  /// 本次成功上传的数量。
  final int uploadedCount;

  /// 本次成功采纳远端结果的数量。
  final int downloadedCount;

  /// 本次命中的冲突数量。
  final int conflictCount;

  /// 最近一次成功同步完成时间。
  final DateTime? lastSyncedAt;

  /// 若失败，则记录统一错误摘要。
  final String? failureReason;

  /// 是否需要用户先登录，才能继续执行云端同步。
  bool get requiresSignIn => configured && !signedIn;

  /// 当前是否已经进入失败状态。
  bool get hadFailure => failureReason != null;

  /// 当前是否只能保持本地优先模式。
  bool get localOnly => !supportsRemoteSync;
}
