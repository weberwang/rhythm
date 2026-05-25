import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/app/bootstrap/launch_state_repository.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/data/local/rhythm_database.dart';
import 'package:rhythm/features/sleep_records/presentation/manual_sleep_record_page.dart';
import 'package:rhythm/features/sleep_records/presentation/sleep_records_hub_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../support/sleep_records_test_app.dart';

/// 验证阶段三管理页可进入手动补录页。
void main() {
  testWidgets('从睡眠记录管理页进入手动补录页', (tester) async {
    await pumpSleepRecordsFlowApp(tester);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, '改用手动模式'));
    await tester.pumpAndSettle();

    expect(find.text('手动补录'), findsOneWidget);
    expect(find.text('手动确认昨晚的睡眠结果'), findsOneWidget);
    expect(find.text('归属日期'), findsOneWidget);
    expect(find.text('入睡时间'), findsOneWidget);
    expect(find.text('起床时间'), findsOneWidget);
    expect(find.text('保存补录结果'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
  });

  testWidgets('从管理页进入手动补录会保留返回栈', (tester) async {
    final router = await _pumpSleepRecordsFlowRouterApp(tester);

    expect(router.canPop(), isFalse);

    await tester.tap(find.widgetWithText(FilledButton, '改用手动模式').first);
    await tester.pumpAndSettle();

    expect(find.text('手动补录'), findsOneWidget);
    expect(router.canPop(), isTrue);
  });

  testWidgets('手动补录说明卡占满手机内容区宽度', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await pumpSleepRecordsFlowApp(tester);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, '改用手动模式'));
    await tester.pumpAndSettle();

    final card = find.ancestor(
      of: find.text('修正说明'),
      matching: find.byType(Card),
    );

    expect(tester.getSize(card).width, closeTo(342, 0.1));
  });

  testWidgets('手动补录作为二级页打开时放弃会返回来源页', (tester) async {
    final router = await _pumpSleepRecordsFlowRouterApp(
      tester,
      initialLocation: '/source',
      routes: [
        GoRoute(
          path: '/source',
          builder: (context, state) => Scaffold(
            body: Center(
              child: FilledButton(
                onPressed: () => context.push(manualSleepRecordPath),
                child: const Text('open-manual'),
              ),
            ),
          ),
        ),
        GoRoute(
          path: manualSleepRecordPath,
          builder: (context, state) => ManualSleepRecordPage(
            editingRecordId: state.uri.queryParameters['recordId'],
          ),
        ),
      ],
    );

    await tester.tap(find.text('open-manual'));
    await tester.pumpAndSettle();

    expect(find.text('手动补录'), findsOneWidget);
    expect(router.canPop(), isTrue);

    await tester.scrollUntilVisible(find.text('放弃本次修改'), 200);
    await tester.tap(find.text('放弃本次修改'));
    await tester.pumpAndSettle();

    expect(find.text('open-manual'), findsOneWidget);
  });
}

/// 构建可观测返回栈的睡眠记录路由测试应用，验证二级页是否通过 push 入栈。
Future<GoRouter> _pumpSleepRecordsFlowRouterApp(
  WidgetTester tester, {
  String initialLocation = sleepRecordsHubPath,
  List<GoRoute>? routes,
  List<dynamic> overrides = const <dynamic>[],
}) async {
  SharedPreferences.setMockInitialValues({
    LaunchStateRepository.onboardingCompletedKey: true,
  });
  final sharedPreferences = await SharedPreferences.getInstance();
  final database = RhythmDatabase.inMemory();
  final router = GoRouter(
    initialLocation: initialLocation,
    routes:
        routes ??
        [
          GoRoute(
            path: sleepRecordsHubPath,
            builder: (context, state) => const SleepRecordsHubPage(),
          ),
          GoRoute(
            path: manualSleepRecordPath,
            builder: (context, state) => ManualSleepRecordPage(
              editingRecordId: state.uri.queryParameters['recordId'],
            ),
          ),
        ],
  );

  addTearDown(database.close);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        rhythmDatabaseProvider.overrideWithValue(database),
        ...overrides,
      ],
      child: MaterialApp.router(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    ),
  );
  await tester.pumpAndSettle();

  return router;
}
