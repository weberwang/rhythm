import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../bedtime/presentation/pages/bedtime_page.dart';
import '../../domain/entities/today_snapshot.dart';
import 'today_dashboard_primitives.dart';
import 'today_dashboard_style.dart';
import 'today_trend_chart.dart';

/// today 首屏内容严格保持“结果 -> 目标 -> 恢复/记录 -> 趋势”的冻结顺序。
class TodayDashboardContent extends StatelessWidget {
  /// 创建首页内容。
  const TodayDashboardContent({
    required this.snapshot,
    required this.onQuickRecordTap,
    super.key,
  });

  /// 当前首页快照。
  final TodaySnapshot snapshot;

  /// 快捷记录点击动作。
  final VoidCallback onQuickRecordTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 32),
      children: [
        TodayHeader(snapshot: snapshot),
        const SizedBox(height: 26),
        TodayLastNightCard(snapshot: snapshot),
        const SizedBox(height: 18),
        TodayTonightGoalCard(snapshot: snapshot),
        const SizedBox(height: 18),
        TodayRecoveryCard(snapshot: snapshot),
        const SizedBox(height: 18),
        TodayQuickRecordCard(snapshot: snapshot, onTap: onQuickRecordTap),
        const SizedBox(height: 18),
        TodayTrendCard(snapshot: snapshot),
      ],
    );
  }
}

/// 页头先回答“是谁的首页”和“今天先看什么”。
class TodayHeader extends StatelessWidget {
  /// 创建页头。
  const TodayHeader({required this.snapshot, super.key});

  /// 当前首页快照。
  final TodaySnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final title = snapshot.displayName == null
        ? localization.todayGreetingGeneric
        : localization.todayGreetingNamed(snapshot.displayName!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(children: [TodayWordmark(), Spacer(), TodayProfileButton()]),
        const SizedBox(height: 28),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TodayDashboardStyle.heroTitle(context)),
                  const SizedBox(height: 12),
                  Text(
                    localization.todayGreetingBody,
                    style: TodayDashboardStyle.heroBody(context),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: TodaySunBadge(),
            ),
          ],
        ),
      ],
    );
  }
}

/// 昨晚结果卡必须占据首屏主焦点，即使当前仍处于无数据阶段。
class TodayLastNightCard extends StatelessWidget {
  /// 创建昨晚结果卡。
  const TodayLastNightCard({required this.snapshot, super.key});

  /// 当前首页快照。
  final TodaySnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final metrics = [
      (
        icon: Icons.nightlight_round,
        value: snapshot.lastNight.primaryMetricValue,
        label: snapshot.lastNight.primaryMetricLabel,
      ),
      (
        icon: Icons.favorite_border_rounded,
        value: snapshot.lastNight.secondaryMetricValue,
        label: snapshot.lastNight.secondaryMetricLabel,
      ),
      (
        icon: Icons.show_chart_rounded,
        value: snapshot.lastNight.tertiaryMetricValue,
        label: snapshot.lastNight.tertiaryMetricLabel,
      ),
    ];

