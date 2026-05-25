import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/app/router/secondary_navigation.dart';
import 'package:rhythm/core/presentation/widgets/secondary_page_header.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/sleep_records/application/effective_sleep_record_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/sleep_records/application/sleep_records_analytics.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_sync_controller.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sleep_record_list_section.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sleep_records_sync_card.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 阶段三睡眠记录管理页，用于承接同步状态、手动补录入口与最近记录列表。
class SleepRecordsHubPage extends HookConsumerWidget {
  /// 创建睡眠记录管理页实例。
  const SleepRecordsHubPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);
    final timeContext = ref.watch(timeContextProvider);
    final goalScheduleAsync = ref.watch(savedGoalScheduleSettingsProvider);
    final platformStateAsync = ref.watch(healthPlatformStateProvider);
    final recordsAsync = ref.watch(recentEffectiveSleepRecordsProvider);
    final syncController = ref.watch(sleepRecordSyncControllerProvider);

    final syncState = platformStateAsync.when(
      data: (platformState) => SleepRecordSyncState(
        status: _statusFromPlatformState(platformState),
        platformState: platformState,
      ),
      loading: () =>
          const SleepRecordSyncState(status: SleepRecordSyncStatus.syncing),
      error: (error, stackTrace) =>
          const SleepRecordSyncState(status: SleepRecordSyncStatus.error),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            // 管理页卡片存在纯文本说明块，统一拉满可避免状态切换后宽度忽大忽小。
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SecondaryPageHeader(
                title: l10n.sleepRecordsHubTitle,
                fallbackLocation: RhythmTab.today.path,
                titleStyle: textTheme.headlineSmall?.copyWith(
                  fontFamily: 'Funnel Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 18),
              SleepRecordsSyncCard(
                syncState:
                    syncController.state.status == SleepRecordSyncStatus.idle
                    ? syncState
                    : syncController.state,
                onPrimaryPressed: () async {
                  final currentState =
                      syncController.state.status == SleepRecordSyncStatus.idle
                      ? syncState
                      : syncController.state;
                  if (currentState.status ==
                      SleepRecordSyncStatus.installRequired) {
                    await ref
                        .read(healthPermissionGatewayProvider)
                        .openHealthProviderInstallation();
                    await ref
                        .read(sleepRecordsAnalyticsProvider)
                        .track(
                          const SleepRecordsAnalyticsEvent(
                            name: 'sleep_records_install_health_connect',
                          ),
                        );
                    ref.invalidate(healthPlatformStateProvider);
                    return;
                  }
                  if (currentState.status ==
                      SleepRecordSyncStatus.permissionRequired) {
                    await ref
                        .read(healthPermissionGatewayProvider)
                        .requestAccess();
                    await ref
                        .read(sleepRecordsAnalyticsProvider)
                        .track(
                          const SleepRecordsAnalyticsEvent(
                            name: 'sleep_records_request_access',
                          ),
                        );
                    ref.invalidate(healthPlatformStateProvider);
                    return;
                  }

                  await ref
                      .read(sleepRecordSyncControllerProvider)
                      .syncRecentRecords(
                        dayStartMinutes:
                            goalScheduleAsync.value?.dayStartMinutes ?? 4 * 60,
                        timezone: timeContext.timezoneName,
                      );
                  await ref
                      .read(sleepRecordsAnalyticsProvider)
                      .track(
                        SleepRecordsAnalyticsEvent(
                          name: 'sleep_records_sync_attempt',
                          parameters: <String, Object?>{
                            'status': ref
                                .read(sleepRecordSyncControllerProvider)
                                .state
                                .status
                                .name,
                          },
                        ),
                      );
                  ref.invalidate(recentEffectiveSleepRecordsProvider);
                },
                onSecondaryPressed: () {
                  context.pushSecondary(manualSleepRecordPath);
                },
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.sleepRecordsHubSourceTitle,
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(l10n.sleepRecordsHubSourceBulletOriginal),
                      const SizedBox(height: 6),
                      Text(l10n.sleepRecordsHubSourceBulletManual),
                      const SizedBox(height: 6),
                      Text(l10n.sleepRecordsHubSourceBulletFallback),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: recordsAsync.when(
                  data: (records) => SleepRecordListSection(records: records),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) =>
                      Center(child: Text(l10n.sleepRecordsHubLoadFailed)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SleepRecordSyncStatus _statusFromPlatformState(
    HealthPlatformState platformState,
  ) {
    switch (platformState.platformCode) {
      case 'android_install_required':
        return SleepRecordSyncStatus.installRequired;
      case 'android_permission_required':
      case 'ios_permission_required':
        return SleepRecordSyncStatus.permissionRequired;
      case 'android_unavailable':
      case 'unsupported':
        return SleepRecordSyncStatus.unavailable;
      case 'android_available':
      case 'ios_available':
        return SleepRecordSyncStatus.success;
      default:
        return SleepRecordSyncStatus.manualFallback;
    }
  }
}
