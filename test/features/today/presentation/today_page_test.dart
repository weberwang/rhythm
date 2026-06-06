import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/features/today/application/providers/today_snapshot_provider.dart';
import 'package:rhythm/features/today/application/providers/today_quick_record_controller.dart';
import 'package:rhythm/features/today/domain/entities/today_snapshot.dart';
import 'package:rhythm/features/today/presentation/pages/today_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证 today 首屏按照冻结顺序落区块，而不是退化成占位页。
void main() {
  testWidgets('today page shows the five ordered sections from snapshot', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          todaySnapshotProvider.overrideWith(
            (ref) async => TodaySnapshot(
              displayName: 'Alex',
              lastNight: const TodayLastNightSummary(
                status: TodayLastNightStatus.noData,
                scoreLabel: '等待首晚',
                primaryMetricLabel: '目标已就绪',
                primaryMetricValue: '22:30',
                secondaryMetricLabel: '同步状态',
                secondaryMetricValue: '本地优先',
                tertiaryMetricLabel: '当前来源',
                tertiaryMetricValue: '待建立',
              ),
              tonightGoal: const TodayTonightGoalSummary(
                bedtimeMinutes: 22 * 60 + 30,
                wakeTimeMinutes: 7 * 60,
                windDownMinutes: 21 * 60 + 45,
                bedtimeLabel: '10:30 PM',
                wakeTimeLabel: '7:00 AM',
                windDownLabel: '9:45 PM',
              ),
              recovery: const TodayRecoverySummary(
                status: TodayRecoveryStatus.buildBaseline,
              ),
              quickRecord: const TodayQuickRecordSummary(
                status: TodayQuickRecordStatus.recommended,
              ),
              trend: const TodayTrendSummary(
                status: TodayTrendStatus.building,
                points: [],
                averageScore: null,
              ),
            ),
          ),
          todayQuickRecordControllerProvider.overrideWith(
            () => _FakeTodayQuickRecordController(),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TodayPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Rhythm'), findsOneWidget);
    expect(find.text('早安，Alex'), findsOneWidget);
    expect(find.text('先看昨晚，再决定今晚怎么做。'), findsOneWidget);
    expect(find.byIcon(Icons.person_outline_rounded), findsOneWidget);
    expect(find.byIcon(Icons.wb_sunny_rounded), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName ==
                'assets/images/today/today_moon_badge.png',
      ),
      findsOneWidget,
    );
    expect(find.text('昨晚结果'), findsOneWidget);
    expect(find.text('今晚目标'), findsOneWidget);
    expect(find.text('目标入睡时间'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('恢复建议'), 180);
    await tester.pumpAndSettle();
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName ==
                'assets/images/today/today_recovery_plant.png',
      ),
      findsOneWidget,
    );
    expect(find.text('恢复建议'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('快捷记录'), 300);
    await tester.pumpAndSettle();
    expect(find.text('快捷记录'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('7 日趋势'), 220);
    await tester.pumpAndSettle();
    expect(find.text('7 日趋势'), findsOneWidget);
    expect(find.text('睡眠分'), findsOneWidget);
    expect(find.text('Mon'), findsNothing);
    expect(find.byIcon(Icons.chevron_right_rounded), findsNWidgets(2));

    await tester.tap(find.text('快捷记录'));
    await tester.pumpAndSettle();

    expect(find.text('补录昨晚记录'), findsOneWidget);
    expect(find.text('保存记录'), findsOneWidget);
  });
}

/// 用轻量假控制器承接 today 页面交互，避免该测试依赖真实存储。
class _FakeTodayQuickRecordController extends TodayQuickRecordController {
  @override
  Future<void> build() async {}

  @override
  Future<void> submit({
    required DateTime sleepDate,
    required int bedtimeMinutes,
    required int wakeTimeMinutes,
    String? note,
  }) async {}
}
