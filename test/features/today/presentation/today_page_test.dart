import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/theme/app_theme.dart';
import 'package:rhythm/features/today/application/today_controller.dart';
import 'package:rhythm/features/today/application/today_view_state.dart';
import 'package:rhythm/features/today/domain/today_primary_action.dart';
import 'package:rhythm/features/today/domain/today_summary.dart';
import 'package:rhythm/features/today/presentation/today_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证今日页根据控制器状态渲染首屏结构。
void main() {
  Future<void> pumpPage(
    WidgetTester tester, {
    required TodayViewState state,
    Locale locale = const Locale('zh'),
  }) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [todayControllerProvider.overrideWith((ref) async => state)],
        child: MaterialApp(
          locale: locale,
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: TodayPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('ready 状态显示状态卡、行动卡和趋势标题', (tester) async {
    await pumpPage(
      tester,
      state: TodayViewState(
        status: TodayViewStatus.ready,
        prioritizeRecoveryCard: false,
        summary: _buildSummary(),
      ),
    );

    expect(find.text('昨晚结果'), findsOneWidget);
    expect(find.text('今晚行动'), findsOneWidget);
    expect(find.text('快捷记录'), findsOneWidget);
    expect(find.text('最近 7 天'), findsOneWidget);
  });

  testWidgets('ready 状态将昨晚结果与今晚行动合并到同一张主卡', (tester) async {
    await pumpPage(
      tester,
      state: TodayViewState(
        status: TodayViewStatus.ready,
        prioritizeRecoveryCard: false,
        summary: _buildSummary(),
      ),
    );

    final statusCard = find.ancestor(
      of: find.text('昨晚结果'),
      matching: find.byType(Card),
    );
    final actionCard = find.ancestor(
      of: find.text('今晚行动'),
      matching: find.byType(Card),
    );

    expect(statusCard, findsOneWidget);
    expect(actionCard, findsOneWidget);
    expect(
      statusCard.evaluate().single.widget,
      same(actionCard.evaluate().single.widget),
    );
  });

  testWidgets('ready 状态主卡拉满页面内容宽度', (tester) async {
    await pumpPage(
      tester,
      state: TodayViewState(
        status: TodayViewStatus.ready,
        prioritizeRecoveryCard: false,
        summary: _buildSummary(),
      ),
    );

    final statusCard = find.ancestor(
      of: find.text('昨晚结果'),
      matching: find.byType(Card),
    );

    expect(tester.getSize(statusCard).width, moreOrLessEquals(382, epsilon: 1));
  });

  testWidgets('empty 状态显示手动补录空态', (tester) async {
    await pumpPage(
      tester,
      state: const TodayViewState(
        status: TodayViewStatus.empty,
        prioritizeRecoveryCard: false,
      ),
    );

    expect(find.text('昨晚还没有记录'), findsOneWidget);
    expect(find.text('手动补录昨晚记录'), findsOneWidget);
  });

  testWidgets('permissionFailed 状态显示权限说明入口', (tester) async {
    await pumpPage(
      tester,
      state: const TodayViewState(
        status: TodayViewStatus.permissionFailed,
        prioritizeRecoveryCard: false,
      ),
    );

    expect(find.text('系统睡眠记录暂时不可用'), findsOneWidget);
    expect(find.text('查看权限说明'), findsOneWidget);
  });

  testWidgets('goalMissing 状态显示目标设置入口', (tester) async {
    await pumpPage(
      tester,
      state: const TodayViewState(
        status: TodayViewStatus.goalMissing,
        prioritizeRecoveryCard: false,
      ),
    );

    expect(find.text('还没有设置作息目标'), findsOneWidget);
    expect(find.text('去设置目标作息'), findsOneWidget);
  });

  testWidgets('恢复建议优先展示时显示恢复建议卡', (tester) async {
    await pumpPage(
      tester,
      state: TodayViewState(
        status: TodayViewStatus.ready,
        prioritizeRecoveryCard: true,
        summary: _buildSummary(showRecoveryCard: true),
      ),
    );

    expect(find.text('恢复建议'), findsOneWidget);
  });

  testWidgets('英文环境下 ready 状态使用完整英文文案', (tester) async {
    await pumpPage(
      tester,
      locale: const Locale('en'),
      state: TodayViewState(
        status: TodayViewStatus.ready,
        prioritizeRecoveryCard: true,
        summary: _buildSummary(showRecoveryCard: true),
      ),
    );

    expect(find.text('Last night'), findsOneWidget);
    expect(find.text('Tonight action'), findsOneWidget);
    expect(find.text('Quick log'), findsOneWidget);
    expect(find.text('Recovery suggestion'), findsOneWidget);
    expect(find.text('Last 7 days'), findsOneWidget);
    expect(find.text('Late by 45 minutes'), findsOneWidget);
    expect(find.text('Tonight target 23:30'), findsOneWidget);
    expect(find.text('View recovery suggestions'), findsOneWidget);
    expect(find.text('今晚行动'), findsNothing);
  });
}

TodaySummary _buildSummary({bool showRecoveryCard = false}) {
  return TodaySummary(
    hasRecord: true,
    isGoalMet: !showRecoveryCard,
    sleepOffsetMinutes: showRecoveryCard ? 45 : 15,
    isUserConfirmedRecord: false,
    showRecoveryCard: showRecoveryCard,
    primaryAction: showRecoveryCard
        ? TodayPrimaryAction.viewRecoveryPlan
        : TodayPrimaryAction.enterBedtimeMode,
    latestRecord: null,
    targetBedtimeMinutes: 23 * 60 + 30,
    trendOffsets: const <int>[10, -5, 15],
  );
}
