import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/features/profile/presentation/profile_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证我的页会展示阶段八入口，并补上阶段十会员中心入口。
void main() {
  testWidgets('我的页展示账号卡、会员入口、五个设置入口和桌面存在感说明', (tester) async {
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
}
