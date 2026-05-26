import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/data/local/rhythm_database.dart';
import 'package:rhythm/features/profile/application/local_data_clear_service.dart';
import 'package:rhythm/features/profile/presentation/privacy_data_page.dart';
import 'package:rhythm/features/widget_bridge/data/home_widget_gateway.dart';
import 'package:rhythm/features/widget_bridge/domain/widget_snapshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证隐私与数据页会展示关键操作入口，且不再展示底部危险提示区域。
void main() {
  testWidgets('隐私页展示操作入口且不展示底部危险提示区域', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: PrivacyDataPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('隐私协议'), findsOneWidget);
    expect(find.text('导出数据'), findsOneWidget);
    expect(find.text('删除账号'), findsOneWidget);
    expect(find.text('清空本地数据'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
    expect(find.text('危险操作需要二次确认'), findsNothing);
  });

  testWidgets('点击导出数据会弹出确认对话框', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: PrivacyDataPage()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('导出数据'));
    await tester.pumpAndSettle();

    expect(find.text('确认导出数据'), findsOneWidget);
  });

  testWidgets('确认清空本地数据后会触发清理服务', (tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final preferences = await SharedPreferences.getInstance();
    final service = _FakeLocalDataClearService(preferences);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localDataClearServiceProvider.overrideWithValue(service),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: PrivacyDataPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('清空本地数据'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('确认'));
    await tester.pumpAndSettle();

    expect(service.cleared, isTrue);
  });
}

/// 提供页面测试用清理服务替身，只关心是否触发过清空动作。
class _FakeLocalDataClearService extends LocalDataClearService {
  _FakeLocalDataClearService(SharedPreferences preferences)
      : super(
          database: RhythmDatabase.inMemory(),
          sharedPreferences: preferences,
          homeWidgetGateway: _FakeHomeWidgetGateway(),
        );

  bool cleared = false;

  @override
  Future<void> clearBusinessLocalData() async {
    cleared = true;
  }
}

/// 提供页面测试用小组件网关替身，避免构造真实插件依赖。
/// 提供隐私页测试用小组件网关替身，避免弹窗流程依赖真实插件实现。
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
  Future<void> saveSnapshot(WidgetSnapshot snapshot) async {}

  @override
  Future<void> clearSnapshot() async {}

  @override
  Future<void> refresh() async {}
}
