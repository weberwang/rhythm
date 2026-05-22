import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/app/bootstrap/launch_state_repository.dart';
import 'package:rhythm/app/rhythm_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 创建用于本地化根应用测试的共享偏好实例。
Future<SharedPreferences> createLocalizationTestPreferences() async {
  SharedPreferences.setMockInitialValues({
    LaunchStateRepository.onboardingCompletedKey: true,
  });
  return SharedPreferences.getInstance();
}

/// 验证应用根组件接入 Flutter 国际化生成配置。
void main() {
  testWidgets('App 根组件配置本地化代理和支持语言', (tester) async {
    final sharedPreferences = await createLocalizationTestPreferences();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
        child: const RhythmApp(),
      ),
    );

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(app.localizationsDelegates, isNotNull);
    expect(app.localizationsDelegates!.length, greaterThanOrEqualTo(4));
    expect(app.supportedLocales, contains(const Locale('en')));
    expect(app.supportedLocales, contains(const Locale('zh')));
  });
}
