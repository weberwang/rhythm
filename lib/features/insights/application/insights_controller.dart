import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/insights/application/insights_view_state.dart';
import 'package:rhythm/features/insights/domain/recovery_plan_rules.dart';
import 'package:rhythm/features/insights/domain/stability_score_rules.dart';
import 'package:rhythm/features/insights/domain/weekly_report.dart';
import 'package:rhythm/features/insights/domain/weekly_report_generator.dart';
import 'package:rhythm/features/sleep_records/application/effective_sleep_record_provider.dart';
import 'package:rhythm/features/sleep_records/application/sleep_delay_tag_providers.dart';

/// 聚合最近 7 天记录、目标作息与标签，向洞察页面输出单一 ViewState。
final insightsControllerProvider =
    AsyncNotifierProvider.autoDispose<InsightsController, InsightsViewState>(
      InsightsController.new,
    );

/// 承接洞察首屏和详情页数据聚合，页面层不再重算业务规则。
class InsightsController extends AsyncNotifier<InsightsViewState> {
  @override
  Future<InsightsViewState> build() async {
    final settings = await ref.watch(savedGoalScheduleSettingsProvider.future);
    if (settings == null) {
      return const InsightsViewState(status: InsightsStatus.empty);
    }

    final records = await ref.read(recentSevenDayEffectiveSleepRecordsProvider.future);
    if (records.isEmpty) {
      return const InsightsViewState(status: InsightsStatus.empty);
    }

    final now = ref.read(timeContextProvider).now;
    final tagsByDate = await _loadTagsForWindow(
      endDate: DateTime.utc(now.year, now.month, now.day).subtract(
        const Duration(days: 1),
      ),
    );
    final weeklyReport = WeeklyReportGenerator.generate(
      settings: settings,
      records: records,
      tagsByDate: tagsByDate,
      now: now,
    );
    if (weeklyReport == null) {
      return const InsightsViewState(status: InsightsStatus.empty);
    }

    final stabilityScore = StabilityScoreRules.calculate(
      settings: settings,
      records: records,
    );
    final recoveryPlan = RecoveryPlanRules.build(
      settings: settings,
      records: records,
      now: now,
    );
    final history = _buildHistory(
      report: weeklyReport,
      stabilityScore: stabilityScore,
    );

    return InsightsViewState(
      status: InsightsStatus.ready,
      weeklyReport: weeklyReport,
      stabilityScore: stabilityScore,
      recoveryPlan: recoveryPlan,
      history: history,
    );
  }

  /// 先用当前周报扩展出轻量历史列表，后续真实持久化接入时可平滑替换。
  List<WeeklyReport> _buildHistory({
    required WeeklyReport report,
    required StabilityScore stabilityScore,
  }) {
    final current = report;
    final previous = WeeklyReport(
      startDate: report.startDate.subtract(const Duration(days: 7)),
      endDate: report.endDate.subtract(const Duration(days: 7)),
      days: report.days,
      summary: WeeklyReportSummary(
        qualifiedDayCount: (report.summary.qualifiedDayCount - 1).clamp(0, 7),
        totalRecordedDays: report.summary.totalRecordedDays,
        onTrackRate: (report.summary.onTrackRate - 7).clamp(0, 100),
        stabilityScore: (stabilityScore.score - 8).clamp(0, 100),
        latestLateDayWeekday: report.summary.latestLateDayWeekday,
        latestLateSleepMinutesOfDay: report.summary.latestLateSleepMinutesOfDay,
        latestLateOffsetMinutes: report.summary.latestLateOffsetMinutes,
        primaryReasonLabel: report.summary.primaryReasonLabel,
      ),
      reasonDistribution: report.reasonDistribution,
      recommendations: report.recommendations,
      isLocked: false,
    );
    final locked = WeeklyReport(
      startDate: previous.startDate.subtract(const Duration(days: 7)),
      endDate: previous.endDate.subtract(const Duration(days: 7)),
      days: const <WeeklyReportDaySnapshot>[],
      summary: const WeeklyReportSummary(
        qualifiedDayCount: 0,
        totalRecordedDays: 0,
        onTrackRate: 0,
        stabilityScore: 0,
        latestLateDayWeekday: 0,
        latestLateSleepMinutesOfDay: 0,
        latestLateOffsetMinutes: 0,
        primaryReasonLabel: null,
      ),
      reasonDistribution: const <ReasonDistributionItem>[],
      recommendations: const <WeeklyRecommendation>[],
      isLocked: true,
    );
    return <WeeklyReport>[current, previous, locked];
  }

  Future<Map<DateTime, List<String>>> _loadTagsForWindow({
    required DateTime endDate,
  }) async {
    final repository = ref.read(sleepDelayTagRepositoryProvider);
    final result = <DateTime, List<String>>{};
    for (var offset = 0; offset < 7; offset++) {
      final date = endDate.subtract(Duration(days: offset));
      final normalized = DateTime.utc(date.year, date.month, date.day);
      final tags = await repository.readTags(recordDate: normalized);
      if (tags.isNotEmpty) {
        result[normalized] = tags;
      }
    }
    return result;
  }
}
