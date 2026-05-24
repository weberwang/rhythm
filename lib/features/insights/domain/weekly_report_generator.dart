import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/insights/domain/reason_distribution_rules.dart';
import 'package:rhythm/features/insights/domain/stability_score_rules.dart';
import 'package:rhythm/features/insights/domain/weekly_report.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';

/// 统一承接阶段七周报生成，保证首页、详情页和历史页使用相同口径。
class WeeklyReportGenerator {
  const WeeklyReportGenerator._();

  /// 基于最近 7 天有效记录、目标作息和已确认标签生成正式周报。
  static WeeklyReport? generate({
    required GoalScheduleSettings settings,
    required List<EffectiveSleepRecord> records,
    required Map<DateTime, List<String>> tagsByDate,
    required DateTime now,
  }) {
    final normalizedRecords = [...records]
      ..sort((left, right) => left.recordDate.compareTo(right.recordDate));
    if (normalizedRecords.length < 3) {
      return null;
    }

    final endDate = DateTime.utc(now.year, now.month, now.day).subtract(
      const Duration(days: 1),
    );
    final startDate = endDate.subtract(const Duration(days: 6));
    final recordsByDate = <DateTime, EffectiveSleepRecord>{
      for (final record in normalizedRecords)
        DateTime.utc(
          record.recordDate.year,
          record.recordDate.month,
          record.recordDate.day,
        ): record,
    };
    final days = List<WeeklyReportDaySnapshot>.generate(7, (index) {
      final date = startDate.add(Duration(days: index));
      final record = recordsByDate[date];
      final offset = record == null
          ? null
          : StabilityScoreRules.offsetMinutes(
              record: record,
              settings: settings,
            );
      final tags = tagsByDate[date] ?? const <String>[];
      return WeeklyReportDaySnapshot(
        date: date,
        sleepOffsetMinutes: offset,
        qualified: offset != null && offset <= settings.lateThresholdMinutes,
        tags: tags,
      );
    });

    final recordedDays = days.where((day) => day.sleepOffsetMinutes != null).length;
    if (recordedDays < 3) {
      return null;
    }
    final qualifiedDayCount = days.where((day) => day.qualified).length;
    final onTrackRate = recordedDays == 0
        ? 0
        : ((qualifiedDayCount / recordedDays) * 100).round();
    final latestLateDay = days
        .where((day) => day.sleepOffsetMinutes != null)
        .fold<WeeklyReportDaySnapshot?>(null, (latest, current) {
      if (latest == null) {
        return current;
      }
      final latestOffset = latest.sleepOffsetMinutes ?? -1;
      final currentOffset = current.sleepOffsetMinutes ?? -1;
      return currentOffset > latestOffset ? current : latest;
    });
    final reasonDistribution = ReasonDistributionRules.build(
      tagGroups: days.map((day) => day.tags).where((tags) => tags.isNotEmpty),
    );
    final stability = StabilityScoreRules.calculate(
      settings: settings,
      records: normalizedRecords,
    );
    final summary = WeeklyReportSummary(
      qualifiedDayCount: qualifiedDayCount,
      totalRecordedDays: recordedDays,
      onTrackRate: onTrackRate,
      stabilityScore: stability.score,
      latestLateDayWeekday: latestLateDay?.date.weekday ?? 0,
      latestLateSleepMinutesOfDay: latestLateDay?.sleepOffsetMinutes == null
          ? 0
          : _sleepMinutesOfDay(
              targetBedtimeMinutes: settings.targetBedtimeMinutes,
              offsetMinutes: latestLateDay!.sleepOffsetMinutes!,
            ),
      latestLateOffsetMinutes: latestLateDay?.sleepOffsetMinutes ?? 0,
      primaryReasonLabel:
          reasonDistribution.isEmpty ? null : reasonDistribution.first.label,
    );

    return WeeklyReport(
      startDate: startDate,
      endDate: endDate,
      days: days,
      summary: summary,
      reasonDistribution: reasonDistribution,
      recommendations: _buildRecommendations(
        latestLateOffsetMinutes: latestLateDay?.sleepOffsetMinutes ?? 0,
      ),
    );
  }

  /// 统一把偏差分钟转成真实入睡时间，避免详情页重复拼时间。
  static String formatSleepTime({
    required int targetBedtimeMinutes,
    required int offsetMinutes,
  }) {
    return _formatTimeFromOffset(
      targetBedtimeMinutes: targetBedtimeMinutes,
      offsetMinutes: offsetMinutes,
    );
  }

  static List<WeeklyRecommendation> _buildRecommendations({
    required int latestLateOffsetMinutes,
  }) {
    final suggestions = <WeeklyRecommendation>[
      const WeeklyRecommendation(type: WeeklyRecommendationType.enableSoftReminder),
      const WeeklyRecommendation(type: WeeklyRecommendationType.openRecoveryPlan),
    ];
    if (latestLateOffsetMinutes > 90) {
      suggestions.insert(
        0,
        const WeeklyRecommendation(type: WeeklyRecommendationType.finishWorkEarlier),
      );
    }
    return suggestions.take(3).toList();
  }

  static String _formatTimeFromOffset({
    required int targetBedtimeMinutes,
    required int offsetMinutes,
  }) {
    final totalMinutes = targetBedtimeMinutes + offsetMinutes;
    final normalized = ((totalMinutes % (24 * 60)) + 24 * 60) % (24 * 60);
    final hour = normalized ~/ 60;
    final minute = normalized % 60;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  /// 统一把目标时间和偏差换算成最终的分钟值，供显示层按时区格式化。
  static int _sleepMinutesOfDay({
    required int targetBedtimeMinutes,
    required int offsetMinutes,
  }) {
    final totalMinutes = targetBedtimeMinutes + offsetMinutes;
    return ((totalMinutes % (24 * 60)) + 24 * 60) % (24 * 60);
  }
}
