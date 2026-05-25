import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/notifications/application/reminder_settings_controller.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示阶段八“我的页”首页，统一承载账号卡、二级设置入口和桌面存在感提示。
class ProfilePage extends HookConsumerWidget {
  /// 创建我的页首页。
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final goalSettingsAsync = ref.watch(savedGoalScheduleSettingsProvider);
    final reminderSettings = ref.watch(reminderSettingsControllerProvider);
    final healthStateAsync = ref.watch(healthPlatformStateProvider);
    final timezoneName = ref.watch(timeContextProvider).timezoneName;
    final l10n = AppLocalizations.of(context);

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProfileHeroCard(
              title: l10n.profileHeroAnonymousTitle,
              subtitle: l10n.profileHeroAnonymousSubtitle,
              badgeLabel: l10n.profileHeroBadgeLabel,
              onTap: () => context.go('/profile/account-sync'),
            ),
            const SizedBox(height: 18),
            _EntryListCard(
              entries: [
                _ProfileEntry(
                  title: l10n.profileMembershipEntryTitle,
                  subtitle: l10n.profileMembershipEntrySubtitle,
                  onTap: () => context.go(membershipCenterPath),
                ),
                _ProfileEntry(
                  title: l10n.profileGoalScheduleEntryTitle,
                  subtitle: goalSettingsAsync.when(
                    data: (settings) => settings == null
                        ? l10n.profileGoalScheduleEntryEmpty
                        : _formatGoalSummary(settings),
                    loading: () => l10n.profileGoalScheduleEntryLoading,
                    error: (error, stackTrace) =>
                        l10n.profileGoalScheduleEntryError,
                  ),
                  onTap: () => context.go('/profile/goal-schedule'),
                ),
                _ProfileEntry(
                  title: l10n.profileNotificationEntryTitle,
                  subtitle: reminderSettings.softReminderEnabled
                      ? l10n.profileNotificationEntryEnabled
                      : l10n.profileNotificationEntryDisabled,
                  onTap: () => context.go('/profile/notifications'),
                ),
                _ProfileEntry(
                  title: l10n.profileDataAccessEntryTitle,
                  subtitle: healthStateAsync.when(
                    data: (state) => _healthSummary(l10n, state),
                    loading: () => l10n.profileDataAccessEntryLoading,
                    error: (error, stackTrace) =>
                        l10n.profileDataAccessEntryError,
                  ),
                  onTap: () => context.go('/profile/data-access'),
                ),
                _ProfileEntry(
                  title: l10n.profileTimezoneModeEntryTitle,
                  subtitle: l10n.profileTimezoneModeEntrySubtitle(timezoneName),
                  onTap: () => context.go('/profile/timezone-mode'),
                ),
                _ProfileEntry(
                  title: l10n.profilePrivacyEntryTitle,
                  subtitle: l10n.profilePrivacyEntrySubtitle,
                  onTap: () => context.go('/profile/privacy'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            _InfoCard(
              title: l10n.profileDesktopPresenceTitle,
              description: l10n.profileDesktopPresenceDescription,
              backgroundColor: const Color(0xFFE8F0E1),
              titleStyle: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              onTap: () => context.go(profileWidgetThemePath),
            ),
          ],
        ),
      ),
    );
  }

  /// 统一格式化首页里的目标作息摘要，避免页面层重复拼接时间文案。
  String _formatGoalSummary(GoalScheduleSettings settings) {
    final bedtimeHour = (settings.targetBedtimeMinutes ~/ 60)
        .toString()
        .padLeft(2, '0');
    final bedtimeMinute = (settings.targetBedtimeMinutes % 60)
        .toString()
        .padLeft(2, '0');
    final wakeHour = (settings.targetWakeMinutes ~/ 60).toString().padLeft(
      2,
      '0',
    );
    final wakeMinute = (settings.targetWakeMinutes % 60).toString().padLeft(
      2,
      '0',
    );
    return '$bedtimeHour:$bedtimeMinute / $wakeHour:$wakeMinute';
  }

  String _healthSummary(AppLocalizations l10n, HealthPlatformState state) {
    switch (state.platformCode) {
      case 'ios_available':
        return l10n.profileHealthSummaryHealthKitConnected;
      case 'android_available':
        return l10n.profileHealthSummaryHealthConnectConnected;
      case 'ios_permission_required':
      case 'android_permission_required':
        return l10n.profileHealthSummaryPermissionRequired;
      default:
        return l10n.profileHealthSummaryManualFallback;
    }
  }
}

/// 承载我的页顶部账号卡，作为进入账号与同步页的入口。
class _ProfileHeroCard extends StatelessWidget {
  /// 创建顶部账号卡。
  const _ProfileHeroCard({
    required this.title,
    required this.subtitle,
    required this.badgeLabel,
    required this.onTap,
  });

  /// 账号卡主标题。
  final String title;

  /// 账号卡副标题。
  final String subtitle;

  /// 账号卡角标。
  final String badgeLabel;

  /// 点击后进入账号与同步页。
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF1B3A28),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2C5F3B),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: textTheme.bodySmall?.copyWith(
                          color: const Color(0xFFD7E7DA),
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFF264735),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                badgeLabel,
                style: textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 承载我的页入口列表卡，避免页面层重复拼接分隔线和点击反馈。
class _EntryListCard extends StatelessWidget {
  /// 创建入口列表卡。
  const _EntryListCard({required this.entries});

  /// 需要渲染的入口列表。
  final List<_ProfileEntry> entries;

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
          for (var index = 0; index < entries.length; index++) ...[
            _ProfileEntryTile(entry: entries[index]),
            if (index != entries.length - 1)
              const Divider(height: 1, indent: 16, endIndent: 16),
          ],
        ],
      ),
    );
  }
}

/// 承载我的页单条入口配置，统一描述标题、副标题和跳转行为。
class _ProfileEntry {
  /// 创建入口配置。
  const _ProfileEntry({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  /// 入口标题。
  final String title;

  /// 入口副标题。
  final String subtitle;

  /// 点击后的跳转动作。
  final VoidCallback onTap;
}

/// 渲染我的页单条入口，保持设计稿中的“标题 + 副标题 + 右箭头”层级。
class _ProfileEntryTile extends StatelessWidget {
  /// 创建入口渲染组件。
  const _ProfileEntryTile({required this.entry});

  /// 入口配置。
  final _ProfileEntry entry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: entry.onTap,
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
                    entry.title,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.subtitle,
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

/// 统一承载简单说明卡，避免我的页底部说明和二级页提示卡重复拼装样式。
class _InfoCard extends StatelessWidget {
  /// 创建说明卡。
  const _InfoCard({
    required this.title,
    required this.description,
    this.backgroundColor,
    this.titleStyle,
    this.onTap,
  });

  /// 卡片标题。
  final String title;

  /// 卡片说明。
  final String description;

  /// 可选背景色。
  final Color? backgroundColor;

  /// 标题样式。
  final TextStyle? titleStyle;

  /// 可选点击动作，用于把说明卡升级为明确入口。
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ?? Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );

    if (onTap == null) {
      return content;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: content,
    );
  }
}
