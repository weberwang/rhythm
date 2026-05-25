import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/widget_bridge/data/home_widget_gateway.dart';
import 'package:rhythm/features/widget_bridge/application/widget_snapshot_service.dart';
import 'package:rhythm/features/widget_bridge/domain/widget_snapshot.dart';
import 'package:rhythm/features/widget_bridge/presentation/widget_theme_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证小组件与主题页会展示阶段九必需状态、刷新反馈和快捷入口。
void main() {
  testWidgets('目标缺失时展示空态与引导入口', (tester) async {
    await _pumpPage(
      tester,
      snapshot: WidgetSnapshot.goalMissing(
        entryUri: Uri.parse('rhythm://today?source=widget_today'),
      ),
    );

    expect(find.text('先把存在感做好'), findsOneWidget);
    expect(find.text('还没有目标作息'), findsWidgets);
    expect(find.text('去设置目标作息'), findsOneWidget);
  });

  testWidgets('无数据时展示目标信息与补录提示', (tester) async {
    await _pumpPage(
      tester,
      snapshot: WidgetSnapshot.noData(
        targetBedtimeLabel: '23:30',
        minutesToTarget: 52,
        entryUri: Uri.parse('rhythm://today?source=widget_today'),
      ),
    );

    expect(find.text('桌面预览'), findsOneWidget);
    expect(find.text('23:30'), findsOneWidget);
    expect(find.text('今晚目标'), findsOneWidget);
    expect(find.text('昨晚还没有记录'), findsWidgets);
  });

  testWidgets('未授权时展示权限说明', (tester) async {
    await _pumpPage(
      tester,
      snapshot: WidgetSnapshot.permissionRequired(
        targetBedtimeLabel: '23:30',
        minutesToTarget: 52,
        entryUri: Uri.parse('rhythm://today?source=widget_today'),
      ),
    );

    expect(find.text('需要先授权睡眠数据'), findsWidgets);
    expect(find.text('小组件只会展示必要信息，不会展开原始睡眠细节。'), findsOneWidget);
  });

  testWidgets('点击刷新成功后展示成功反馈', (tester) async {
    final gateway = _FakeHomeWidgetGateway();
    await _pumpPage(
      tester,
      snapshot: WidgetSnapshot.ready(
        targetBedtimeLabel: '23:30',
        minutesToTarget: 52,
        lastNightStatusLabel: '昨晚晚 26 分钟',
        entryUri: Uri.parse('rhythm://bedtime?source=widget_bedtime_shortcut'),
      ),
      gateway: gateway,
    );

    await tester.tap(find.byKey(const Key('widget-theme-refresh-button')));
    await tester.pumpAndSettle();

    expect(gateway.saveCalled, isTrue);
    expect(gateway.updateCalled, isTrue);
    expect(find.text('小组件快照已刷新'), findsOneWidget);
  });

  testWidgets('刷新失败时展示失败反馈', (tester) async {
    await _pumpPage(
      tester,
      snapshot: WidgetSnapshot.ready(
        targetBedtimeLabel: '23:30',
        minutesToTarget: 52,
        lastNightStatusLabel: '昨晚晚 26 分钟',
        entryUri: Uri.parse('rhythm://bedtime?source=widget_bedtime_shortcut'),
      ),
      gateway: _FakeHomeWidgetGateway(shouldThrow: true),
    );

    await tester.tap(find.byKey(const Key('widget-theme-refresh-button')));
    await tester.pumpAndSettle();

    expect(find.text('刷新失败，请稍后再试'), findsOneWidget);
  });

  testWidgets('页面提供今日页和睡前模式两个快捷入口', (tester) async {
    final router = GoRouter(
      initialLocation: profileWidgetThemePath,
      routes: [
        GoRoute(
          path: profileWidgetThemePath,
          builder: (context, state) => ProviderScope(
            overrides: [
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
              homeWidgetGatewayProvider.overrideWithValue(
                _FakeHomeWidgetGateway(),
              ),
            ],
            child: const WidgetThemePage(),
          ),
        ),
        GoRoute(path: RhythmTab.today.path, builder: (context, state) => const Scaffold(body: Text('today'))),
        GoRoute(path: bedtimeModePath, builder: (context, state) => const Scaffold(body: Text('bedtime'))),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('打开今日页'));
    await tester.pumpAndSettle();
    expect(find.text('today'), findsOneWidget);

    router.go(profileWidgetThemePath);
    await tester.pumpAndSettle();
    await tester.tap(find.text('进入睡前模式'));
    await tester.pumpAndSettle();
    expect(find.text('bedtime'), findsOneWidget);
  });
}

Future<void> _pumpPage(
  WidgetTester tester, {
  required WidgetSnapshot snapshot,
  HomeWidgetGateway? gateway,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        widgetThemeSnapshotProvider.overrideWith(
          (ref) async => snapshot,
        ),
        homeWidgetGatewayProvider.overrideWithValue(
          gateway ?? _FakeHomeWidgetGateway(),
        ),
      ],
      child: MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: WidgetThemePage()),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// 提供页面测试用小组件网关，避免依赖真实插件。
class _FakeHomeWidgetGateway implements HomeWidgetGateway {
  _FakeHomeWidgetGateway({this.shouldThrow = false});

  final bool shouldThrow;
  bool saveCalled = false;
  bool updateCalled = false;

  @override
  Future<Uri?> readInitialEntry() async => null;

  @override
  Future<void> saveSnapshot(WidgetSnapshot snapshot) async {
    saveCalled = true;
    if (shouldThrow) {
      throw Exception('save failed');
    }
  }

  @override
  Future<void> refresh() async {
    updateCalled = true;
    if (shouldThrow) {
      throw Exception('refresh failed');
    }
  }
}
