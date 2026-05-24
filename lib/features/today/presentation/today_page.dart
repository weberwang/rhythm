import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../application/today_controller.dart';
import '../application/today_view_state.dart';
import '../domain/today_primary_action.dart';
import 'widgets/sections/today_action_section.dart';
import 'widgets/sections/today_quick_actions_section.dart';
import 'widgets/sections/today_recovery_section.dart';
import 'widgets/sections/today_status_section.dart';
import 'widgets/sections/today_trend_section.dart';
import 'widgets/states/today_empty_state.dart';

/// 今日页入口，当前先承接既有占位行为，后续阶段四再逐步替换为真实区块。
class TodayPage extends HookConsumerWidget {
  /// 创建今日页。
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);
    final stateAsync = ref.watch(todayControllerProvider);

    useEffect(() {
      return null;
    }, const []);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: stateAsync.when(
        data: (state) => _TodayPageBody(
          pageTitle: l10n.todayPageTitle,
          textTheme: textTheme,
          state: state,
          l10n: l10n,
          onOpenGoalSetup: () => context.go(onboardingGoalSetupPath),
          onOpenPermissionHelp: () => context.go(sleepRecordsHubPath),
          onManualRecord: () => context.go(manualSleepRecordPath),
          onOpenBedtime: () => context.go(RhythmTab.bedtime.path),
          onOpenRecovery: () => context.go(RhythmTab.insights.path),
          onOpenRecordsHub: () => context.go(sleepRecordsHubPath),
        ),
        loading: () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.todayPageTitle, style: textTheme.headlineMedium),
            const SizedBox(height: 24),
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
        error: (error, stackTrace) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.todayPageTitle, style: textTheme.headlineMedium),
            const SizedBox(height: 24),
            const Expanded(
              child: TodayEmptyState(
                title: '系统睡眠记录暂时不可用',
                primaryAction: todayPrimaryActionPlaceholderPermission,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 承载今日页首屏编排，避免主页面继续堆叠状态分支和区块细节。
class _TodayPageBody extends StatelessWidget {
  /// 创建今日页内容体。
  const _TodayPageBody({
    required this.pageTitle,
    required this.textTheme,
    required this.state,
    required this.l10n,
    required this.onOpenGoalSetup,
    required this.onOpenPermissionHelp,
    required this.onManualRecord,
    required this.onOpenBedtime,
    required this.onOpenRecovery,
    required this.onOpenRecordsHub,
  });

  final String pageTitle;
  final TextTheme textTheme;
  final TodayViewState state;
  final AppLocalizations l10n;
  final VoidCallback onOpenGoalSetup;
  final VoidCallback onOpenPermissionHelp;
  final VoidCallback onManualRecord;
  final VoidCallback onOpenBedtime;
  final VoidCallback onOpenRecovery;
  final VoidCallback onOpenRecordsHub;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(pageTitle, style: textTheme.headlineMedium),
        const SizedBox(height: 24),
        Expanded(child: _buildContent()),
      ],
    );
  }

  Widget _buildContent() {
    switch (state.status) {
      case TodayViewStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case TodayViewStatus.goalMissing:
        return TodayEmptyState(
          title: l10n.todayGoalMissingTitle,
          primaryAction: todayPrimaryActionPlaceholderGoalSetup,
        );
      case TodayViewStatus.permissionFailed:
        return TodayEmptyState(
          title: l10n.todayPermissionFailedTitle,
          primaryAction: todayPrimaryActionPlaceholderPermission,
        );
      case TodayViewStatus.empty:
        return TodayEmptyState(
          title: l10n.todayEmptyTitle,
          primaryAction: todayPrimaryActionPlaceholderManual,
        );
      case TodayViewStatus.ready:
        final summary = state.summary!;
        final primaryActionHandler = switch (summary.primaryAction) {
          TodayPrimaryAction.enterBedtimeMode => onOpenBedtime,
          TodayPrimaryAction.manualRecord => onManualRecord,
          TodayPrimaryAction.openPermissionHelp => onOpenPermissionHelp,
          TodayPrimaryAction.openGoalSetup => onOpenGoalSetup,
          TodayPrimaryAction.viewRecoveryPlan => onOpenRecovery,
        };
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TodayStatusSection(summary: summary),
              const SizedBox(height: 12),
              TodayActionSection(
                primaryAction: summary.primaryAction,
                targetBedtimeMinutes: summary.targetBedtimeMinutes,
                onPressed: primaryActionHandler,
              ),
              if (state.prioritizeRecoveryCard) ...[
                const SizedBox(height: 12),
                const TodayRecoverySection(),
              ],
              const SizedBox(height: 12),
              TodayQuickActionsSection(
                onManualRecord: onManualRecord,
                onEditRecord: onOpenRecordsHub,
                onOpenRecordsHub: onOpenRecordsHub,
              ),
              const SizedBox(height: 12),
              TodayTrendSection(offsets: summary.trendOffsets.take(7).toList()),
            ],
          ),
        );
    }
  }
}

const todayPrimaryActionPlaceholderManual = TodayPrimaryAction.manualRecord;
const todayPrimaryActionPlaceholderPermission =
    TodayPrimaryAction.openPermissionHelp;
const todayPrimaryActionPlaceholderGoalSetup =
    TodayPrimaryAction.openGoalSetup;
