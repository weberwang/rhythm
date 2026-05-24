import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/app/router/app_router.dart';
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
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: CalendarDayDetailSheet(
            summary: CalendarDaySummary(
              date: DateTime.utc(2026, 5, 24),
              record: _buildRecord(),
              sleepOffsetMinutes: 50,
              heatLevel: CalendarHeatLevel.late,
              tags: const <String>['刷手机'],
            ),
            onAddTag: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('5 月 24 日'), findsOneWidget);
    expect(find.text('实际入睡'), findsOneWidget);
    expect(find.text('来源与可信度'), findsOneWidget);
    expect(find.text('刷手机'), findsOneWidget);
    expect(find.text('添加标签'), findsOneWidget);
  });

  testWidgets('详情弹层提供编辑记录入口', (tester) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: CalendarDayDetailSheet(
              summary: CalendarDaySummary(
                date: DateTime.utc(2026, 5, 24),
                record: _buildRecord(),
                sleepOffsetMinutes: 50,
                heatLevel: CalendarHeatLevel.late,
                tags: const <String>[],
              ),
              onAddTag: () {},
            ),
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
