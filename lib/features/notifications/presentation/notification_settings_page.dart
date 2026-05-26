import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/core/presentation/widgets/secondary_page_header.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/notifications/application/bedtime_reminder_scheduler.dart';
import 'package:rhythm/features/notifications/application/reminder_settings_controller.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import 'widgets/reminder_strategy_form_section.dart';

/// 展示阶段八的提醒设置页，直接复用唯一的提醒策略表单以避免重复入口。
class NotificationSettingsPage extends HookConsumerWidget {
  /// 创建提醒设置页。
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final permissionAsync = ref.watch(notificationPermissionGrantedProvider);

    useEffect(() {
      Future<void>(() async {
        ref.invalidate(notificationPermissionGrantedProvider);
        await ref.read(notificationPermissionGrantedProvider.future);
      });
      return null;
    }, const []);
    useOnAppLifecycleStateChange((previous, current) {
      if (current == AppLifecycleState.resumed) {
        // 用户从系统通知设置返回后需要立刻重读权限，避免页面继续展示旧状态。
        ref.invalidate(notificationPermissionGrantedProvider);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SecondaryPageHeader(
                title: l10n.notificationSettingsPageTitle,
                fallbackLocation: RhythmTab.profile.path,
                titleStyle: textTheme.headlineSmall?.copyWith(
                  fontFamily: 'Funnel Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.notificationSettingsPageDescription,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              _NotificationPermissionCard(permissionAsync: permissionAsync),
              const SizedBox(height: 18),
              const Expanded(
                child: SingleChildScrollView(
                  child: ReminderStrategyFormSection(),
                ),
              ),
              const SizedBox(height: 12),
              RhythmPrimaryButton(
                label: l10n.notificationSettingsSaveButton,
                onPressed: () async {
                  final notificationGateway = ref.read(
                    localNotificationGatewayProvider,
                  );
                  final hasPermission = await notificationGateway
                      .isPermissionGranted();
                  if (!hasPermission) {
                    await notificationGateway.requestPermission();
                    ref.invalidate(notificationPermissionGrantedProvider);
                  }
                  final settings = ref.read(reminderSettingsControllerProvider);
                  final goalSettings = await ref.read(
                    savedGoalScheduleSettingsProvider.future,
                  );
                  final now = ref.read(timeContextProvider).now;
                  await ref
                      .read(bedtimeReminderSchedulerProvider)
                      .scheduleForCurrentSettings(
                        settings: settings,
                        goalSettings: goalSettings,
                        now: now,
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 展示通知权限摘要，避免提醒页在系统授权变化后仍停留旧状态。
class _NotificationPermissionCard extends StatelessWidget {
  const _NotificationPermissionCard({
    required this.permissionAsync,
  });

  final AsyncValue<bool> permissionAsync;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);
    final isGranted = permissionAsync.asData?.value ?? false;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isGranted ? colorScheme.primaryContainer : colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Text(
        isGranted
            ? l10n.notificationSettingsPermissionGranted
            : l10n.notificationSettingsPermissionMissing,
        style: textTheme.bodyMedium?.copyWith(
          color: isGranted ? colorScheme.primary : colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
          height: 1.4,
        ),
      ),
    );
  }
}
