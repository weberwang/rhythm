import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/features/membership/application/membership_controller.dart';
import 'package:rhythm/features/membership/domain/membership_entitlement.dart';
import 'package:rhythm/features/membership/domain/membership_snapshot.dart';
import 'package:rhythm/features/membership/presentation/paywall_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证轻量付费墙页会展示阶段十设计稿要求的标题、套餐与双按钮。
void main() {
  testWidgets('轻量付费墙展示会员说明、套餐卡和继续免费入口', (tester) async {
    await _pumpPage(
      tester,
      viewState: MembershipViewState(
        snapshot: MembershipSnapshot.fallback(
          isConfigured: false,
          entitlement: const MembershipEntitlement.free(),
          plans: const <MembershipPlan>[
            MembershipPlan(
              packageId: 'monthly_plan',
              tier: MembershipTier.monthly,
              priceLabel: '¥15',
              isTrialEligible: true,
            ),
            MembershipPlan(
              packageId: 'annual_plan',
              tier: MembershipTier.annual,
              priceLabel: '¥98',
              isRecommended: true,
            ),
          ],
        ),
      ),
    );

    expect(find.text('把改善能力也解锁出来'), findsOneWidget);
    expect(find.text('免费版给你结果，会员版把恢复计划、稳定度解释和长期历史都接上。'), findsOneWidget);
    expect(find.text('月付'), findsOneWidget);
    expect(find.text('年付'), findsOneWidget);
    expect(find.text('开通年会员'), findsOneWidget);
    expect(find.text('先继续免费版'), findsOneWidget);
  });
}

Future<void> _pumpPage(
  WidgetTester tester, {
  required MembershipViewState viewState,
}) async {
  final router = GoRouter(
    initialLocation: '/paywall',
    routes: [
      GoRoute(
        path: '/paywall',
        builder: (context, state) => ProviderScope(
          overrides: [
            membershipControllerProvider.overrideWith(
              () => _FakeMembershipController(viewState),
            ),
          ],
          child: const PaywallPage(),
        ),
      ),
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
}

/// 提供轻量付费墙测试控制器，避免页面测试依赖真实购买链路。
class _FakeMembershipController extends MembershipController {
  _FakeMembershipController(this._viewState);

  final MembershipViewState _viewState;

  @override
  Future<MembershipViewState> build() async {
    return _viewState;
  }
}
