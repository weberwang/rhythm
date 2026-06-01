import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/insights/application/insights_controller.dart';
import 'package:rhythm/features/insights/application/insights_view_state.dart';
import 'package:rhythm/features/insights/domain/recovery_plan.dart';
import 'package:rhythm/features/insights/domain/stability_score_rules.dart';
import 'package:rhythm/features/insights/domain/weekly_report.dart';
import 'package:rhythm/features/insights/presentation/widgets/sheets/recovery_plan_detail_sheet.dart';
import 'package:rhythm/features/insights/presentation/widgets/sheets/stability_explainer_sheet.dart';
import 'package:rhythm/features/insights/presentation/widgets/states/insights_empty_state.dart';
import 'package:rhythm/features/membership/application/membership_service.dart';
import 'package:rhythm/features/membership/domain/membership_paywall_policy.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

/// 洞察首页，按 Pencil 稿重排为周度摘要、核心概览、原因分布、恢复效果和趋势区。
class InsightsPage extends HookConsumerWidget {
  /// 创建洞察首页。
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final stateAsync = ref.watch(insightsControllerProvider);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFF6F8FC),
            Theme.of(context).scaffoldBackgroundColor,
          ],
        ),
      ),
      child: stateAsync.when(
        data: (state) => _InsightsBody(state: state, l10n: l10n, ref: ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => InsightsEmptyState(
          title: l10n.insightsTitle,
          description: l10n.insightsDescription,
        ),
      ),
    );
  }
}

/// 首页内容体，只承接 ready/empty 分发和需要会员判断的动作回调。
class _InsightsBody extends StatelessWidget {
  /// 创建首页内容体。
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _InsightsHeroCard(
            title: _heroTitle(),
            subtitle: _heroSubtitle(report),
          ),
          const SizedBox(height: 18),
          _InsightsOverviewCard(
            l10n: l10n,
            report: report,
            onViewWeeklyReport: () => context.go(weeklyReportDetailPath),
          ),
          const SizedBox(height: 18),
          _InsightsReasonDistributionCard(
            l10n: l10n,
            items: report.reasonDistribution,
            primaryReasonLabel: report.summary.primaryReasonLabel,
          ),
          const SizedBox(height: 18),
          _InsightsRecoveryCard(
            l10n: l10n,
            plan: state.recoveryPlan,
            onOpenPlan: () => _openRecoveryPlan(context),
            onOpenHistory: () => context.go(insightsHistoryPath),
          ),
          const SizedBox(height: 18),
          _InsightsTrendCard(
            l10n: l10n,
            days: report.days,
            stabilityScore: state.stabilityScore,
            onOpenStability: () => _openStabilityExplainer(context),
          ),
        ],
      ),
    );
  }

  /// Hero 标题优先复用稳定度层级语义，避免再维护一套平行判断口径。
  String _heroTitle() {
    final score = state.stabilityScore;
    if (score == null) {
      return l10n.insightsNoWeeklyReport;
    }
    switch (score.level) {
      case StabilityScoreLevel.insufficient:
        return l10n.insightsStabilitySummaryInsufficient;
      case StabilityScoreLevel.steady:
        return l10n.insightsStabilitySummarySteady;
      case StabilityScoreLevel.recovering:
        return l10n.insightsStabilitySummaryRecovering;
      case StabilityScoreLevel.needsRecovery:
        return l10n.insightsStabilitySummaryNeedsRecovery;
    }
  }

  /// Hero 副标题沿用周报 headline，保持当前业务摘要口径不分叉。
  String _heroSubtitle(WeeklyReport report) {
    return l10n.insightsWeeklyHeadline(
      report.summary.onTrackRate,
      report.summary.stabilityScore,
      _weekdayLabel(report.summary.latestLateDayWeekday),
    );
  }

  /// 详情和说明弹层都依赖会员判断，页面重排时保持原有能力边界不变。
  Future<void> _openStabilityExplainer(BuildContext context) async {
    final score = state.stabilityScore;
    if (score == null) {
      return;
    }
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
      builder: (context) => StabilityExplainerSheet(score: score),
    );
  }

  /// 恢复计划详情继续沿用现有 paywall 策略，避免页面层跨越会员边界。
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
      builder: (context) => RecoveryPlanDetailSheet(plan: plan),
    );
  }

  /// 周几标签统一走洞察本地化缩写，避免在多处重复 switch。
  String _weekdayLabel(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return l10n.insightsWeekdayMon;
      case DateTime.tuesday:
        return l10n.insightsWeekdayTue;
      case DateTime.wednesday:
        return l10n.insightsWeekdayWed;
      case DateTime.thursday:
        return l10n.insightsWeekdayThu;
      case DateTime.friday:
        return l10n.insightsWeekdayFri;
      case DateTime.saturday:
        return l10n.insightsWeekdaySat;
      case DateTime.sunday:
      default:
        return l10n.insightsWeekdaySun;
    }
  }
}

