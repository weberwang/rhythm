import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/app/bootstrap/launch_state_repository.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 创建首次引导流测试用的共享偏好实例。
Future<SharedPreferences> createOnboardingFlowTestPreferences() async {
  SharedPreferences.setMockInitialValues({
    LaunchStateRepository.onboardingCompletedKey: false,
  });
  return SharedPreferences.getInstance();
}

/// 构建使用真实路由的首次引导测试应用。
Widget buildOnboardingFlowTestApp({
  required SharedPreferences sharedPreferences,
}) {
  return ProviderScope(
    overrides: [sharedPreferencesProvider.overrideWithValue(sharedPreferences)],
    child: MaterialApp.router(routerConfig: createAppRouter()),
  );
}

/// 验证三步首次引导流会按既定顺序推进到目标设置入口。
void main() {
  testWidgets('欢迎页到匿名登录再到健康权限说明后可跳转目标设置', (tester) async {
    final sharedPreferences = await createOnboardingFlowTestPreferences();

    await tester.pumpWidget(
      buildOnboardingFlowTestApp(sharedPreferences: sharedPreferences),
    );
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('欢迎使用 Rhythm'), findsOneWidget);

    await tester.tap(find.text('开始设置'));
    await tester.pumpAndSettle();

    expect(find.text('选择你的进入方式'), findsOneWidget);

    await tester.tap(find.text('匿名体验'));
    await tester.pumpAndSettle();

    expect(find.text('连接健康数据，记录会更完整'), findsOneWidget);

    await tester.tap(find.text('先用手动模式'));
    await tester.pumpAndSettle();

    expect(find.text('目标设置即将开放'), findsOneWidget);
  });

  testWidgets('点击开始设置后立即切换到登录方式步骤', (tester) async {
    final sharedPreferences = await createOnboardingFlowTestPreferences();

    await tester.pumpWidget(
      buildOnboardingFlowTestApp(sharedPreferences: sharedPreferences),
    );
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.tap(find.text('开始设置'));
    await tester.pump();

    expect(find.text('选择你的进入方式'), findsOneWidget);
  });
}
