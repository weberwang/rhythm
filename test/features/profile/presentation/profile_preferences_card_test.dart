import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/app/theme/app_theme.dart';
import 'package:rhythm/data/local/rhythm_database.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/preferences/application/app_preferences_providers.dart';
import 'package:rhythm/features/profile/presentation/profile_page.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 验证我的页偏好设置卡片会展示并驱动全局语言与主题切换。
void main() {
  testWidgets('我的页展示偏好设置卡片并默认显示跟随系统', (tester) async {
    await _pumpProfilePreferencesPage(tester);

    expect(find.text('偏好设置'), findsOneWidget);
    expect(find.text('语言'), findsOneWidget);
    expect(find.text('主题'), findsOneWidget);
    expect(find.text('跟随系统'), findsWidgets);
  });

  testWidgets('切换为 English 后当前页立即刷新英文文案', (tester) async {
    await _pumpProfilePreferencesPage(tester);

    await tester.tap(
      find.byKey(const Key('profile-preferences-locale-english')),
    );
    await tester.pumpAndSettle();

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.locale, const Locale('en'));
    expect(find.text('Preferences'), findsOneWidget);
    expect(find.text('Anonymous user'), findsOneWidget);
  });

  testWidgets('切换为深色后当前壳会立即刷新主题模式', (tester) async {
    await _pumpProfilePreferencesPage(tester);

    await tester.tap(find.byKey(const Key('profile-preferences-theme-dark')));
    await tester.pumpAndSettle();

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);
  });
}

/// 构建测试壳，让我的页偏好切换能直接驱动 MaterialApp 的全局状态。
Future<void> _pumpProfilePreferencesPage(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues(<String, Object>{});
  final preferences = await SharedPreferences.getInstance();
  final database = RhythmDatabase.inMemory();
  addTearDown(database.close);
  tester.binding.platformDispatcher.localeTestValue = const Locale('zh');
  tester.binding.platformDispatcher.localesTestValue = const <Locale>[
    Locale('zh'),
  ];
  addTearDown(() {
    tester.binding.platformDispatcher.clearLocaleTestValue();
    tester.binding.platformDispatcher.clearLocalesTestValue();
  });

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
        rhythmDatabaseProvider.overrideWithValue(database),
        savedGoalScheduleSettingsProvider.overrideWith((ref) async => null),
        healthPlatformStateProvider.overrideWith(
          (ref) async => HealthPlatformState.iosAvailable(),
        ),
      ],
      child: const _ProfilePreferencesTestApp(),
    ),
  );
  await tester.pumpAndSettle();
}

/// 将全局偏好 provider 直接挂到 MaterialApp，便于验证即时语言与主题切换。
class _ProfilePreferencesTestApp extends ConsumerWidget {
  /// 创建我的页偏好测试壳。
  const _ProfilePreferencesTestApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      locale: ref.watch(appLocaleProvider),
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ref.watch(appThemeModeProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const ProfilePage(),
    );
  }
}
