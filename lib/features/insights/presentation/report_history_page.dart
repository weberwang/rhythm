import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/app/router/secondary_navigation.dart';
import 'package:rhythm/features/insights/application/insights_controller.dart';
import 'package:rhythm/features/insights/application/insights_view_state.dart';
import 'package:rhythm/features/insights/domain/weekly_report.dart';
import 'package:rhythm/features/insights/presentation/insights_copy_resolver.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 历史洞察页，展示近几周周报与免费范围外的锁定状态。
class ReportHistoryPage extends HookConsumerWidget {
  /// 创建历史洞察页。
  const ReportHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(insightsControllerProvider);
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.insightsHistoryPageTitle)),
      body: stateAsync.when(
        data: (state) => _HistoryBody(state: state, l10n: l10n),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }
}

class _HistoryBody extends StatelessWidget {
  const _HistoryBody({required this.state, required this.l10n});

  final InsightsViewState state;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    if (state.history.isEmpty) {
      return Center(child: Text(l10n.insightsNoHistory));
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          l10n.insightsHistoryHeadline,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(l10n.insightsHistoryDescription),
        const SizedBox(height: 18),
        for (final report in state.history) ...[
          _HistoryCard(report: report, l10n: l10n),
          const SizedBox(height: 12),
        ],
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1B3A28),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.insightsHistoryPaywallTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.insightsHistoryPaywallDescription,
                style: const TextStyle(color: Color(0xFFD7E7DA)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => context.pushSecondary(membershipCenterPath),
            child: Text(l10n.insightsHistoryUnlockButton),
          ),
        ),
      ],
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.report, required this.l10n});

  final WeeklyReport report;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final isLocked = report.isLocked;
    final background = isLocked
        ? const Color(0xFFF4E8CF)
        : const Color(0xFFF9FBF6);
    final title = InsightsCopyResolver.rangeLabel(
      context,
      report.startDate,
      report.endDate,
    );
    final summary = InsightsCopyResolver.historySummary(l10n, report);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(summary),
        ],
      ),
    );
  }
}