    return TodaySurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TodaySectionLabel(localization.todaySectionLastNight),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TodayScoreRing(label: snapshot.lastNight.scoreLabel),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _lastNightTitle(localization, snapshot.lastNight.status),
                      style: TodayDashboardStyle.cardHeadline(context),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _lastNightBody(localization, snapshot.lastNight.status),
                      style: TodayDashboardStyle.bodyText(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            children: List.generate(metrics.length * 2 - 1, (index) {
              if (index.isOdd) {
                return const TodayMetricDivider();
              }
              final metric = metrics[index ~/ 2];
              return Expanded(
                child: TodayMetricColumn(
                  icon: metric.icon,
                  value: metric.value,
                  label: metric.label,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// 今晚目标卡聚焦单一动作：按目标作息进入睡前页。
class TodayTonightGoalCard extends StatelessWidget {
  /// 创建今晚目标卡。
  const TodayTonightGoalCard({required this.snapshot, super.key});

  /// 当前首页快照。
  final TodaySnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: TodayDashboardStyle.cardRadius,
      onTap: () => context.go(BedtimePage.routePath),
      child: TodaySurfaceCard(
        color: TodayDashboardStyle.goalTint,
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TodayIllustrationAsset(
                assetName: 'assets/images/today/today_moon_badge.png',
                size: 88,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TodaySectionLabel(localization.todaySectionTonightGoal),
                    const SizedBox(height: 12),
                    Text(
                      snapshot.tonightGoal.bedtimeLabel,
                      style: TodayDashboardStyle.timeValue(context),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      localization.todayTonightGoalHeadline,
                      style: TodayDashboardStyle.supportLabel(context),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TodayVerticalDivider(height: 88),
              ),
              SizedBox(
                width: 122,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.notifications_none_rounded,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            snapshot.tonightGoal.windDownLabel,
                            style: TodayDashboardStyle.supportValue(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      localization.todayTonightGoalReminderLabel,
                      style: TodayDashboardStyle.supportLabel(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 恢复建议卡只承接当前最重要的一条建议，不把首页拉成多任务面板。
class TodayRecoveryCard extends StatelessWidget {
  /// 创建恢复建议卡。
  const TodayRecoveryCard({required this.snapshot, super.key});

  /// 当前首页快照。
  final TodaySnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return TodaySurfaceCard(
      color: TodayDashboardStyle.recoveryTint,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TodayIllustrationAsset(
            assetName: 'assets/images/today/today_recovery_plant.png',
            size: 96,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TodaySectionLabel(localization.todaySectionRecovery),
                const SizedBox(height: 10),
                Text(
                  _recoveryTitle(localization, snapshot.recovery.status),
                  style: TodayDashboardStyle.cardTitle(context),
                ),
                const SizedBox(height: 8),
                Text(
                  _recoveryBody(localization, snapshot.recovery.status),
                  style: TodayDashboardStyle.bodyText(context),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const TodayActionChevron(),
        ],
      ),
    );
  }
}

/// 快捷记录卡提供最小补录入口，不与首页主判断抢焦点。
class TodayQuickRecordCard extends StatelessWidget {
  /// 创建快捷记录卡。
  const TodayQuickRecordCard({
    required this.snapshot,
    required this.onTap,
    super.key,
  });

  /// 当前首页快照。
  final TodaySnapshot snapshot;

  /// 卡片点击动作。
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return InkWell(
      borderRadius: TodayDashboardStyle.cardRadius,
      onTap: onTap,
      child: TodaySurfaceCard(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        child: Row(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFA57A), TodayDashboardStyle.recordAccent],
                ),
              ),
              child: const Icon(
                Icons.add_rounded,
                size: 38,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TodaySectionLabel(localization.todaySectionQuickRecord),
                  const SizedBox(height: 8),
                  Text(
                    localization.todayQuickRecordTitle,
                    style: TodayDashboardStyle.cardTitle(context),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.quickRecord.status ==
                            TodayQuickRecordStatus.recommended
                        ? localization.todayQuickRecordRecommendedBody
                        : localization.todayQuickRecordOptionalBody,
                    style: TodayDashboardStyle.bodyText(context),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const TodayActionChevron(),
          ],
        ),
      ),
    );
  }
}

/// 趋势区块只放在下半屏，负责补充上下文，不抢主判断。
class TodayTrendCard extends StatelessWidget {
  /// 创建趋势卡。
  const TodayTrendCard({required this.snapshot, super.key});

  /// 当前首页快照。
  final TodaySnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return TodaySurfaceCard(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TodaySectionLabel(localization.todaySectionTrend),
              const Spacer(),
              Text(
                snapshot.trend.averageScore == null
                    ? localization.todayTrendScoreLabel
                    : '${localization.todayTrendScoreLabel} ${snapshot.trend.averageScore}',
                style: TodayDashboardStyle.supportValue(context).copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 15.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TodayTrendChart(summary: snapshot.trend),
          const SizedBox(height: 12),
          Text(
            snapshot.trend.status == TodayTrendStatus.ready
                ? localization.todayTrendReadyBody
                : localization.todayTrendBuildingBody,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TodayDashboardStyle.supportLabel(context),
          ),
        ],
      ),
    );
  }
}

/// 昨晚结果标题映射保留在显示层，避免领域层携带最终展示文案。
String _lastNightTitle(
  AppLocalizations localization,
  TodayLastNightStatus status,
) {
  return switch (status) {
    TodayLastNightStatus.syncRecoverable =>
      localization.todayLastNightSyncTitle,
    TodayLastNightStatus.manualAdjusted =>
      localization.todayLastNightManualTitle,
    TodayLastNightStatus.onTarget => localization.todayLastNightOnTargetTitle,
    TodayLastNightStatus.slightDelay =>
      localization.todayLastNightSlightDelayTitle,
    TodayLastNightStatus.majorDelay =>
      localization.todayLastNightMajorDelayTitle,
    TodayLastNightStatus.noData => localization.todayLastNightNoDataTitle,
  };
}

/// 昨晚结果正文同样在显示层解析，保证国际化边界清晰。
String _lastNightBody(
  AppLocalizations localization,
  TodayLastNightStatus status,
) {
  return switch (status) {
    TodayLastNightStatus.syncRecoverable => localization.todayLastNightSyncBody,
    TodayLastNightStatus.manualAdjusted =>
      localization.todayLastNightManualBody,
    TodayLastNightStatus.onTarget => localization.todayLastNightOnTargetBody,
    TodayLastNightStatus.slightDelay =>
      localization.todayLastNightSlightDelayBody,
    TodayLastNightStatus.majorDelay =>
      localization.todayLastNightMajorDelayBody,
    TodayLastNightStatus.noData => localization.todayLastNightNoDataBody,
  };
}

/// 恢复建议主标题按状态分流，确保明显晚睡场景仍能进入主路径。
String _recoveryTitle(
  AppLocalizations localization,
  TodayRecoveryStatus status,
) {
  return switch (status) {
    TodayRecoveryStatus.syncRecoveryFirst =>
      localization.todayRecoverySyncTitle,
    TodayRecoveryStatus.recoverAfterDelay =>
      localization.todayRecoveryDelayTitle,
    TodayRecoveryStatus.protectMomentum =>
      localization.todayRecoveryMomentumTitle,
    TodayRecoveryStatus.buildBaseline =>
      localization.todayRecoveryBuildBaselineTitle,
  };
}

/// 恢复建议正文保持和标题同源，避免页面层临时拼装多套话术。
String _recoveryBody(
  AppLocalizations localization,
  TodayRecoveryStatus status,
) {
  return switch (status) {
    TodayRecoveryStatus.syncRecoveryFirst => localization.todayRecoverySyncBody,
    TodayRecoveryStatus.recoverAfterDelay =>
      localization.todayRecoveryDelayBody,
    TodayRecoveryStatus.protectMomentum =>
      localization.todayRecoveryMomentumBody,
    TodayRecoveryStatus.buildBaseline =>
      localization.todayRecoveryBuildBaselineBody,
  };
}
