// ignore_for_file: depend_on_referenced_packages
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rhythm/app/entry/rhythm_bootstrap_app.dart';
import 'package:rhythm/app/theme/rhythm_theme.dart';
import 'package:rhythm/features/app_shell/infrastructure/app_shell_launch_state_store.dart';
import 'package:rhythm/features/app_shell/domain/app_shell_models.dart';
import 'package:rhythm/features/app_shell/presentation/startup_gate_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/test/test_flutter_secure_storage_platform.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('生成 root-shell overlay 成功态运行截图', (tester) async {
    _configurePhoneViewport(tester);
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
    expect(_matchesAnyText(['Session restored.', '会话已恢复。']), findsOneWidget);

    await _saveRuntimeScreenshot(
      binding: binding,
      screenshotName: 'app-shell-root-shell-overlay-success-390x844',
      outputPath:
          'docs/project/modules/app-shell/app-shell-runtime-root-shell-overlay-success-390x844.png',
    );
  });

  testWidgets('生成 blocked handoff 运行截图', (tester) async {
    _configurePhoneViewport(tester);
    final router = GoRouter(
      initialLocation: '/handoff',
      routes: [
        GoRoute(
          path: '/handoff',
          builder: (context, state) {
            return const DeepLinkHandoffPage(
              args: DeepLinkHandoffArgs.blocked(
                target: LaunchRouteTarget.onboarding,
                reason: 'deepLinkNeedsOnboarding',
              ),
            );
          },
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        theme: buildRhythmLightTheme(),
        routerConfig: router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
    await tester.pumpAndSettle();

    expect(_matchesAnyText(['Redirecting safely', '正在安全回退']), findsOneWidget);
    expect(_matchesAnyText(['Complete onboarding', '完成引导']), findsOneWidget);

    await _saveRuntimeScreenshot(
      binding: binding,
      screenshotName: 'app-shell-handoff-blocked-390x844',
      outputPath:
          'docs/project/modules/app-shell/app-shell-runtime-handoff-blocked-390x844.png',
    );
  });
}

/// 将测试视口固定到共享设计基线尺寸，便于后续与冻结设计对齐。
void _configurePhoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

/// 把集成测试截图直接写入工作流证据目录，避免人工转存。
Future<void> _saveRuntimeScreenshot({
  required IntegrationTestWidgetsFlutterBinding binding,
  required String screenshotName,
  required String outputPath,
}) async {
  await binding.convertFlutterSurfaceToImage();
  final bytes = await binding.takeScreenshot(screenshotName);
  final file = File(outputPath);
  await file.parent.create(recursive: true);
  await file.writeAsBytes(bytes, flush: true);
}

/// 兼容中英文环境的文本匹配，避免运行设备 locale 导致证据测试不稳定。
Finder _matchesAnyText(List<String> candidates) {
  return find.byWidgetPredicate((widget) {
    return widget is Text && candidates.contains(widget.data);
  });
}
