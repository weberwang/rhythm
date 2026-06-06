import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app_shell/application/providers/current_account_session_provider.dart';
import '../../../sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import '../../../sleep_data_core/application/providers/sleep_record_repository_provider.dart';
import '../../../sleep_data_core/application/providers/sleep_data_core_status_provider.dart';
import '../../../sleep_data_core/domain/entities/goal_schedule.dart';
import '../../../sleep_data_core/domain/entities/sleep_record.dart';
import '../../../sleep_data_core/domain/entities/sleep_data_core_status.dart';
import '../../domain/entities/today_snapshot.dart';

part 'today_snapshot_provider.g.dart';

/// 聚合 today 首屏最小可用上下文，先回答“昨晚怎么样 / 今晚做什么”，再等待真实记录接线。
@riverpod
Future<TodaySnapshot> todaySnapshot(Ref ref) async {
  final scheduleRepository = ref.watch(goalScheduleRepositoryProvider);
  final sleepRecordRepository = ref.watch(sleepRecordRepositoryProvider);
  final accountSession = await ref.watch(currentAccountSessionProvider.future);
  final sleepStatus = ref.watch(sleepDataCoreStatusProvider);
  final schedule =
      await scheduleRepository.readActiveSchedule() ?? _fallbackSchedule();
  final latestRecord = await sleepRecordRepository.readLatestRecord();
  final recentRecords = await sleepRecordRepository.readRecentRecords(limit: 7);
  final tonightGoal = _buildTonightGoal(schedule);

  return TodaySnapshot(
    displayName: accountSession?.displayName,
    lastNight: _buildLastNightSummary(
      sleepStatus: sleepStatus,
      tonightGoal: tonightGoal,
      schedule: schedule,
      latestRecord: latestRecord,
    ),
    tonightGoal: tonightGoal,
    recovery: _buildRecoverySummary(
      sleepStatus: sleepStatus,
      schedule: schedule,
      latestRecord: latestRecord,
    ),
    quickRecord: TodayQuickRecordSummary(
      status: _buildQuickRecordStatus(
        sleepStatus: sleepStatus,
        schedule: schedule,
        latestRecord: latestRecord,
      ),
    ),
    trend: _buildTrendSummary(schedule: schedule, recentRecords: recentRecords),
  );
}

/// 在当前尚未接入睡眠记录仓储前，使用已落地的目标作息作为首页最小锚点。
GoalSchedule _fallbackSchedule() {
  return GoalSchedule(
    id: 'fallback',
    bedtimeMinutes: 23 * 60,
    wakeTimeMinutes: 7 * 60,
    createdAt: DateTime.now(),
  );
}

/// 从目标作息推导 tonight 卡片需要的核心时间点，避免 today 页面自己处理时间算法。
TodayTonightGoalSummary _buildTonightGoal(GoalSchedule schedule) {
  return TodayTonightGoalSummary(
    bedtimeMinutes: schedule.bedtimeMinutes,
    wakeTimeMinutes: schedule.wakeTimeMinutes,
    windDownMinutes: (schedule.bedtimeMinutes - 45) % Duration.minutesPerDay,
    bedtimeLabel: _formatMinutes(schedule.bedtimeMinutes),
    wakeTimeLabel: _formatMinutes(schedule.wakeTimeMinutes),
    windDownLabel: _formatMinutes(
      (schedule.bedtimeMinutes - 45) % Duration.minutesPerDay,
    ),
  );
}

