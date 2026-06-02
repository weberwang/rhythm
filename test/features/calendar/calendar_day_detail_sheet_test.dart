import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_mood.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/domain/calendar_heat_level.dart';
import 'package:rhythm/features/calendar/presentation/widgets/sheets/calendar_day_detail_sheet.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证单日详情弹层会解释记录偏差、来源和标签。
void main() {
  testWidgets('详情弹层展示睡眠信息和标签入口', (tester) async {
    await tester.pumpWidget(_buildSheetApp(const Locale('zh'), _sheet()));
    await tester.pumpAndSettle();

    expect(find.text('5 月 24 日'), findsOneWidget);
    expect(find.text('实际入睡'), findsOneWidget);
    expect(find.text('来源与可信度'), findsOneWidget);
    expect(find.text('刷手机'), findsOneWidget);
    expect(find.text('添加标签'), findsOneWidget);
  });

  testWidgets('详情弹层提供来源说明入口', (tester) async {
    await tester.pumpWidget(_buildSheetApp(const Locale('zh'), _sheet()));
    await tester.pumpAndSettle();

    expect(find.text('数据来源说明'), findsOneWidget);
  });

  testWidgets('英文环境下详情弹层使用本地化日期与偏差文案', (tester) async {
    await tester.pumpWidget(
      _buildSheetApp(
        const Locale('en'),
        _sheet(
          tags: const <String>['Phone scrolling'],
          primaryMood: null,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('May 24'), findsOneWidget);
    expect(find.text('50 minutes'), findsOneWidget);
    expect(find.text('HealthKit / High confidence'), findsOneWidget);
    expect(find.text('5 月 24 日'), findsNothing);
  });

  testWidgets('详情弹层会复用主情绪导条', (tester) async {
    await tester.pumpWidget(_buildSheetApp(const Locale('zh'), _sheet()));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('calendar-day-mood-accent')), findsOneWidget);
  });

  testWidgets('详情弹层在无主情绪时不显示情绪导条', (tester) async {
    await tester.pumpWidget(
      _buildSheetApp(
        const Locale('zh'),
        _sheet(tags: const <String>[], primaryMood: null),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('calendar-day-mood-accent')), findsNothing);
  });

  testWidgets('详情弹层提供编辑记录入口', (tester) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: _sheet(),
          ),
        ),
        GoRoute(
          path: manualSleepRecordPath,
          builder: (context, state) => const Scaffold(body: Text('编辑页')),
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

    expect(find.text('编辑昨晚记录'), findsOneWidget);
  });
}

/// 构造统一的详情弹层装配，避免每个测试重复声明来源说明回调。
Widget _buildSheetApp(Locale locale, Widget child) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}

/// 统一构造详情卡测试实例，保持测试聚焦在显示层断言。
Widget _sheet({
  List<String> tags = const <String>['刷手机'],
  CalendarDayMood? primaryMood = CalendarDayMood.drained,
}) {
  return CalendarDayDetailSheet(
    summary: CalendarDaySummary(
      date: DateTime.utc(2026, 5, 24),
      record: _buildRecord(),
      sleepOffsetMinutes: 50,
      heatLevel: CalendarHeatLevel.late,
      tags: tags,
      primaryMood: primaryMood,
      hasSecondaryMood: false,
    ),
    onAddTag: () {},
    onExplainSource: () {},
  );
}

/// 构造详情弹层测试用记录。
EffectiveSleepRecord _buildRecord() {
  final fellAsleepAt = DateTime.utc(2026, 5, 25, 0, 20);
  return EffectiveSleepRecord(
    recordId: 'r1',
    recordDate: DateTime.utc(2026, 5, 24),
    fellAsleepAt: fellAsleepAt,
    wokeUpAt: fellAsleepAt.add(const Duration(hours: 8)),
    durationMinutes: 8 * 60,
    source: SleepRecordSource.healthKit,
    confidence: SleepRecordConfidence.high,
    timezone: 'Asia/Shanghai',
    isUserConfirmed: false,
    sourceRecordId: null,
  );
}
