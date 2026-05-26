import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/core/presentation/widgets/secondary_page_header.dart';
import 'package:rhythm/features/calendar/application/calendar_controller.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/insights/application/insights_controller.dart';
import 'package:rhythm/features/profile/application/local_data_clear_service.dart';
import 'package:rhythm/features/sleep_records/application/effective_sleep_record_provider.dart';
import 'package:rhythm/features/today/application/today_controller.dart';
import 'package:rhythm/features/widget_bridge/application/widget_snapshot_service.dart';
import 'package:rhythm/l10n/app_localizations.dart';

const String _profileFallbackLocation = '/profile';

/// 展示阶段八的隐私与数据页，统一承接协议、导出、删除和清空本地数据入口。
class PrivacyDataPage extends HookConsumerWidget {
  /// 创建隐私与数据页。
  const PrivacyDataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SecondaryPageHeader(
                  title: l10n.privacyDataPageTitle,
                  fallbackLocation: _profileFallbackLocation,
                  titleStyle: textTheme.headlineSmall?.copyWith(
                    fontFamily: 'Funnel Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.privacyDataPageDescription,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),
                _ActionListCard(
                  actions: [
                    _PrivacyAction(
                      title: l10n.privacyDataPolicyTitle,
                      description: l10n.privacyDataPolicyDescription,
                      onTap: () => _showInfoDialog(
                        context,
                        title: l10n.privacyDataPolicyTitle,
                        message: l10n.privacyDataPolicyDialogMessage,
                      ),
                    ),
                    _PrivacyAction(
                      title: l10n.privacyDataExportTitle,
                      description: l10n.privacyDataExportDescription,
                      onTap: () => _showInfoDialog(
                        context,
                        title: l10n.privacyDataExportDialogTitle,
                        message: l10n.privacyDataExportDialogMessage,
                      ),
                    ),
                    _PrivacyAction(
                      title: l10n.privacyDataDeleteAccountTitle,
                      description: l10n.privacyDataDeleteAccountDescription,
                      onTap: () => _showInfoDialog(
                        context,
                        title: l10n.privacyDataDeleteAccountDialogTitle,
                        message: l10n.privacyDataDeleteAccountDialogMessage,
                      ),
                    ),
                    _PrivacyAction(
                      title: l10n.privacyDataClearLocalTitle,
                      description: l10n.privacyDataClearLocalDescription,
                      onTap: () => _showConfirmDialog(
                        context,
                        ref: ref,
                        title: l10n.privacyDataClearLocalDialogTitle,
                        message: l10n.privacyDataClearLocalDialogMessage,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 统一弹出阶段八隐私相关确认框，避免页面层重复拼装确认文案和按钮。
  Future<void> _showInfoDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    final l10n = AppLocalizations.of(context);

    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.commonCancelButton),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.commonConfirmButton),
            ),
          ],
        );
      },
    );
  }

  /// “清空本地数据”会影响多个页面缓存，这里集中失效相关 Provider，确保回到页面后读到新状态。
  Future<void> _clearBusinessLocalData(
    BuildContext context,
    WidgetRef ref,
  ) async {
    await ref.read(localDataClearServiceProvider).clearBusinessLocalData();
    ref.invalidate(savedGoalScheduleSettingsProvider);
    ref.invalidate(recentSevenDayEffectiveSleepRecordsProvider);
    ref.invalidate(recentThirtyDayEffectiveSleepRecordsProvider);
    ref.invalidate(recentEffectiveSleepRecordsProvider);
    ref.invalidate(calendarControllerProvider);
    ref.invalidate(insightsControllerProvider);
    ref.invalidate(todayControllerProvider);
    ref.invalidate(widgetThemeSnapshotProvider);

    if (!context.mounted) {
      return;
    }
  }

  /// 清空操作只删除业务本地数据，不影响语言、主题和登录态，因此需要单独确认说明。
  Future<void> _showConfirmDialog(
    BuildContext context, {
    required WidgetRef ref,
    required String title,
    required String message,
  }) {
    final l10n = AppLocalizations.of(context);

    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.commonCancelButton),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await _clearBusinessLocalData(context, ref);
              },
              child: Text(l10n.commonConfirmButton),
            ),
          ],
        );
      },
    );
  }
}

/// 描述隐私与数据页的单条操作配置，统一承载标题、副标题和点击动作。
class _PrivacyAction {
  /// 创建隐私操作配置。
  const _PrivacyAction({
    required this.title,
    required this.description,
    required this.onTap,
  });

  /// 操作标题。
  final String title;

  /// 操作说明。
  final String description;

  /// 点击后的动作。
  final VoidCallback onTap;
}

/// 渲染隐私页的操作列表卡，保持“标题 + 说明 + 右箭头”的信息层级。
class _ActionListCard extends StatelessWidget {
  /// 创建操作列表卡。
  const _ActionListCard({required this.actions});

  /// 操作列表。
  final List<_PrivacyAction> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          for (var index = 0; index < actions.length; index++) ...[
            _ActionTile(action: actions[index]),
            if (index != actions.length - 1)
              const Divider(height: 1, indent: 16, endIndent: 16),
          ],
        ],
      ),
    );
  }
}

/// 渲染单条隐私操作入口，避免页面层重复拼装列表项结构。
class _ActionTile extends StatelessWidget {
  /// 创建单条操作入口。
  const _ActionTile({required this.action});

  /// 对应的操作配置。
  final _PrivacyAction action;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: action.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    action.title,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    action.description,
                    style: textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF7A9A80)),
          ],
        ),
      ),
    );
  }
}
