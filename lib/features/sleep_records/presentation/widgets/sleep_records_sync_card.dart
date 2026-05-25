import 'package:flutter/material.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_sync_controller.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sync_failure_card.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 阶段三同步状态卡。
class SleepRecordsSyncCard extends StatelessWidget {
  /// 创建同步状态卡实例。
  const SleepRecordsSyncCard({
    super.key,
    required this.syncState,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
  });

  /// 当前同步摘要状态。
  final SleepRecordSyncState syncState;

  /// 主动作回调。
  final VoidCallback onPrimaryPressed;

  /// 次动作回调。
  final VoidCallback onSecondaryPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isSuccess = syncState.status == SleepRecordSyncStatus.success;

    return Column(
      // 同步状态文案在不同平台与失败分支长度差异较大，统一拉满避免摘要卡收缩。
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.sleepRecordsHubSyncTitle, style: textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          l10n.sleepRecordsHubSyncDescription,
          style: textTheme.bodyMedium?.copyWith(color: const Color(0xFF4A6B52)),
        ),
        const SizedBox(height: 16),
        Card(
          color: isSuccess ? const Color(0xFF1B3A28) : const Color(0xFFF9FBF6),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _titleForStatus(l10n),
                  style: textTheme.titleMedium?.copyWith(
                    color: isSuccess ? Colors.white : const Color(0xFF1B3A28),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _descriptionForStatus(l10n),
                  style: textTheme.bodyMedium?.copyWith(
                    color: isSuccess
                        ? const Color(0xFFD7E7DA)
                        : const Color(0xFF4A6B52),
                  ),
                ),
                if (syncState.lastSyncedAt != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        l10n.sleepRecordsHubLastSyncedTitle,
                        style: textTheme.bodySmall?.copyWith(
                          color: isSuccess
                              ? const Color(0xFFD7E7DA)
                              : const Color(0xFF4A6B52),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatLastSynced(syncState.lastSyncedAt!),
                        style: textTheme.bodySmall?.copyWith(
                          color: isSuccess
                              ? const Color(0xFFD7E7DA)
                              : const Color(0xFF4A6B52),
                        ),
                      ),
                    ],
                  ),
                ],
                if (syncState.failureReason != null) ...[
                  const SizedBox(height: 12),
                  SyncFailureCard(syncState: syncState),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onPrimaryPressed,
                child: Text(_primaryLabelForStatus(l10n)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.tonal(
                onPressed: onSecondaryPressed,
                child: Text(l10n.sleepRecordsHubManualModeButton),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _titleForStatus(AppLocalizations l10n) {
    switch (syncState.status) {
      case SleepRecordSyncStatus.success:
        return l10n.sleepRecordsHubStatusConnected;
      case SleepRecordSyncStatus.installRequired:
        return l10n.sleepRecordsHubStatusInstallRequired;
      case SleepRecordSyncStatus.permissionRequired:
        return l10n.sleepRecordsHubStatusPermissionRequired;
      case SleepRecordSyncStatus.unavailable:
        return l10n.sleepRecordsHubStatusUnavailable;
      case SleepRecordSyncStatus.manualFallback:
        return l10n.sleepRecordsHubStatusManualFallback;
      case SleepRecordSyncStatus.error:
        return l10n.sleepRecordsHubStatusError;
      case SleepRecordSyncStatus.syncing:
        return l10n.sleepRecordsHubStatusSyncing;
      case SleepRecordSyncStatus.idle:
        return l10n.sleepRecordsHubStatusIdle;
    }
  }

  String _descriptionForStatus(AppLocalizations l10n) {
    switch (syncState.status) {
      case SleepRecordSyncStatus.success:
        return l10n.sleepRecordsHubStatusConnectedDescription(
          syncState.syncedCount,
        );
      case SleepRecordSyncStatus.installRequired:
        return l10n.sleepRecordsHubStatusInstallRequiredDescription;
      case SleepRecordSyncStatus.permissionRequired:
        return l10n.sleepRecordsHubStatusPermissionRequiredDescription;
      case SleepRecordSyncStatus.unavailable:
        return l10n.sleepRecordsHubStatusUnavailableDescription;
      case SleepRecordSyncStatus.manualFallback:
        return l10n.sleepRecordsHubStatusManualFallbackDescription;
      case SleepRecordSyncStatus.error:
        return l10n.sleepRecordsHubStatusErrorDescription;
      case SleepRecordSyncStatus.syncing:
        return l10n.sleepRecordsHubStatusSyncingDescription;
      case SleepRecordSyncStatus.idle:
        return l10n.sleepRecordsHubStatusIdleDescription;
    }
  }

  String _primaryLabelForStatus(AppLocalizations l10n) {
    switch (syncState.status) {
      case SleepRecordSyncStatus.installRequired:
        return l10n.sleepRecordsHubInstallButton;
      case SleepRecordSyncStatus.permissionRequired:
        return l10n.sleepRecordsHubAuthorizeButton;
      case SleepRecordSyncStatus.unavailable:
        return l10n.sleepRecordsHubManualModeButton;
      case SleepRecordSyncStatus.success:
      case SleepRecordSyncStatus.error:
      case SleepRecordSyncStatus.idle:
      case SleepRecordSyncStatus.syncing:
      case SleepRecordSyncStatus.manualFallback:
        return l10n.sleepRecordsHubRetryButton;
    }
  }

  /// 统一格式化最近同步时间，避免页面层散落时间摘要逻辑。
  String _formatLastSynced(DateTime value) {
    return '${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')} '
        '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
  }
}
