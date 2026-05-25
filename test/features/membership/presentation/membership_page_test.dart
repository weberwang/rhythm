import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/features/membership/application/membership_controller.dart';
import 'package:rhythm/features/membership/domain/membership_entitlement.dart';
import 'package:rhythm/features/membership/domain/membership_snapshot.dart';
import 'package:rhythm/features/membership/presentation/membership_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证会员中心页会展示阶段十设计稿要求的标题、套餐和权益说明。
void main() {
  testWidgets('免费版会员中心展示标题、升级说明和两个套餐入口', (tester) async {
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
            ),
            MembershipPlan(
              packageId: 'annual_plan',
              tier: MembershipTier.annual,
              priceLabel: '¥98',
              isRecommended: true,
              isTrialEligible: true,
            ),
          ],
        ),
      ),
    );

    expect(find.text('会员中心'), findsOneWidget);
    expect(find.text('把长期改善能力接上'), findsOneWidget);
    expect(find.text('免费版中'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
    expect(find.text('月付'), findsOneWidget);
    expect(find.text('年付'), findsOneWidget);
    expect(find.text('¥15'), findsOneWidget);
    expect(find.text('¥98'), findsOneWidget);
    expect(find.text('立即开通年会员'), findsOneWidget);
  });

  testWidgets('已开通会员时展示当前权益状态与恢复购买入口', (tester) async {
    await _pumpPage(
      tester,
      viewState: MembershipViewState(
        snapshot: MembershipSnapshot(
          isConfigured: true,
          entitlement: const MembershipEntitlement(
            tier: MembershipTier.annual,
            isActive: true,
            willRenew: true,
          ),
          plans: const <MembershipPlan>[
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

    expect(find.text('年会员已激活'), findsOneWidget);
    expect(find.text('恢复购买'), findsOneWidget);
    expect(find.text('查看权益说明'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
  });

  testWidgets('点击查看权益说明会打开权益弹层', (tester) async {
    await _pumpPage(
      tester,
      viewState: MembershipViewState(
        snapshot: MembershipSnapshot.fallback(
          isConfigured: false,
          entitlement: const MembershipEntitlement.free(),
          plans: const <MembershipPlan>[
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

    await tester.tap(find.text('查看权益说明'));
    await tester.pumpAndSettle();

    expect(find.text('会员权益对比'), findsOneWidget);
    expect(find.text('恢复计划'), findsOneWidget);
    expect(find.text('长期历史'), findsOneWidget);
    expect(find.text('月报'), findsOneWidget);
  });
}

Future<void> _pumpPage(
  WidgetTester tester, {
  required MembershipViewState viewState,
}) async {
  final router = GoRouter(
    initialLocation: '/membership',
    routes: [
      GoRoute(
        path: '/membership',
        builder: (context, state) => ProviderScope(
          overrides: [
            membershipControllerProvider.overrideWith(
              () => _FakeMembershipController(viewState),
            ),
          ],
          child: const MembershipPage(),
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

/// 提供会员中心页面测试控制器，避免页面测试依赖真实购买链路。
class _FakeMembershipController extends MembershipController {
  _FakeMembershipController(this._viewState);

  final MembershipViewState _viewState;

  @override
  Future<MembershipViewState> build() async {
    return _viewState;
  }
}
