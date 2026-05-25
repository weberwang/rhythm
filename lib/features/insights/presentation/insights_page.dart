import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/insights/application/insights_controller.dart';
import 'package:rhythm/features/insights/application/insights_view_state.dart';
import 'package:rhythm/features/insights/presentation/insights_copy_resolver.dart';
import 'package:rhythm/features/insights/presentation/widgets/sections/reason_distribution_section.dart';
import 'package:rhythm/features/insights/presentation/widgets/sections/recovery_effect_section.dart';
import 'package:rhythm/features/insights/presentation/widgets/sections/stability_section.dart';
import 'package:rhythm/features/insights/presentation/widgets/sections/weekly_report_summary_section.dart';
import 'package:rhythm/features/insights/presentation/widgets/sheets/recovery_plan_detail_sheet.dart';
import 'package:rhythm/features/insights/presentation/widgets/sheets/stability_explainer_sheet.dart';
import 'package:rhythm/features/insights/presentation/widgets/states/insights_empty_state.dart';
import 'package:rhythm/features/membership/application/membership_service.dart';
import 'package:rhythm/features/membership/domain/membership_paywall_policy.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 洞察首页，负责承接周报摘要、稳定度、原因分布和恢复效果四个核心区块。
class InsightsPage extends HookConsumerWidget {
  /// 创建洞察首页。
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final stateAsync = ref.watch(insightsControllerProvider);

    return stateAsync.when(
      data: (state) => _InsightsBody(state: state, l10n: l10n, ref: ref),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => InsightsEmptyState(
        title: l10n.insightsTitle,
        description: l10n.insightsDescription,
      ),
    );
  }
}

class _InsightsBody extends StatelessWidget {
  const _InsightsBody({
    required this.state,
    required this.l10n,
    required this.ref,
  });

  final InsightsViewState state;
  final AppLocalizations l10n;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    if (state.status != InsightsStatus.ready || state.weeklyReport == null) {
      return InsightsEmptyState(
        title: l10n.insightsTitle,
        description: l10n.insightsDescription,
      );
    }

    final report = state.weeklyReport!;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WeeklyReportSummarySection(
            report: report,
            onViewDetail: () => context.go(weeklyReportDetailPath),
          ),
          const SizedBox(height: 18),
          if (state.stabilityScore != null) ...[
            StabilitySection(
              score: state.stabilityScore!,
              onExplain: () => _openStabilityExplainer(context),
            ),
            const SizedBox(height: 18),
          ],
          ReasonDistributionSection(items: report.reasonDistribution),
          const SizedBox(height: 18),
          RecoveryEffectSection(
            plan: state.recoveryPlan,
            onOpenPlan: () => _openRecoveryPlan(context),
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => context.go(insightsHistoryPath),
              child: Text(l10n.insightsViewHistoryButton),
            ),
          ),
        ],
      ),
    );
  }

  /// 打开稳定度说明前先做会员能力判断，避免免费版直接进入深度解释弹层。
  Future<void> _openStabilityExplainer(BuildContext context) async {
    final access = await ref.read(membershipServiceProvider).evaluateAccess(
      entryContext: PaywallEntryContext.stabilityExplainer,
    );
    if (!context.mounted) {
      return;
    }
    if (access.isBlocked) {
      context.go(membershipPaywallPath);
      return;
    }
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StabilityExplainerSheet(score: state.stabilityScore!);
      },
    );
  }

  /// 打开恢复计划详情前先做会员能力判断，保持“高意图点击后再拦截”的策略边界。
  Future<void> _openRecoveryPlan(BuildContext context) async {
    final plan = state.recoveryPlan;
    if (plan == null) {
      return;
    }

    final access = await ref.read(membershipServiceProvider).evaluateAccess(
      entryContext: PaywallEntryContext.recoveryPlanDetail,
    );
    if (!context.mounted) {
      return;
    }
    if (access.isBlocked) {
      context.go(membershipPaywallPath);
      return;
    }
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return RecoveryPlanDetailSheet(plan: plan);
      },
    );
  }
}
