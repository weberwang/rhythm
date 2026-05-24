import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
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
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          todayControllerProvider.overrideWith((ref) async => state),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
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
