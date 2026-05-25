import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/app/bootstrap/launch_state_repository.dart';
import 'package:rhythm/app/rhythm_app.dart';
import 'package:rhythm/data/local/rhythm_database.dart';
import 'package:rhythm/features/preferences/data/shared_preferences_app_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 验证根应用会消费已保存的语言与主题偏好。
void main() {
  testWidgets('根应用会应用英语和深色主题偏好', (tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{
      LaunchStateRepository.onboardingCompletedKey: true,
      SharedPreferencesAppPreferencesRepository.localeKey: 'english',
      SharedPreferencesAppPreferencesRepository.themeKey: 'dark',
    });
    final preferences = await SharedPreferences.getInstance();
    final database = RhythmDatabase.inMemory();
    addTearDown(database.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
          rhythmDatabaseProvider.overrideWithValue(database),
        ],
        child: const RhythmApp(),
      ),
    );
    await tester.pump();

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(app.locale, const Locale('en'));
    expect(app.themeMode, ThemeMode.dark);
  });

  testWidgets('在我的页切换语言后会保留当前路由而不是回到首页', (tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{
      LaunchStateRepository.onboardingCompletedKey: true,
    });
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
        ],
        child: const RhythmApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('我的'));
    await tester.pumpAndSettle();
    expect(find.text('匿名用户'), findsOneWidget);

    await tester.tap(find.byKey(const Key('profile-preferences-locale-english')));
    await tester.pumpAndSettle();

    expect(find.text('Anonymous user'), findsOneWidget);
    expect(find.text('There is no record from last night yet'), findsNothing);
  });
}
