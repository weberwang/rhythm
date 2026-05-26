import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/app/bootstrap/launch_state_provider.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/profile/presentation/profile_page.dart';
import 'package:rhythm/features/widget_bridge/application/widget_snapshot_service.dart';
import 'package:rhythm/features/widget_bridge/data/home_widget_gateway.dart';
import 'package:rhythm/features/widget_bridge/domain/widget_snapshot.dart';
import 'package:rhythm/features/widget_bridge/presentation/widget_theme_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 验证我的页会展示阶段八入口，并补上阶段十会员中心入口。
void main() {
  testWidgets('我的页展示账号卡、会员入口、五个设置入口和桌面存在感说明', (tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final preferences = await SharedPreferences.getInstance();
    final router = GoRouter(
      initialLocation: '/profile',
      routes: [
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
        child: MaterialApp.router(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('匿名用户'), findsOneWidget);
    expect(find.text('会员中心'), findsOneWidget);
    expect(find.text('目标作息设置'), findsOneWidget);
    expect(find.text('提醒设置'), findsOneWidget);
    expect(find.text('数据接入与权限'), findsOneWidget);
    expect(find.text('时区与特殊模式'), findsOneWidget);
    expect(find.text('隐私与数据'), findsOneWidget);
    expect(find.text('桌面存在感'), findsOneWidget);
  });

  testWidgets('桌面存在感入口作为二级页打开后可返回我的页', (tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final preferences = await SharedPreferences.getInstance();
    final router = GoRouter(
      initialLocation: '/profile',
      routes: [
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: profileWidgetThemePath,
          builder: (context, state) => const WidgetThemePage(),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
          widgetThemeSnapshotProvider.overrideWith(
            (ref) async => WidgetSnapshot.ready(
              targetBedtimeLabel: '23:30',
              minutesToTarget: 52,
              lastNightStatusLabel: '昨晚晚 26 分钟',
              entryUri: Uri.parse(
                'rhythm://bedtime?source=widget_bedtime_shortcut',
              ),
            ),
          ),
          homeWidgetGatewayProvider.overrideWithValue(_FakeHomeWidgetGateway()),
        ],
        child: MaterialApp.router(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('桌面存在感'), 200);
    await tester.tap(find.text('桌面存在感'));
    await tester.pumpAndSettle();

    expect(find.text('小组件与主题'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    expect(find.text('匿名用户'), findsOneWidget);
    expect(find.text('桌面存在感'), findsOneWidget);
  });
}

/// 提供测试用小组件网关，避免页面依赖真实插件实现。
class _FakeHomeWidgetGateway implements HomeWidgetGateway {
  @override
  Future<HomeWidgetInstallationState> getInstallationState() async {
    return HomeWidgetInstallationState.available;
  }

  @override
  Future<HomeWidgetPinSupportState> getPinSupportState() async {
    return HomeWidgetPinSupportState.supported;
  }

  @override
  Future<bool> requestPin() async {
    return true;
  }

  @override
  Future<Uri?> readInitialEntry() async => null;

  @override
  Future<void> clearSnapshot() async {}

  @override
  Future<void> refresh() async {}

  @override
  Future<void> saveSnapshot(WidgetSnapshot snapshot) async {}
}
