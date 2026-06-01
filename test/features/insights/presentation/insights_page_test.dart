import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/theme/app_theme.dart';
import 'package:rhythm/features/insights/application/insights_controller.dart';
import 'package:rhythm/features/insights/application/insights_view_state.dart';
import 'package:rhythm/features/insights/domain/recovery_plan.dart';
import 'package:rhythm/features/insights/domain/stability_score_rules.dart';
import 'package:rhythm/features/insights/domain/weekly_report.dart';
import 'package:rhythm/features/insights/presentation/insights_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证洞察首页按 ready 状态展示四个核心区块。
void main() {
  Future<void> pumpInsightsPage(
    WidgetTester tester, {
    required InsightsViewState state,
    Locale locale = const Locale('zh'),
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          insightsControllerProvider.overrideWith(
            () => _FakeInsightsController(state),
          ),
        ],
        child: MaterialApp(
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: InsightsPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('洞察首页 ready 状态展示周报摘要、稳定度、原因分布和恢复效果', (tester) async {
    await pumpInsightsPage(tester, state: _readyInsightsState());

    expect(find.text('最近 7 天达标率 56%，稳定度 72 分。最晚的一天在周三。'), findsOneWidget);
    expect(find.text('主要晚睡原因'), findsOneWidget);
    expect(find.text('恢复效果'), findsOneWidget);
    expect(find.text('查看完整周报'), findsOneWidget);
  });

  testWidgets('empty 状态显示空态说明', (tester) async {
    await pumpInsightsPage(
      tester,
      state: const InsightsViewState(status: InsightsStatus.empty),
    );

    expect(find.text('洞察'), findsOneWidget);
  });

  testWidgets('英文环境下洞察首页不会混入中文标题', (tester) async {
    await pumpInsightsPage(
      tester,
      locale: const Locale('en'),
      state: _readyInsightsState(),
    );

    expect(
      find.text(
        'Your on-track rate was 56% over the last 7 days, with a stability score of 72. The latest night was on Wed.',
      ),
      findsOneWidget,
    );
    expect(find.text('Main late-night reasons'), findsOneWidget);
    expect(find.text('Recovery effect'), findsOneWidget);
    expect(find.text('View full weekly report'), findsOneWidget);
    expect(find.text('主要晚睡原因'), findsNothing);
  });

  testWidgets('暗色主题下洞察页概览卡使用主题化容器底色', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          insightsControllerProvider.overrideWith(
            () => _FakeInsightsController(_readyInsightsState()),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: ThemeMode.dark,
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: InsightsPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final overviewCard = tester.widget<Card>(
      find.byKey(const Key('insights-overview-card')),
    );
    expect(
      overviewCard.color,
      AppTheme.dark().colorScheme.surface.withValues(alpha: 0.9),
    );
  });
}

class _FakeInsightsController extends InsightsController {
  _FakeInsightsController(this._state);

  final InsightsViewState _state;

  @override
  Future<InsightsViewState> build() async {
    return _state;
  }
}

InsightsViewState _readyInsightsState() {
  return InsightsViewState(
    status: InsightsStatus.ready,
    weeklyReport: WeeklyReport(
      startDate: DateTime.utc(2026, 5, 18),
      endDate: DateTime.utc(2026, 5, 24),
      days: List<WeeklyReportDaySnapshot>.generate(
        7,
        (index) => WeeklyReportDaySnapshot(
          date: DateTime.utc(2026, 5, 18 + index),
          sleepOffsetMinutes: index == 2 ? 112 : 18,
          qualified: index != 2,
          tags: index == 2 ? const <String>['加班', '刷手机'] : const <String>[],
        ),
      ),
      summary: const WeeklyReportSummary(
        qualifiedDayCount: 4,
        totalRecordedDays: 7,
        onTrackRate: 56,
        stabilityScore: 72,
        latestLateDayWeekday: DateTime.wednesday,
        latestLateSleepMinutesOfDay: 82,
        latestLateOffsetMinutes: 112,
        primaryReasonLabel: '刷手机',
      ),
      reasonDistribution: const <ReasonDistributionItem>[
        ReasonDistributionItem(label: '刷手机', count: 3, ratio: 0.5),
        ReasonDistributionItem(label: '加班', count: 2, ratio: 0.33),
      ],
      recommendations: const <WeeklyRecommendation>[
        WeeklyRecommendation(type: WeeklyRecommendationType.finishWorkEarlier),
        WeeklyRecommendation(type: WeeklyRecommendationType.openRecoveryPlan),
      ],
    ),
    stabilityScore: const StabilityScore(
      score: 72,
      level: StabilityScoreLevel.recovering,
      sampleCount: 7,
      averageOffsetMinutes: 32,
      volatilityMinutes: 26,
    ),
    recoveryPlan: const RecoveryPlan(
      status: RecoveryPlanStatus.unread,
      horizonDays: 3,
      triggerOffsetMinutes: 112,
      steps: <RecoveryPlanStep>[
        RecoveryPlanStep(
          dayIndex: 1,
          type: RecoveryPlanStepType.closeWorkEarlier,
        ),
      ],
    ),
  );
}
