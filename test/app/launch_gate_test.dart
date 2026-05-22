import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/bootstrap/launch_state_repository.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 创建带指定首次引导状态的共享偏好实例。
Future<SharedPreferences> createLaunchTestPreferences({
  required bool? onboardingCompleted,
}) async {
  final values = <String, Object>{};
  if (onboardingCompleted != null) {
    values[LaunchStateRepository.onboardingCompletedKey] = onboardingCompleted;
  }
  SharedPreferences.setMockInitialValues(values);
  return SharedPreferences.getInstance();
}

/// 构建走真实启动状态装配链路的测试应用。
Widget buildLaunchTestApp({required SharedPreferences sharedPreferences}) {
  return ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
    child: MaterialApp.router(routerConfig: createAppRouter()),
  );
}

/// 验证启动分发会根据首次引导状态进入正确路由。
void main() {
  testWidgets('首次启动时跳转到引导欢迎页', (tester) async {
    final sharedPreferences = await createLaunchTestPreferences(
      onboardingCompleted: false,
    );

    await tester.pumpWidget(
      buildLaunchTestApp(sharedPreferences: sharedPreferences),
    );
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('首次引导占位页'), findsOneWidget);
  });

  testWidgets('已完成引导时跳转到今日页', (tester) async {
    final sharedPreferences = await createLaunchTestPreferences(
      onboardingCompleted: true,
    );

    await tester.pumpWidget(
      buildLaunchTestApp(sharedPreferences: sharedPreferences),
    );
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('今晚先轻一点'), findsOneWidget);
  });
}
