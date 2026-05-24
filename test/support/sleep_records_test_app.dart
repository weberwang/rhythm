import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/app/bootstrap/launch_state_repository.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/sleep_records/presentation/manual_sleep_record_page.dart';
import 'package:rhythm/features/sleep_records/presentation/sleep_records_hub_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 仅挂载阶段三睡眠记录路由，避免测试入口受后续今日页实现波动影响。
Future<void> pumpSleepRecordsFlowApp(
  WidgetTester tester, {
  String initialLocation = sleepRecordsHubPath,
  Locale locale = const Locale('zh'),
  List<dynamic> overrides = const <dynamic>[],
}) async {
  SharedPreferences.setMockInitialValues({
    LaunchStateRepository.onboardingCompletedKey: true,
  });
  final sharedPreferences = await SharedPreferences.getInstance();
  final router = GoRouter(
    initialLocation: initialLocation,
    routes: [
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

  tester.binding.platformDispatcher.localeTestValue = locale;
  tester.binding.platformDispatcher.localesTestValue = <Locale>[locale];
  addTearDown(() {
    tester.binding.platformDispatcher.clearLocaleTestValue();
    tester.binding.platformDispatcher.clearLocalesTestValue();
  });

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ...overrides,
      ],
      child: MaterialApp.router(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    ),
  );
  await tester.pump();
}