/// 顶部周度摘要卡，承接当前一周的结论语气。
class _InsightsHeroCard extends StatelessWidget {
  /// 创建周度摘要卡。
  const _InsightsHeroCard({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final heroTokens = theme.extension<RhythmHeroThemeExtension>();
    final textTheme = theme.textTheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        decoration: BoxDecoration(
          gradient: heroTokens?.gradient,
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color:
                heroTokens?.borderColor ??
                Colors.white.withValues(alpha: 0.32),
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
                _InsightsHeroBadge(icon: Icons.nightlight_round),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      height: 1.08,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              subtitle,
              style: textTheme.bodyMedium?.copyWith(
                color: const Color(0xFFF0F3FF),
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 本周概览卡，聚合设计稿里最重要的三个指标。
class _InsightsOverviewCard extends StatelessWidget {
  /// 创建本周概览卡。
  const _InsightsOverviewCard({
    required this.l10n,
    required this.report,
    required this.onViewWeeklyReport,
  });

  final AppLocalizations l10n;
  final WeeklyReport report;
  final VoidCallback onViewWeeklyReport;

  @override
  Widget build(BuildContext context) {
    return _InsightsGlassCard(
      title: l10n.insightsWeeklyReportPageTitle,
      description: l10n.insightsWeeklyDescription(
        report.summary.primaryReasonLabel ?? l10n.insightsNoReasonTags,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _InsightsMetricTile(
                  title: l10n.insightsOnTrackRateLabel,
                  value: '${report.summary.onTrackRate}%',
                  backgroundColor: const Color(0xFFF8FAFF),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _InsightsMetricTile(
                  title: l10n.insightsStabilityLabel,
                  value: '${report.summary.stabilityScore}',
                  backgroundColor: const Color(0xFFFCFBF8),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _InsightsMetricTile(
                  title: l10n.insightsLatestLateTitle,
                  value: l10n.todayStatusLateBy(
                    report.summary.latestLateOffsetMinutes,
                  ),
                  backgroundColor: const Color(0xFFF8F7FB),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton.tonal(
              onPressed: onViewWeeklyReport,
              child: Text(l10n.insightsViewWeeklyReportButton),
            ),
          ),
        ],
      ),
    );
  }

}

/// 晚睡原因分布卡，用条形轨道还原设计稿的可比性。
class _InsightsReasonDistributionCard extends StatelessWidget {
  /// 创建原因分布卡。
  const _InsightsReasonDistributionCard({
    required this.l10n,
    required this.items,
    required this.primaryReasonLabel,
  });

  final AppLocalizations l10n;
  final List<ReasonDistributionItem> items;
  final String? primaryReasonLabel;

  @override
  Widget build(BuildContext context) {
    final description = primaryReasonLabel == null
        ? l10n.insightsNoReasonTags
        : l10n.insightsWeeklyDescription(primaryReasonLabel!);

    return _InsightsGlassCard(
      title: l10n.insightsReasonDistributionTitle,
      description: description,
      child: Column(
        children: [
          for (var index = 0; index < items.take(3).length; index++) ...[
            _InsightsReasonBar(item: items[index]),
            if (index != items.take(3).length - 1) const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}

/// 恢复效果卡，承接恢复计划摘要和历史入口。
class _InsightsRecoveryCard extends StatelessWidget {
  /// 创建恢复效果卡。
  const _InsightsRecoveryCard({
    required this.l10n,
    required this.plan,
    required this.onOpenPlan,
    required this.onOpenHistory,
  });

  final AppLocalizations l10n;
  final RecoveryPlan? plan;
  final VoidCallback onOpenPlan;
  final VoidCallback onOpenHistory;

  @override
  Widget build(BuildContext context) {
    final description = plan == null
        ? l10n.insightsRecoveryNoPlan
        : l10n.insightsRecoveryPlanSummary(plan!.horizonDays);

    return _InsightsGlassCard(
      title: l10n.insightsRecoveryEffectTitle,
      description: description,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF3FF),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: const Color(0xFFDCE7F8)),
            ),
            child: Text(
              plan == null
                  ? l10n.insightsRecoveryNoPlan
                  : l10n.insightsRecoveryPlanTitle(plan!.horizonDays),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFF4F5E9A),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FilledButton.tonal(
            onPressed: onOpenHistory,
            child: Text(l10n.insightsViewHistoryButton),
          ),
          OutlinedButton(
            onPressed: plan == null ? null : onOpenPlan,
            child: Text(l10n.insightsRecoveryPlanDetailTitle),
          ),
        ],
      ),
    );
  }
}

/// 趋势卡承接最近 7 天趋势和稳定度解释入口。
class _InsightsTrendCard extends StatelessWidget {
  /// 创建趋势卡。
  const _InsightsTrendCard({
    required this.l10n,
    required this.days,
    required this.stabilityScore,
    required this.onOpenStability,
  });

  final AppLocalizations l10n;
  final List<WeeklyReportDaySnapshot> days;
  final StabilityScore? stabilityScore;
  final VoidCallback onOpenStability;

  @override
  Widget build(BuildContext context) {
    return _InsightsGlassCard(
      title: l10n.todayTrendSectionTitle,
      description: _trendDescription(),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _trendDescription(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: const Color(0xFF6F7891),
                height: 1.35,
              ),
            ),
          ),
          const SizedBox(width: 16),
          _InsightsTrendBars(days: days),
          const SizedBox(width: 16),
          TextButton(
            onPressed: stabilityScore == null ? null : onOpenStability,
            child: Text(l10n.insightsStabilityExplainerTitle),
          ),
        ],
      ),
    );
  }

  /// 趋势卡说明优先复用稳定度解释，不额外发明新口径。
  String _trendDescription() {
    final score = stabilityScore;
    if (score == null) {
      return l10n.insightsStabilityDescriptionInsufficient;
    }
    switch (score.level) {
      case StabilityScoreLevel.insufficient:
        return l10n.insightsStabilityDescriptionInsufficient;
      case StabilityScoreLevel.steady:
        return l10n.insightsStabilityDescriptionSteady;
      case StabilityScoreLevel.recovering:
        return l10n.insightsStabilityDescriptionRecovering;
      case StabilityScoreLevel.needsRecovery:
        return l10n.insightsStabilityDescriptionNeedsRecovery;
    }
  }
}

/// 通用玻璃卡，统一洞察首页各区块的层级和光感。
class _InsightsGlassCard extends StatelessWidget {
  /// 创建玻璃卡。
  const _InsightsGlassCard({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white.withValues(alpha: 0.82),
      shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withValues(alpha: 0.86)),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.06),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: const Color(0xFF182033),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: theme.textTheme.bodySmall?.copyWith(
                color: const Color(0xFF6F7891),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

/// 概览指标块，对齐设计稿里的三栏数字卡。
class _InsightsMetricTile extends StatelessWidget {
  /// 创建指标块。
  const _InsightsMetricTile({
    required this.title,
    required this.value,
    required this.backgroundColor,
  });

  final String title;
  final String value;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE7ECF6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: const Color(0xFF8D97AE),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: const Color(0xFF182033),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// 原因条目，把比例可视化成设计稿式轨道。
class _InsightsReasonBar extends StatelessWidget {
  /// 创建原因条目。
  const _InsightsReasonBar({required this.item});

  final ReasonDistributionItem item;

  @override
  Widget build(BuildContext context) {
    final percentage = (item.ratio * 100).round();

    return Row(
      children: [
        SizedBox(
          width: 68,
          child: Text(
            item.label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: const Color(0xFF6F7891),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFFE9EEF8),
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: item.ratio.clamp(0.0, 1.0).toDouble(),
              child: Container(
                decoration: BoxDecoration(
                  color: percentage >= 40
                      ? const Color(0xFF7E8CCE)
                      : percentage >= 25
                          ? const Color(0xFFAAB7DF)
                          : const Color(0xFFC8D1EA),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '$percentage%',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: percentage >= 40
                ? const Color(0xFF4F5E9A)
                : const Color(0xFF6F7891),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// Hero 左上图标徽记。
class _InsightsHeroBadge extends StatelessWidget {
  /// 创建徽记。
  const _InsightsHeroBadge({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 18, color: Colors.white),
    );
  }
}

/// 趋势条先按周报快照生成轻量条形，不把页面拖回复杂图表实现。
class _InsightsTrendBars extends StatelessWidget {
  /// 创建趋势条。
  const _InsightsTrendBars({required this.days});

  final List<WeeklyReportDaySnapshot> days;

  @override
  Widget build(BuildContext context) {
    final bars = days
        .take(5)
        .map((day) => _resolveBarHeight(day.sleepOffsetMinutes))
        .toList(growable: false);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var index = 0; index < bars.length; index++) ...[
          Container(
            width: 12,
            height: bars[index],
            decoration: BoxDecoration(
              color: index == bars.length - 1
                  ? const Color(0xFFF1C98A)
                  : const Color(0xFFBFC8E9),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          if (index != bars.length - 1) const SizedBox(width: 8),
        ],
      ],
    );
  }

  /// 偏差越大，柱子越高；无数据时保底一个轻量高度。
  double _resolveBarHeight(int? offset) {
    if (offset == null) {
      return 18;
    }
    final clamped = offset.abs().clamp(12, 90);
    return 12 + clamped / 3;
  }
}
