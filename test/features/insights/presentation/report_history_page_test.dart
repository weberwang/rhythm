import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/insights/application/insights_controller.dart';
import 'package:rhythm/features/insights/application/insights_view_state.dart';
import 'package:rhythm/features/insights/domain/weekly_report.dart';
import 'package:rhythm/features/insights/presentation/report_history_page.dart';
import 'package:rhythm/features/membership/application/membership_controller.dart';
import 'package:rhythm/features/membership/domain/membership_entitlement.dart';
import 'package:rhythm/features/membership/domain/membership_snapshot.dart';
import 'package:rhythm/features/membership/presentation/membership_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证历史洞察页进入会员中心时会保留返回栈，而不是直接覆盖来源页。
void main() {
  testWidgets('从历史洞察进入会员中心后返回会回到历史页', (tester) async {
    final router = GoRouter(
      initialLocation: '/source',
      routes: [
        GoRoute(
          path: '/source',
          builder: (context, state) => Scaffold(
            body: Center(
              child: FilledButton(
                onPressed: () => context.push(insightsHistoryPath),
                child: const Text('open-history'),
              ),
            ),
          ),
        ),
        GoRoute(
          path: insightsHistoryPath,
          builder: (context, state) => ProviderScope(
            overrides: [
              insightsControllerProvider.overrideWith(
                _FakeInsightsController.new,
              ),
            ],
            child: const ReportHistoryPage(),
          ),
        ),
        GoRoute(
          path: membershipCenterPath,
          builder: (context, state) => ProviderScope(
            overrides: [
              membershipControllerProvider.overrideWith(
                () => _FakeMembershipController(),
              ),
            ],
            child: const MembershipPage(),
          ),
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('open-history'));
    await tester.pumpAndSettle();

    expect(find.byType(ReportHistoryPage), findsOneWidget);

    await tester.tap(find.byType(FilledButton).last);
    await tester.pumpAndSettle();

    expect(find.byType(MembershipPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(ReportHistoryPage), findsOneWidget);
    expect(find.text('open-history'), findsNothing);
  });
}

/// 提供历史洞察页测试控制器，避免页面测试依赖真实洞察聚合逻辑。
class _FakeInsightsController extends InsightsController {
  @override
  Future<InsightsViewState> build() async {
    return InsightsViewState(
      status: InsightsStatus.ready,
      history: <WeeklyReport>[
        WeeklyReport(
          startDate: DateTime.utc(2026, 5, 18),
          endDate: DateTime.utc(2026, 5, 24),
          days: const <WeeklyReportDaySnapshot>[],
          summary: const WeeklyReportSummary(
            qualifiedDayCount: 4,
            totalRecordedDays: 7,
            onTrackRate: 57,
            stabilityScore: 72,
            latestLateDayWeekday: 5,
            latestLateSleepMinutesOfDay: 60,
            latestLateOffsetMinutes: 45,
          ),
          reasonDistribution: const <ReasonDistributionItem>[],
          recommendations: const <WeeklyRecommendation>[],
        ),
      ],
    );
  }
}

/// 提供会员中心测试控制器，避免路由测试依赖真实购买链路。
class _FakeMembershipController extends MembershipController {
  @override
  Future<MembershipViewState> build() async {
    return MembershipViewState(
      snapshot: MembershipSnapshot.fallback(
        isConfigured: false,
        entitlement: const MembershipEntitlement.free(),
        plans: const <MembershipPlan>[
          MembershipPlan(
            packageId: 'annual_plan',
            tier: MembershipTier.annual,
            priceLabel: '¥98',
            isRecommended: true,
          ),
        ],
      ),
    );
  }
}