/// 当前没有真实记录仓储时，首页先用共享状态把“无数据 / 同步失败 / 手动修正”讲清楚。
TodayLastNightSummary _buildLastNightSummary({
  required SleepDataCoreStatus sleepStatus,
  required TodayTonightGoalSummary tonightGoal,
  required GoalSchedule schedule,
  required SleepRecord? latestRecord,
}) {
  if (latestRecord != null &&
      sleepStatus.syncStatus != SleepSyncStatus.failedRecoverable) {
    final delayMinutes = _calculateDelayMinutes(
      actualMinutes: latestRecord.bedtimeMinutes,
      targetMinutes: schedule.bedtimeMinutes,
    );
    final score = _calculateSleepScore(
      delayMinutes: delayMinutes,
      durationMinutes: _calculateSleepDurationMinutes(latestRecord),
    );

    return TodayLastNightSummary(
      status: _resolveLastNightStatus(
        delayMinutes: delayMinutes,
        latestRecord: latestRecord,
      ),
      scoreLabel: '$score',
      primaryMetricLabel: '实际入睡',
      primaryMetricValue: _formatMinutes(latestRecord.bedtimeMinutes),
      secondaryMetricLabel: '相对目标',
      secondaryMetricValue: _formatDelayMinutes(delayMinutes),
      tertiaryMetricLabel: '当前来源',
      tertiaryMetricValue: _buildSourceLabel(latestRecord),
    );
  }

  final status = switch (sleepStatus.syncStatus) {
    SleepSyncStatus.failedRecoverable => TodayLastNightStatus.syncRecoverable,
    SleepSyncStatus.idle => switch (sleepStatus.sourceConfidence) {
      SleepSourceConfidence.manualAdjusted =>
        TodayLastNightStatus.manualAdjusted,
      _ => TodayLastNightStatus.noData,
    },
  };

  final secondaryMetricValue = switch (sleepStatus.syncStatus) {
    SleepSyncStatus.failedRecoverable => '稍后修复',
    SleepSyncStatus.idle => '本地优先',
  };
  final tertiaryMetricValue = switch (sleepStatus.sourceConfidence) {
    SleepSourceConfidence.manualAdjusted => '手动修正',
    SleepSourceConfidence.partial => '等待补全',
    SleepSourceConfidence.trusted => '待建立',
  };

  return TodayLastNightSummary(
    status: status,
    scoreLabel: switch (status) {
      TodayLastNightStatus.onTarget => '稳住节奏',
      TodayLastNightStatus.slightDelay => '轻微偏移',
      TodayLastNightStatus.majorDelay => '需要回拉',
      TodayLastNightStatus.syncRecoverable => '本地已保留',
      TodayLastNightStatus.manualAdjusted => '手动校正',
      TodayLastNightStatus.noData => '等待首晚',
    },
    primaryMetricLabel: '目标已就绪',
    primaryMetricValue: tonightGoal.bedtimeLabel,
    secondaryMetricLabel: '同步状态',
    secondaryMetricValue: secondaryMetricValue,
    tertiaryMetricLabel: '当前来源',
    tertiaryMetricValue: tertiaryMetricValue,
  );
}

/// 恢复建议当前只基于共享状态分级，后续睡眠记录接入后再细化真正的恢复引擎。
TodayRecoverySummary _buildRecoverySummary({
  required SleepDataCoreStatus sleepStatus,
  required GoalSchedule schedule,
  required SleepRecord? latestRecord,
}) {
  if (sleepStatus.syncStatus == SleepSyncStatus.failedRecoverable) {
    return const TodayRecoverySummary(
      status: TodayRecoveryStatus.syncRecoveryFirst,
    );
  }

  if (latestRecord != null) {
    final delayMinutes = _calculateDelayMinutes(
      actualMinutes: latestRecord.bedtimeMinutes,
      targetMinutes: schedule.bedtimeMinutes,
    );
    if (delayMinutes > 60) {
      return const TodayRecoverySummary(
        status: TodayRecoveryStatus.recoverAfterDelay,
      );
    }
  }

  if (sleepStatus.sourceConfidence == SleepSourceConfidence.manualAdjusted) {
    return const TodayRecoverySummary(
      status: TodayRecoveryStatus.protectMomentum,
    );
  }

  return const TodayRecoverySummary(status: TodayRecoveryStatus.buildBaseline);
}

/// 快捷记录在“无数据 / 明显偏移 / 同步失败”时应进入推荐入口，其余情况保持补充姿态。
TodayQuickRecordStatus _buildQuickRecordStatus({
  required SleepDataCoreStatus sleepStatus,
  required GoalSchedule schedule,
  required SleepRecord? latestRecord,
}) {
  if (sleepStatus.syncStatus == SleepSyncStatus.failedRecoverable ||
      latestRecord == null) {
    return TodayQuickRecordStatus.recommended;
  }

  final delayMinutes = _calculateDelayMinutes(
    actualMinutes: latestRecord.bedtimeMinutes,
    targetMinutes: schedule.bedtimeMinutes,
  );
  return delayMinutes > 15
      ? TodayQuickRecordStatus.recommended
      : TodayQuickRecordStatus.optional;
}

