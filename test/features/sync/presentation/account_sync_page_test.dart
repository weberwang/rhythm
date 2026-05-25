import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sync/application/account_sync_controller.dart';
import 'package:rhythm/features/sync/presentation/account_sync_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证账号与同步页会按控制器状态展示身份、同步摘要和重试入口。
void main() {
  Future<void> pumpAccountSyncPage(
    WidgetTester tester, {
    required AccountSyncViewState state,
  }) async {
    _currentAccountSyncState = state;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          accountSyncControllerProvider.overrideWith(
            _FakeAccountSyncController.new,
          ),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: AccountSyncPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('未登录状态展示匿名身份和绑定账号入口', (tester) async {
    await pumpAccountSyncPage(
      tester,
      state: const AccountSyncViewState(
        status: AccountSyncStatus.localOnly,
        hasLinkedAccount: false,
      ),
    );

    expect(find.text('匿名用户'), findsOneWidget);
    expect(find.text('绑定 Apple 账号'), findsOneWidget);
    expect(find.text('同步状态'), findsOneWidget);
  });

  testWidgets('同步失败状态展示重试按钮和冲突说明', (tester) async {
    await pumpAccountSyncPage(
      tester,
      state: const AccountSyncViewState(
        status: AccountSyncStatus.failed,
        hasLinkedAccount: true,
        email: 'user@example.com',
      ),
    );

    expect(find.text('user@example.com'), findsOneWidget);
    expect(find.text('重试同步'), findsOneWidget);
    expect(find.textContaining('用户手动修改结果优先'), findsOneWidget);
  });

  testWidgets('同步成功状态展示最近同步时间摘要', (tester) async {
    await pumpAccountSyncPage(
      tester,
      state: AccountSyncViewState(
        status: AccountSyncStatus.synced,
        hasLinkedAccount: true,
        email: 'user@example.com',
        lastSyncedAt: DateTime.utc(2026, 5, 24, 7, 42),
      ),
    );

    expect(find.textContaining('07:42'), findsOneWidget);
    expect(find.text('最近一次云端同步已完成，目标、记录和标签保持一致。'), findsOneWidget);
  });
}

/// 提供测试专用控制器，避免页面测试依赖真实同步服务与 Supabase 环境。
class _FakeAccountSyncController extends AccountSyncController {
  @override
  Future<AccountSyncViewState> build() async {
    return _currentAccountSyncState;
  }
}

late AccountSyncViewState _currentAccountSyncState;
