import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:rhythm/features/insights/domain/recovery_plan.dart';
import 'package:rhythm/features/insights/domain/stability_score_rules.dart';
import 'package:rhythm/features/insights/domain/weekly_report.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 统一解析洞察显示层文案，避免页面和组件散落业务文案拼接逻辑。
class InsightsCopyResolver {
  const InsightsCopyResolver._();

  /// 生成洞察首页主摘要标题。
  static String headline(
    AppLocalizations l10n,
    WeeklyReportSummary summary,
  ) {
    return l10n.insightsWeeklyHeadline(
      summary.onTrackRate,
      summary.stabilityScore,
      _weekdayLabel(summary.latestLateDayWeekday, l10n),
    );
  }

  /// 根据稳定度等级生成首页副标题和说明弹层主说明。
  static String stabilitySummary(
    AppLocalizations l10n,
    StabilityScore score,
  ) {
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

  /// 根据稳定度等级生成解释文本。
  static String stabilityDescription(
    AppLocalizations l10n,
    StabilityScore score,
  ) {
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

  /// 生成周报详情里的“最晚入睡日”说明。
  static String latestLateSummary(
    AppLocalizations l10n,
    WeeklyReport report,
  ) {
    final summary = report.summary;
    final latestDay = report.days.fold<WeeklyReportDaySnapshot?>(null, (latest, current) {
      final latestOffset = latest?.sleepOffsetMinutes ?? -1;
      final currentOffset = current.sleepOffsetMinutes ?? -1;
      return currentOffset > latestOffset ? current : latest;
    });
    final reasons = latestDay == null || latestDay.tags.isEmpty
        ? null
        : latestDay.tags.join('、');
    final base = l10n.insightsLatestLateSummary(
      _weekdayLabel(summary.latestLateDayWeekday, l10n),
      _formatMinutesOfDay(summary.latestLateSleepMinutesOfDay),
      summary.latestLateOffsetMinutes,
    );
    if (reasons == null) {
      return base;
    }
    return l10n.insightsLatestLateSummaryWithReasons(base, reasons);
  }

  /// 生成周报建议文案。
  static String recommendation(
    AppLocalizations l10n,
    WeeklyRecommendation recommendation,
  ) {
    switch (recommendation.type) {
      case WeeklyRecommendationType.finishWorkEarlier:
        return l10n.insightsRecommendationFinishWorkEarlier;
      case WeeklyRecommendationType.enableSoftReminder:
        return l10n.insightsRecommendationEnableSoftReminder;
      case WeeklyRecommendationType.openRecoveryPlan:
        return l10n.insightsRecommendationOpenRecoveryPlan;
    }
  }

  /// 生成恢复效果摘要文案。
  static String recoverySummary(
    AppLocalizations l10n,
    RecoveryPlan? plan,
  ) {
    if (plan == null) {
      return l10n.insightsRecoveryNoPlan;
    }
    return l10n.insightsRecoveryPlanSummary(plan.horizonDays);
  }

  /// 生成恢复计划标题。
  static String recoveryTitle(
    AppLocalizations l10n,
    RecoveryPlan plan,
  ) {
    return l10n.insightsRecoveryPlanTitle(plan.horizonDays);
  }

  /// 生成恢复计划步骤标题。
  static String recoveryStepTitle(
    AppLocalizations l10n,
    RecoveryPlanStep step,
  ) {
    switch (step.type) {
      case RecoveryPlanStepType.closeWorkEarlier:
        return l10n.insightsRecoveryStepCloseWorkEarlierTitle;
      case RecoveryPlanStepType.reduceNightNoise:
        return l10n.insightsRecoveryStepReduceNightNoiseTitle;
      case RecoveryPlanStepType.reviewLateTriggers:
        return l10n.insightsRecoveryStepReviewLateTriggersTitle;
    }
  }

  /// 生成恢复计划步骤说明。
  static String recoveryStepDetail(
    AppLocalizations l10n,
    RecoveryPlanStep step,
  ) {
    switch (step.type) {
      case RecoveryPlanStepType.closeWorkEarlier:
        return l10n.insightsRecoveryStepCloseWorkEarlierDetail;
      case RecoveryPlanStepType.reduceNightNoise:
        return l10n.insightsRecoveryStepReduceNightNoiseDetail;
      case RecoveryPlanStepType.reviewLateTriggers:
        return l10n.insightsRecoveryStepReviewLateTriggersDetail;
    }
  }

  /// 生成历史周报摘要。
  static String historySummary(
    AppLocalizations l10n,
    WeeklyReport report,
  ) {
    if (report.isLocked) {
      return l10n.insightsHistoryLocked;
    }
    return l10n.insightsHistorySummary(
      report.summary.onTrackRate,
      report.summary.stabilityScore,
    );
  }

  /// 统一格式化历史/详情日期范围。
  static String rangeLabel(
    BuildContext context,
    DateTime startDate,
    DateTime endDate,
  ) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final formatter = DateFormat('MM.dd', locale);
    return '${formatter.format(startDate)} - ${formatter.format(endDate)}';
  }

  /// 生成单日标签缺失时的替代文案。
  static String tagsOrFallback(
    AppLocalizations l10n,
    List<String> tags,
  ) {
    if (tags.isEmpty) {
      return l10n.insightsNoReasonTags;
    }
    return tags.join('、');
  }

  static String _weekdayLabel(int weekday, AppLocalizations l10n) {
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
        return l10n.insightsWeekdaySun;
      default:
        return '--';
    }
  }

  static String _formatMinutesOfDay(int minutes) {
    final hour = minutes ~/ 60;
    final minute = minutes % 60;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
