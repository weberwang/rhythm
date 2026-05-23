import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/app/bootstrap/launch_state_repository.dart';
import 'package:rhythm/app/rhythm_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 为测试构建共享偏好实例，显式控制首次引导完成状态。
Future<SharedPreferences> createTestPreferences({
  required bool onboardingCompleted,
}) async {
  SharedPreferences.setMockInitialValues({
    LaunchStateRepository.onboardingCompletedKey: onboardingCompleted,
  });
  return SharedPreferences.getInstance();
}

/// 注入启动依赖并挂载根应用，避免测试各自维护重复装配逻辑。
Future<void> pumpRhythmApp(
  WidgetTester tester, {
  required bool onboardingCompleted,
  Locale locale = const Locale('zh'),
}) async {
  final sharedPreferences = await createTestPreferences(
    onboardingCompleted: onboardingCompleted,
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
      ],
      child: const RhythmApp(),
    ),
  );
  await tester.pump();
}
