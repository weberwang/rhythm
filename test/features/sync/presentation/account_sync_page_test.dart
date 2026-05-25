import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sync/application/account_sync_controller.dart';
import 'package:rhythm/features/sync/presentation/account_sync_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证账号同步页会按真实云身份状态展示文案与重试入口。
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

  testWidgets('匿名云身份已建立时展示云端同步身份文案', (tester) async {
    await pumpAccountSyncPage(
      tester,
      state: const AccountSyncViewState(
        status: AccountSyncStatus.synced,
        hasLinkedAccount: true,
        email: null,
      ),
    );

    expect(find.text('已建立云端同步身份'), findsOneWidget);
    expect(find.text('已启用云端同步'), findsOneWidget);
    expect(find.text('云端同步身份已就绪'), findsOneWidget);
  });

  testWidgets('未建立云身份时展示待建立文案', (tester) async {
    await pumpAccountSyncPage(
      tester,
      state: const AccountSyncViewState(
        status: AccountSyncStatus.localOnly,
        hasLinkedAccount: false,
      ),
    );

    expect(find.text('云端同步身份尚未建立'), findsOneWidget);
    expect(find.text('建立云端同步身份'), findsOneWidget);
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
    expect(find.text('已启用云端同步'), findsOneWidget);
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
