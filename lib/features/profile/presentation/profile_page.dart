import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/app/router/secondary_navigation.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/notifications/application/reminder_settings_controller.dart';
import 'package:rhythm/features/preferences/application/app_preferences_providers.dart';
import 'package:rhythm/features/preferences/domain/app_locale_preference.dart';
import 'package:rhythm/features/preferences/domain/app_theme_preference.dart';
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
              onTap: () => context.pushSecondary(profileAccountSyncPath),
            ),
            const SizedBox(height: 18),
            const _ProfilePreferencesCard(),
            const SizedBox(height: 18),
            _EntryListCard(
              entries: [
                _ProfileEntry(
                  title: l10n.profileMembershipEntryTitle,
                  subtitle: l10n.profileMembershipEntrySubtitle,
                  onTap: () => context.pushSecondary(membershipCenterPath),
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
                  onTap: () => context.pushSecondary(profileGoalSchedulePath),
                ),
                _ProfileEntry(
                  title: l10n.profileNotificationEntryTitle,
                  subtitle: reminderSettings.softReminderEnabled
                      ? l10n.profileNotificationEntryEnabled
                      : l10n.profileNotificationEntryDisabled,
                  onTap: () =>
                      context.pushSecondary(profileNotificationSettingsPath),
                ),
                _ProfileEntry(
                  title: l10n.profileDataAccessEntryTitle,
                  subtitle: healthStateAsync.when(
                    data: (state) => _healthSummary(l10n, state),
                    loading: () => l10n.profileDataAccessEntryLoading,
                    error: (error, stackTrace) =>
                        l10n.profileDataAccessEntryError,
                  ),
                  onTap: () => context.pushSecondary(profileDataAccessPath),
                ),
                _ProfileEntry(
                  title: l10n.profileTimezoneModeEntryTitle,
                  subtitle: l10n.profileTimezoneModeEntrySubtitle(timezoneName),
                  onTap: () => context.pushSecondary(profileTimezoneModePath),
                ),
                _ProfileEntry(
                  title: l10n.profilePrivacyEntryTitle,
                  subtitle: l10n.profilePrivacyEntrySubtitle,
                  onTap: () => context.pushSecondary(profilePrivacyDataPath),
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
              onTap: () => context.pushSecondary(profileWidgetThemePath),
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

/// 承载我的页内的轻量偏好切换，统一处理语言与主题的即时生效体验。
class _ProfilePreferencesCard extends HookConsumerWidget {
  /// 创建偏好设置卡片。
  const _ProfilePreferencesCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final preferences = ref.watch(appPreferencesControllerProvider);

    return Container(
      key: const Key('profile-preferences-card'),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? colorScheme.surfaceContainerHighest
            : const Color(0xFFF1F6EE),
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
            l10n.profilePreferencesCardTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          _PreferenceSection<AppLocalePreference>(
            title: l10n.profilePreferencesLocaleTitle,
            currentValueLabel: _localePreferenceLabel(
              l10n,
              preferences.localePreference,
            ),
            selectedValue: preferences.localePreference,
            options: [
              _PreferenceOption<AppLocalePreference>(
                value: AppLocalePreference.system,
                label: l10n.profilePreferencesFollowSystem,
                key: const Key('profile-preferences-locale-system'),
              ),
              _PreferenceOption<AppLocalePreference>(
                value: AppLocalePreference.simplifiedChinese,
                label: l10n.profilePreferencesSimplifiedChinese,
                key: const Key('profile-preferences-locale-zh'),
              ),
              _PreferenceOption<AppLocalePreference>(
                value: AppLocalePreference.english,
                label: l10n.profilePreferencesEnglish,
                key: const Key('profile-preferences-locale-english'),
              ),
            ],
            onSelected: (value) async {
              if (value == preferences.localePreference) {
                return;
              }
              final succeeded = await ref
                  .read(appPreferencesControllerProvider.notifier)
                  .updateLocale(value);
              if (!context.mounted || succeeded) {
                return;
              }
              _showPreferenceSaveFailure(context, l10n);
            },
          ),
          const SizedBox(height: 16),
          _PreferenceSection<AppThemePreference>(
            title: l10n.profilePreferencesThemeTitle,
            currentValueLabel: _themePreferenceLabel(
              l10n,
              preferences.themePreference,
            ),
            selectedValue: preferences.themePreference,
            options: [
              _PreferenceOption<AppThemePreference>(
                value: AppThemePreference.system,
                label: l10n.profilePreferencesFollowSystem,
                key: const Key('profile-preferences-theme-system'),
              ),
              _PreferenceOption<AppThemePreference>(
                value: AppThemePreference.light,
                label: l10n.profilePreferencesLight,
                key: const Key('profile-preferences-theme-light'),
              ),
              _PreferenceOption<AppThemePreference>(
                value: AppThemePreference.dark,
                label: l10n.profilePreferencesDark,
                key: const Key('profile-preferences-theme-dark'),
              ),
            ],
            onSelected: (value) async {
              if (value == preferences.themePreference) {
                return;
              }
              final succeeded = await ref
                  .read(appPreferencesControllerProvider.notifier)
                  .updateTheme(value);
              if (!context.mounted || succeeded) {
                return;
              }
              _showPreferenceSaveFailure(context, l10n);
            },
          ),
        ],
      ),
    );
  }

  /// 解析语言偏好的展示值，确保摘要与选项文本保持一致。
  String _localePreferenceLabel(
    AppLocalizations l10n,
    AppLocalePreference preference,
  ) {
    switch (preference) {
      case AppLocalePreference.system:
        return l10n.profilePreferencesFollowSystem;
      case AppLocalePreference.simplifiedChinese:
        return l10n.profilePreferencesSimplifiedChinese;
      case AppLocalePreference.english:
        return l10n.profilePreferencesEnglish;
    }
  }

  /// 解析主题偏好的展示值，避免显示层重复维护主题文案映射。
  String _themePreferenceLabel(
    AppLocalizations l10n,
    AppThemePreference preference,
  ) {
    switch (preference) {
      case AppThemePreference.system:
        return l10n.profilePreferencesFollowSystem;
      case AppThemePreference.light:
        return l10n.profilePreferencesLight;
      case AppThemePreference.dark:
        return l10n.profilePreferencesDark;
    }
  }

  void _showPreferenceSaveFailure(BuildContext context, AppLocalizations l10n) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.profilePreferencesSaveFailed)),
    );
  }
}

