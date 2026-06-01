import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/app/router/secondary_navigation.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/preferences/application/app_preferences_providers.dart';
import 'package:rhythm/features/preferences/domain/app_locale_preference.dart';
import 'package:rhythm/features/preferences/domain/app_theme_preference.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/features/profile/presentation/widgets/profile_visual_blocks.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

/// “我的”页入口，按 Pencil 稿重组为账户概览、会员同步、目标提醒、显示设备和隐私导出几个区块。
class ProfilePage extends HookConsumerWidget {
  /// 创建我的页首页。
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalSettingsAsync = ref.watch(savedGoalScheduleSettingsProvider);
    final healthStateAsync = ref.watch(healthPlatformStateProvider);
    final timezoneName = ref.watch(timeContextProvider).timezoneName;
    final l10n = AppLocalizations.of(context);
    final preferencesCardKey = useMemoized(GlobalKey.new);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.surface.withValues(alpha: 0.98),
            Theme.of(context).scaffoldBackgroundColor,
          ],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ProfileSummaryHeroCard(l10n: l10n),
              const SizedBox(height: 18),
              ProfileGlassCard(
                key: const Key('profile-membership-card'),
                title: l10n.profileMembershipSyncCardTitle,
                description: l10n.profileMembershipEntrySubtitle,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        ProfileStatusChip(
                          icon: Icons.auto_awesome_rounded,
                          label: l10n.profileHeroBadgeLabel,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withValues(alpha: 0.44),
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                        ),
                        ProfileStatusChip(
                          icon: Icons.cloud_outlined,
                          label: l10n.accountSyncCloudIdentityPendingTitle,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .tertiaryContainer
                              .withValues(alpha: 0.42),
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onTertiaryContainer,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        ProfileRoutePill(
                          label: l10n.profileMembershipEntryTitle,
                          onTap: () =>
                              context.pushSecondary(membershipCenterPath),
                        ),
                        ProfileRoutePill(
                          label: l10n.accountSyncViewAccountButton,
                          onTap: () =>
                              context.pushSecondary(profileAccountSyncPath),
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .tertiaryContainer
                              .withValues(alpha: 0.42),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              ProfileGlassCard(
                title: l10n.profileGoalReminderCardTitle,
                description: _goalReminderDescription(l10n, goalSettingsAsync),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ProfileRoutePill(
                      label: l10n.profileGoalScheduleEntryTitle,
                      onTap: () =>
                          context.pushSecondary(profileGoalSchedulePath),
                    ),
                    ProfileRoutePill(
                      label: l10n.profileNotificationEntryTitle,
                      onTap: () => context.pushSecondary(
                        profileNotificationSettingsPath,
                      ),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.tertiaryContainer.withValues(alpha: 0.42),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              ProfileGlassCard(
                title: l10n.profileDisplayDeviceCardTitle,
                description: l10n.profileDesktopPresenceDescription,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        ProfileRoutePill(
                          label: l10n.profileDesktopPresenceTitle,
                          onTap: () =>
                              context.pushSecondary(profileWidgetThemePath),
                        ),
                        ProfileRoutePill(
                          label: l10n.profilePreferencesThemeTitle,
                          onTap: () {
                            final targetContext =
                                preferencesCardKey.currentContext;
                            if (targetContext == null) {
                              return;
                            }
                            Scrollable.ensureVisible(
                              targetContext,
                              duration: const Duration(milliseconds: 220),
                              curve: Curves.easeOutCubic,
                              alignment: 0.08,
                            );
                          },
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .secondaryContainer
                              .withValues(alpha: 0.42),
                        ),
                        ProfileRoutePill(
                          label: l10n.profileDataAccessEntryTitle,
                          onTap: () =>
                              context.pushSecondary(profileDataAccessPath),
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withValues(alpha: 0.44),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ProfileRoutePill(
                      label: l10n.profileTimezoneModeEntryTitle,
                      onTap: () =>
                          context.pushSecondary(profileTimezoneModePath),
                      width: double.infinity,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _healthSummary(l10n, healthStateAsync),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.profileTimezoneModeEntrySubtitle(timezoneName),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurfaceVariant.withValues(alpha: 0.82),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              _ProfilePreferencesCard(key: preferencesCardKey),
              const SizedBox(height: 18),
              ProfileGlassCard(
                title: l10n.profilePrivacyExportCardTitle,
                description: l10n.profilePrivacyEntrySubtitle,
                child: ProfileRoutePill(
                  label: l10n.profilePrivacyEntryTitle,
                  onTap: () => context.pushSecondary(profilePrivacyDataPath),
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 目标与提醒卡优先给出一条已汇总说明，避免用户进入“我的”后再看一串孤立入口。
  String _goalReminderDescription(
    AppLocalizations l10n,
    AsyncValue<GoalScheduleSettings?> goalSettingsAsync,
  ) {
    return goalSettingsAsync.when(
      data: (settings) => settings == null
          ? l10n.profileGoalScheduleEntryEmpty
          : '${_formatGoalSummary(settings)} · ${l10n.profileNotificationEntryEnabled}',
      loading: () => l10n.profileGoalScheduleEntryLoading,
      error: (error, stackTrace) => l10n.profileGoalScheduleEntryError,
    );
  }

  /// 统一格式化目标作息摘要，保持“我的”页首屏只给一个轻量结果。
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

  /// 数据接入摘要仍沿用现有平台状态映射，避免“我的”页另起一套口径。
  String _healthSummary(
    AppLocalizations l10n,
    AsyncValue<HealthPlatformState> healthStateAsync,
  ) {
    return healthStateAsync.when(
      data: (state) {
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
      },
      loading: () => l10n.profileDataAccessEntryLoading,
      error: (error, stackTrace) => l10n.profileDataAccessEntryError,
    );
  }
}

/// 顶部账户概览卡，用大语气先说明“我的”页的作用，再把身份状态压成胶囊。
class _ProfileSummaryHeroCard extends StatelessWidget {
  /// 创建顶部概览卡。
  const _ProfileSummaryHeroCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final heroTokens = theme.extension<RhythmHeroThemeExtension>();
    final textTheme = theme.textTheme;
    final heroForeground = heroTokens?.textColor ?? theme.colorScheme.onPrimary;
    final heroForegroundSoft = heroForeground.withValues(alpha: 0.88);
    final useSurfaceHero = theme.brightness == Brightness.dark;
    final titleColor = useSurfaceHero
        ? theme.colorScheme.onSurface
        : heroForeground;
    final subtitleColor = useSurfaceHero
        ? theme.colorScheme.onSurfaceVariant
        : heroForegroundSoft;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        key: const Key('profile-summary-hero-card'),
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        decoration: BoxDecoration(
          gradient: useSurfaceHero ? null : heroTokens?.gradient,
          color: useSurfaceHero
              ? theme.colorScheme.surfaceContainerHighest
              : theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: useSurfaceHero
                ? theme.colorScheme.outlineVariant
                : heroTokens?.borderColor ??
                      heroForeground.withValues(alpha: 0.32),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 26,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const ProfileHeroBadge(icon: Icons.nightlight_round),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    l10n.profileHeroSummaryTitle,
                    style: textTheme.headlineSmall?.copyWith(
                      color: titleColor,
                      fontWeight: FontWeight.w500,
                      height: 1.08,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              l10n.profileHeroSummarySubtitle,
              style: textTheme.bodyMedium?.copyWith(
                color: subtitleColor,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ProfileHeroChip(label: l10n.profileHeroAnonymousTitle),
                ProfileHeroChip(label: l10n.profileHeroBadgeLabel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 承载我的页内的轻量偏好切换，统一处理语言与主题的即时生效体验。
class _ProfilePreferencesCard extends HookConsumerWidget {
  /// 创建偏好设置卡片。
  const _ProfilePreferencesCard({super.key});

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
            : colorScheme.secondaryContainer.withValues(alpha: 0.44),
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
              context,
              l10n,
              preferences.localePreference,
            ),
            selectedValue: preferences.localePreference,
            options: [
              _PreferenceOption<AppLocalePreference>(
                value: AppLocalePreference.system,
                label: l10n.profilePreferencesSystemShort,
                key: const Key('profile-preferences-locale-system'),
              ),
              _PreferenceOption<AppLocalePreference>(
                value: AppLocalePreference.simplifiedChinese,
                label: l10n.profilePreferencesSimplifiedChineseNative,
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
                label: l10n.profilePreferencesSystemShort,
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
    BuildContext context,
    AppLocalizations l10n,
    AppLocalePreference preference,
  ) {
    switch (preference) {
      case AppLocalePreference.system:
        return _systemLocaleLabel(context, l10n);
      case AppLocalePreference.simplifiedChinese:
        return l10n.profilePreferencesSimplifiedChineseNative;
      case AppLocalePreference.english:
        return l10n.profilePreferencesEnglish;
    }
  }

  /// 解析系统实际语言名，确保“跟随系统”时展示的是当前生效语言而不是抽象状态。
  String _systemLocaleLabel(BuildContext context, AppLocalizations l10n) {
    final systemLocale = basicLocaleListResolution(
      View.of(context).platformDispatcher.locales,
      AppLocalizations.supportedLocales,
    );
    switch (systemLocale.languageCode) {
      case 'zh':
        return l10n.profilePreferencesSimplifiedChineseNative;
      case 'en':
        return l10n.profilePreferencesEnglish;
      default:
        return l10n.profilePreferencesFollowSystem;
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

  final String title;
  final String currentValueLabel;
  final T selectedValue;
  final List<_PreferenceOption<T>> options;
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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

  final T value;
  final String label;
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

  final _PreferenceOption<T> option;
  final bool selected;
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
