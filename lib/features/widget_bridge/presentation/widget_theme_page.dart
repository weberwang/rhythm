import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/app/router/secondary_navigation.dart';
import 'package:rhythm/core/presentation/widgets/secondary_page_header.dart';
import 'package:rhythm/features/preferences/application/app_preferences_providers.dart';
import 'package:rhythm/features/preferences/domain/app_theme_preference.dart';
import 'package:rhythm/features/widget_bridge/application/widget_snapshot_service.dart';
import 'package:rhythm/features/widget_bridge/data/home_widget_gateway.dart';
import 'package:rhythm/features/widget_bridge/domain/widget_snapshot.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示小组件预览、刷新入口和主题切换的二级设置页。
class WidgetThemePage extends HookConsumerWidget {
  /// 创建小组件与主题页。
  const WidgetThemePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final snapshotAsync = ref.watch(widgetThemeSnapshotProvider);
    final preferences = ref.watch(appPreferencesControllerProvider);
    final refreshing = useState(false);

    Future<void> refreshSnapshot() async {
      if (refreshing.value) {
        return;
      }

      refreshing.value = true;
      try {
        final gateway = ref.read(homeWidgetGatewayProvider);
        final installationState = await gateway.getInstallationState();
        if (installationState == HomeWidgetInstallationState.notInstalled) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.widgetThemeRefreshUnavailable)),
            );
          }
          return;
        }
        final snapshot = await ref.read(widgetThemeSnapshotProvider.future);
        await gateway.saveSnapshot(snapshot);
        await gateway.refresh();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.widgetThemeRefreshSuccess)),
          );
        }
      } catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.widgetThemeRefreshFailure)),
          );
        }
      } finally {
        refreshing.value = false;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: snapshotAsync.when(
          data: (snapshot) => _WidgetThemeBody(
            snapshot: snapshot,
            themePreference: preferences.themePreference,
            refreshing: refreshing.value,
            onRefresh: refreshSnapshot,
            onThemeSelected: (preference) async {
              if (preference == preferences.themePreference) {
                return;
              }
              final succeeded = await ref
                  .read(appPreferencesControllerProvider.notifier)
                  .updateTheme(preference);
              if (!context.mounted || succeeded) {
                return;
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.profilePreferencesSaveFailed)),
              );
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(l10n.widgetThemeRefreshFailure),
            ),
          ),
        ),
      ),
    );
  }
}

/// 承载小组件与主题页的主结构，避免主页面堆叠过多条件分支。
class _WidgetThemeBody extends StatelessWidget {
  /// 创建页面主体。
  const _WidgetThemeBody({
    required this.snapshot,
    required this.themePreference,
    required this.refreshing,
    required this.onRefresh,
    required this.onThemeSelected,
  });

  /// 当前页面预览快照。
  final WidgetSnapshot snapshot;

  /// 当前主题偏好。
  final AppThemePreference themePreference;

  /// 是否正在刷新小组件。
  final bool refreshing;

  /// 刷新动作。
  final Future<void> Function() onRefresh;

  /// 主题切换动作。
  final ValueChanged<AppThemePreference> onThemeSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SecondaryPageHeader(
                    title: l10n.widgetThemePageTitle,
                    fallbackLocation: RhythmTab.profile.path,
                    titleStyle: textTheme.headlineSmall?.copyWith(
                      fontFamily: 'Funnel Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _WidgetPreviewCard(snapshot: snapshot),
                  const SizedBox(height: 12),
                  _WidgetStateCard(snapshot: snapshot),
                  const SizedBox(height: 12),
                  _ThemeSelectorCard(
                    selectedPreference: themePreference,
                    onSelected: onThemeSelected,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            key: const Key('widget-theme-refresh-button'),
            onPressed: refreshing ? null : onRefresh,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
            child: Text(
              refreshing
                  ? l10n.widgetThemeRefreshingButton
                  : l10n.widgetThemeRefreshButton,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.go(RhythmTab.today.path),
                  child: Text(l10n.widgetThemeOpenTodayButton),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.tonal(
                  onPressed: () => context.go(bedtimeModePath),
                  child: Text(l10n.widgetThemeOpenBedtimeButton),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 桌面预览卡，只展示允许暴露的目标与昨晚状态摘要。
class _WidgetPreviewCard extends StatelessWidget {
  /// 创建桌面预览卡。
  const _WidgetPreviewCard({required this.snapshot});

  /// 当前预览快照。
  final WidgetSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
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
          Text(
            l10n.widgetThemePreviewTitle,
            style: textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.targetBedtimeLabel ?? '--:--',
                      style: textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontFamily: 'IBM Plex Mono',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.widgetThemePreviewTargetCaption,
                      style: textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFD7E7DA),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _lastNightLine(l10n),
                      style: textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFD7E7DA),
                        height: 1.35,
                      ),
                    ),
                    if (snapshot.minutesToTarget != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        _targetDeltaLabel(l10n, snapshot.minutesToTarget!),
                        style: textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const _ThemePreviewBlocks(),
            ],
          ),
        ],
      ),
    );
  }

  String _lastNightLine(AppLocalizations l10n) {
    return snapshot.lastNightStatusLabel ??
        switch (snapshot.state) {
          WidgetSnapshotState.goalMissing =>
            l10n.widgetThemeStateGoalMissingTitle,
          WidgetSnapshotState.noData => l10n.widgetThemePreviewLastNightMissing,
          WidgetSnapshotState.permissionRequired =>
            l10n.widgetThemeStatePermissionTitle,
          WidgetSnapshotState.ready => l10n.widgetThemePreviewLastNightMissing,
        };
  }

  String _targetDeltaLabel(AppLocalizations l10n, int minutes) {
    if (minutes < 0) {
      return l10n.widgetThemeMinutesToTargetLate(minutes.abs());
    }
    return l10n.widgetThemeMinutesToTargetAhead(minutes);
  }
}