/// 渲染偏好卡片中的单个设置分组，统一标题、摘要和三段式切换布局。
class _PreferenceSection<T> extends StatelessWidget {
  /// 创建偏好分组。
  const _PreferenceSection({
    required this.title,
    required this.currentValueLabel,
    required this.selectedValue,
    required this.options,
    required this.onSelected,
  });

  /// 分组标题。
  final String title;

  /// 当前生效值摘要。
  final String currentValueLabel;

  /// 当前选中的值。
  final T selectedValue;

  /// 可切换的选项列表。
  final List<_PreferenceOption<T>> options;

  /// 点击某个选项后的处理逻辑。
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              currentValueLabel,
              style: theme.textTheme.labelLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Row(
            children: [
              for (var index = 0; index < options.length; index++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      index == 0 ? 4 : 2,
                      4,
                      index == options.length - 1 ? 4 : 2,
                      4,
                    ),
                    child: _PreferenceOptionButton<T>(
                      option: options[index],
                      selected: selectedValue == options[index].value,
                      onTap: () => onSelected(options[index].value),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 描述偏好卡片中的一个可选项，统一封装值、文案和测试 key。
class _PreferenceOption<T> {
  /// 创建偏好选项。
  const _PreferenceOption({
    required this.value,
    required this.label,
    required this.key,
  });

  /// 选项实际值。
  final T value;

  /// 展示给用户的标签。
  final String label;

  /// 用于测试定位的稳定 key。
  final Key key;
}

/// 渲染偏好卡片中的单个选项按钮，保持选中态与未选中态层级清晰。
class _PreferenceOptionButton<T> extends StatelessWidget {
  /// 创建偏好选项按钮。
  const _PreferenceOptionButton({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  /// 当前渲染的选项。
  final _PreferenceOption<T> option;

  /// 是否为当前选中项。
  final bool selected;

  /// 点击后的回调。
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      key: option.key,
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? colorScheme.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            option.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelLarge?.copyWith(
              color: selected
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
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