/// 趋势摘要在已有真实记录时直接消费样本，避免 today 继续展示固定折线常量。
TodayTrendSummary _buildTrendSummary({
  required GoalSchedule schedule,
  required List<SleepRecord> recentRecords,
}) {
  if (recentRecords.length < 3) {
    return const TodayTrendSummary(
      status: TodayTrendStatus.building,
      points: [],
      averageScore: null,
    );
  }

  final orderedRecords = recentRecords.reversed.toList(growable: false);
  final points = orderedRecords
      .map(
        (record) => TodayTrendPoint(
          dayLabel: DateFormat('E').format(record.sleepDate),
          score: _calculateSleepScore(
            delayMinutes: _calculateDelayMinutes(
              actualMinutes: record.bedtimeMinutes,
              targetMinutes: schedule.bedtimeMinutes,
            ),
            durationMinutes: _calculateSleepDurationMinutes(record),
          ),
        ),
      )
      .toList(growable: false);

  final averageScore =
      points
          .map((point) => point.score)
          .reduce((left, right) => left + right) ~/
      points.length;

  return TodayTrendSummary(
    status: TodayTrendStatus.ready,
    points: points,
    averageScore: averageScore,
  );
}

/// 统一把晚睡分钟映射成首页状态，避免显示层再重复阈值判断。
TodayLastNightStatus _resolveLastNightStatus({
  required int delayMinutes,
  required SleepRecord latestRecord,
}) {
  if (latestRecord.isManuallyAdjusted) {
    return TodayLastNightStatus.manualAdjusted;
  }
  if (delayMinutes <= 15) {
    return TodayLastNightStatus.onTarget;
  }
  if (delayMinutes <= 60) {
    return TodayLastNightStatus.slightDelay;
  }
  return TodayLastNightStatus.majorDelay;
}

/// 统一计算入睡相对目标的偏移分钟，跨午夜时保留“提前”为负、“延后”为正的语义。
int _calculateDelayMinutes({
  required int actualMinutes,
  required int targetMinutes,
}) {
  final normalizedDiff =
      ((actualMinutes - targetMinutes) % Duration.minutesPerDay +
          Duration.minutesPerDay) %
      Duration.minutesPerDay;
  return normalizedDiff > 12 * 60
      ? normalizedDiff - Duration.minutesPerDay
      : normalizedDiff;
}

/// 统一计算跨午夜睡眠时长，避免 today 和 calendar 后续各自重写。
int _calculateSleepDurationMinutes(SleepRecord record) {
  final rawDuration = record.wakeTimeMinutes - record.bedtimeMinutes;
  return rawDuration <= 0 ? rawDuration + Duration.minutesPerDay : rawDuration;
}

/// 用一个稳定但克制的评分近似，把 today 折线先从“固定常量”升级为真实样本摘要。
int _calculateSleepScore({
  required int delayMinutes,
  required int durationMinutes,
}) {
  final latePenalty = delayMinutes <= 0 ? 0 : (delayMinutes / 4).round();
  final durationPenalty = durationMinutes >= 7 * 60
      ? 0
      : ((7 * 60 - durationMinutes) / 12).ceil();
  final score = 92 - latePenalty - durationPenalty;
  return score.clamp(48, 95);
}

/// 把偏移分钟格式化成首页可读语义，避免页面侧再次处理正负值规则。
String _formatDelayMinutes(int delayMinutes) {
  if (delayMinutes.abs() <= 5) {
    return '基本准点';
  }
  if (delayMinutes < 0) {
    return '提前 ${delayMinutes.abs()} 分钟';
  }
  return '晚了 $delayMinutes 分钟';
}

/// 统一说明记录来源，保持“可信但可修正”的共享表达。
String _buildSourceLabel(SleepRecord latestRecord) {
  if (latestRecord.isManuallyAdjusted) {
    return '手动修正';
  }
  return switch (latestRecord.confidence) {
    SleepRecordConfidence.partial => '部分样本',
    SleepRecordConfidence.trusted => switch (latestRecord.source) {
      SleepRecordSource.health => '健康同步',
      SleepRecordSource.manual => '手动补录',
    },
  };
}

/// 统一格式化分钟制时间，避免页面层散落时间字符串拼接。
String _formatMinutes(int totalMinutes) {
  final normalizedMinutes =
      ((totalMinutes % Duration.minutesPerDay) + Duration.minutesPerDay) %
      Duration.minutesPerDay;
  final hours = normalizedMinutes ~/ 60;
  final minutes = normalizedMinutes % 60;
  final formatter = DateFormat('h:mm a');
  return formatter.format(DateTime(2026, 1, 1, hours, minutes));
}
