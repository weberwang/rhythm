import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/app/bootstrap/launch_state_repository.dart';
import 'package:rhythm/app/rhythm_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 创建用于根应用测试的共享偏好实例。
Future<SharedPreferences> createRootAppTestPreferences() async {
  SharedPreferences.setMockInitialValues({
    LaunchStateRepository.onboardingCompletedKey: true,
  });
  return SharedPreferences.getInstance();
}

/// 构建显式注入启动依赖的根应用测试装配。
Future<void> pumpRootApp(WidgetTester tester) async {
  final sharedPreferences = await createRootAppTestPreferences();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const RhythmApp(),
    ),
  );
}

/// 验证根应用在显式注入启动依赖后保持既有导航与主题行为。
void main() {
  testWidgets('应用同时挂载亮色和暗色主题并跟随系统', (tester) async {
    await pumpRootApp(tester);

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(materialApp.theme, isNotNull);
    expect(materialApp.darkTheme, isNotNull);
    expect(materialApp.themeMode, ThemeMode.system);
    expect(materialApp.darkTheme!.brightness, Brightness.dark);
    expect(
      materialApp.darkTheme!.scaffoldBackgroundColor,
      isNot(equals(materialApp.theme!.scaffoldBackgroundColor)),
    );
  });

  testWidgets('启动后展示五个一级模块并默认进入今日页', (tester) async {
    await pumpRootApp(tester);
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('今日'), findsWidgets);
    expect(find.text('日历'), findsOneWidget);
    expect(find.text('睡前'), findsOneWidget);
    expect(find.text('洞察'), findsOneWidget);
    expect(find.text('我的'), findsOneWidget);
    expect(find.text('今晚先轻一点'), findsOneWidget);
  });

  testWidgets('点击底部模块后切换到对应页面', (tester) async {
    await pumpRootApp(tester);
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.tap(find.text('日历'));
    await tester.pumpAndSettle();

    expect(find.text('用热力图看清最近的作息节奏。'), findsOneWidget);
  });
}
