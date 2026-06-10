// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rhythm/app/entry/rhythm_bootstrap_app.dart';
import 'package:rhythm/features/app_shell/infrastructure/app_shell_launch_state_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/test/test_flutter_secure_storage_platform.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('首次启动可从欢迎页继续进入 today 路由', (tester) async {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStoragePlatform.instance = TestFlutterSecureStoragePlatform(
      {},
    );

    await tester.pumpWidget(const RhythmBootstrapApp());
    await tester.pump();
    await tester.pumpAndSettle();

    expect(_matchesAnyText(['Welcome', '欢迎']), findsOneWidget);
    expect(
      _matchesAnyText(['Continue on this device', '先在本机继续']),
      findsOneWidget,
    );

    await tester.tap(_matchesAnyText(['Continue on this device', '先在本机继续']));
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.tap(_matchesAnyText(['Continue', '继续']));
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.tap(_matchesAnyText(['Stay manual for now', '先走手动路径']));
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.tap(_matchesAnyText(['Continue', '继续']));
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.tap(_matchesAnyText(['Continue', '继续']));
    await tester.pump();
    await tester.pumpAndSettle();

    await tester.tap(_matchesAnyText(['Enter Today', '进入今日']));
    await tester.pump();
    await tester.pumpAndSettle();

    final preferences = await SharedPreferences.getInstance();
    expect(
      preferences.getBool(AppShellLaunchStateStore.onboardingCompletedKey),
      isTrue,
    );
    expect(_matchesAnyText(['Today', '今日']), findsWidgets);
  });

  testWidgets('应用可完成 bootstrap 并进入 today 路由', (tester) async {
    SharedPreferences.setMockInitialValues({
      AppShellLaunchStateStore.onboardingCompletedKey: true,
    });
    FlutterSecureStoragePlatform.instance = TestFlutterSecureStoragePlatform({
      'session_access_token': 'token',
    });

    await tester.pumpWidget(const RhythmBootstrapApp());
    await tester.pump();
    await tester.pumpAndSettle();

    expect(_matchesAnyText(['Today', '今日']), findsWidgets);
    expect(
      _matchesAnyText(['Today feature bootstrap placeholder.', '今日模块底座占位页。']),
      findsOneWidget,
    );
    expect(_matchesAnyText(['Session restored.', '会话已恢复。']), findsOneWidget);
  });
}

/// 在集成测试里兼容设备本地化语言，避免把断言绑死在单一 locale。
Finder _matchesAnyText(List<String> candidates) {
  return find.byWidgetPredicate((widget) {
    return widget is Text && candidates.contains(widget.data);
  });
}