/// 预览卡右侧占位块，延续设计稿中的轻量桌面视觉层级。
class _ThemePreviewBlocks extends StatelessWidget {
  /// 创建预览占位块集合。
  const _ThemePreviewBlocks();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _ThemePreviewBlock(height: 42),
        SizedBox(height: 8),
        _ThemePreviewBlock(height: 58),
        SizedBox(height: 8),
        _ThemePreviewBlock(height: 35),
      ],
    );
  }
}

/// 预览卡中的单个占位块。
class _ThemePreviewBlock extends StatelessWidget {
  /// 创建占位块。
  const _ThemePreviewBlock({required this.height});

  /// 当前占位块高度。
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF2C5F3B),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

/// 小组件状态卡，统一承载目标缺失、无数据和未授权三类说明及操作入口。
class _WidgetStateCard extends StatelessWidget {
  /// 创建状态卡。
  const _WidgetStateCard({required this.snapshot});

  /// 当前页面快照。
  final WidgetSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final stateCopy = _stateCopy(l10n);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stateCopy.title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            stateCopy.description,
            style: textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          if (stateCopy.actionLabel != null) ...[
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => _handleAction(context),
              child: Text(stateCopy.actionLabel!),
            ),
          ],
        ],
      ),
    );
  }

  _WidgetStateCopy _stateCopy(AppLocalizations l10n) {
    return switch (snapshot.state) {
      WidgetSnapshotState.goalMissing => _WidgetStateCopy(
        title: l10n.widgetThemeStateGoalMissingTitle,
        description: l10n.widgetThemeStateGoalMissingDescription,
        actionLabel: l10n.widgetThemeStateGoalMissingAction,
      ),
      WidgetSnapshotState.noData => _WidgetStateCopy(
        title: l10n.widgetThemeStateNoDataTitle,
        description: l10n.widgetThemeStateNoDataDescription,
        actionLabel: l10n.widgetThemeStateNoDataAction,
      ),
      WidgetSnapshotState.permissionRequired => _WidgetStateCopy(
        title: l10n.widgetThemeStatePermissionTitle,
        description: l10n.widgetThemeStatePermissionDescription,
        actionLabel: l10n.widgetThemeStatePermissionAction,
      ),
      WidgetSnapshotState.ready => _WidgetStateCopy(
        title:
            snapshot.lastNightStatusLabel ?? l10n.widgetThemeStateNoDataTitle,
        description: l10n.widgetThemeStateReadyDescription,
      ),
    };
  }

  void _handleAction(BuildContext context) {
    switch (snapshot.state) {
      case WidgetSnapshotState.goalMissing:
        // 目标设置页属于二级设置页，需要保留当前来源页返回路径。
        context.pushSecondary(onboardingGoalSetupPath);
      case WidgetSnapshotState.noData:
        context.pushSecondary(manualSleepRecordPath);
      case WidgetSnapshotState.permissionRequired:
        context.pushSecondary(profileDataAccessPath);
      case WidgetSnapshotState.ready:
        break;
    }
  }
}

/// 主题选择卡，直接复用全局主题偏好能力，避免页面继续停留在视觉占位。
class _ThemeSelectorCard extends StatelessWidget {
  /// 创建主题选择卡。
  const _ThemeSelectorCard({
    required this.selectedPreference,
    required this.onSelected,
  });

  /// 当前选中的主题偏好。
  final AppThemePreference selectedPreference;

  /// 主题切换动作。
  final ValueChanged<AppThemePreference> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final options = <({AppThemePreference preference, String label, Key key})>[
      (
        preference: AppThemePreference.system,
        label: l10n.profilePreferencesFollowSystem,
        key: const Key('widget-theme-option-system'),
      ),
      (
        preference: AppThemePreference.light,
        label: l10n.profilePreferencesLight,
        key: const Key('widget-theme-option-light'),
      ),
      (
        preference: AppThemePreference.dark,
        label: l10n.profilePreferencesDark,
        key: const Key('widget-theme-option-dark'),
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.profilePreferencesThemeTitle,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final option in options)
                _ThemeChip(
                  key: option.key,
                  text: option.label,
                  selected: selectedPreference == option.preference,
                  onTap: () => onSelected(option.preference),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 主题选项标签，保持当前页面切换操作轻量直接。
class _ThemeChip extends StatelessWidget {
  /// 创建主题标签。
  const _ThemeChip({
    super.key,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  /// 标签文案。
  final String text;

  /// 是否为当前选中项。
  final bool selected;

  /// 点击动作。
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1B3A28) : const Color(0xFFD7E7DA),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: selected ? Colors.white : const Color(0xFF1B3A28),
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// 小组件状态卡的文案载体，避免构建时散落多组 if/else。
class _WidgetStateCopy {
  /// 创建状态文案。
  const _WidgetStateCopy({
    required this.title,
    required this.description,
    this.actionLabel,
  });

  /// 状态标题。
  final String title;

  /// 状态说明。
  final String description;

  /// 可选动作按钮文案。
  final String? actionLabel;
}
