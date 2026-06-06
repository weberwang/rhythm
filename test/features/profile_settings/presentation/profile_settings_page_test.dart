import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/features/app_shell/application/providers/current_account_session_provider.dart';
import 'package:rhythm/features/app_shell/domain/entities/account_session.dart';
import 'package:rhythm/features/profile_settings/presentation/pages/profile_settings_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证设置页会消费共享账号快照，而不是一直停留在纯占位说明。
void main() {
  testWidgets('profile settings shows anonymous guidance when account is local-first',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentAccountSessionProvider.overrideWith(
            (ref) async => AppAccountSession(
              mode: AppAccountSessionMode.anonymous,
              updatedAt: DateTime(2026, 6, 6),
            ),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ProfileSettingsPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('当前使用本地优先模式'), findsOneWidget);
    expect(find.text('今晚的数据会先保留在这台设备里，你可以稍后再连接账号和同步。'),
        findsOneWidget);
  });

  testWidgets('profile settings shows connected account summary when account exists',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentAccountSessionProvider.overrideWith(
            (ref) async => AppAccountSession(
              mode: AppAccountSessionMode.connected,
              provider: AppAccountProvider.google,
              displayName: 'Jamie',
              email: 'jamie@example.com',
              updatedAt: DateTime(2026, 6, 6),
            ),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ProfileSettingsPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('已连接 Google 账号'), findsOneWidget);
    expect(find.text('Jamie'), findsOneWidget);
    expect(find.text('jamie@example.com'), findsOneWidget);
  });
}
