import 'package:flutter/material.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_sync_controller.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示同步失败摘要，避免管理页直接拼装失败原因文案。
class SyncFailureCard extends StatelessWidget {
  /// 创建同步失败卡实例。
  const SyncFailureCard({
    super.key,
    required this.syncState,
  });

  /// 当前同步状态，用于解析失败原因摘要。
  final SleepRecordSyncState syncState;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final reason = _failureReasonLabel(l10n, syncState.failureReason);
    if (reason == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.sleepRecordsHubFailureReasonTitle,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: const Color(0xFF7A4B13),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            reason,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF7A4B13),
                ),
          ),
        ],
      ),
    );
  }

  /// 将失败原因代码映射为面向用户的稳定摘要，避免 UI 散落状态码判断。
  String? _failureReasonLabel(AppLocalizations l10n, String? failureReason) {
    switch (failureReason) {
      case 'sync_failed':
        return l10n.sleepRecordsHubFailureReasonSyncFailed;
      case 'platform_unavailable':
        return l10n.sleepRecordsHubFailureReasonPlatformUnavailable;
      case null:
        return null;
      default:
        return l10n.sleepRecordsHubFailureReasonGeneric;
    }
  }
}
