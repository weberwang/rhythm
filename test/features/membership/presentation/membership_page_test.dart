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
              priceLabel: '¥3',
            ),
            MembershipPlan(
              packageId: 'annual_plan',
              tier: MembershipTier.annual,
              priceLabel: '¥16',
              isRecommended: true,
              isTrialEligible: true,
            ),
            MembershipPlan(
              packageId: 'lifetime_plan',
              tier: MembershipTier.lifetime,
              priceLabel: '¥32',
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
    expect(find.text('永久'), findsOneWidget);
    expect(find.text('¥3'), findsOneWidget);
    expect(find.text('¥16'), findsOneWidget);
    expect(find.text('¥32'), findsOneWidget);
    expect(find.text('立即开通年会员'), findsOneWidget);
  });

  testWidgets('月付与年付套餐卡保持等高，避免推荐角标挤压布局', (tester) async {
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
              priceLabel: '¥3',
            ),
            MembershipPlan(
              packageId: 'annual_plan',
              tier: MembershipTier.annual,
              priceLabel: '¥16',
              isRecommended: true,
              isTrialEligible: true,
            ),
          ],
        ),
      ),
    );

    final monthlyCard = find.ancestor(
      of: find.text('月付'),
      matching: find.byType(InkWell),
    );
    final annualCard = find.ancestor(
      of: find.text('年付'),
      matching: find.byType(InkWell),
    );

    expect(monthlyCard, findsOneWidget);
    expect(annualCard, findsOneWidget);

    final monthlySize = tester.getSize(monthlyCard);
    final annualSize = tester.getSize(annualCard);

    expect((monthlySize.height - annualSize.height).abs(), lessThan(0.1));
  });

  testWidgets('点击套餐卡后会切换主按钮文案', (tester) async {
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
              priceLabel: '¥3',
            ),
            MembershipPlan(
              packageId: 'annual_plan',
              tier: MembershipTier.annual,
              priceLabel: '¥16',
              isRecommended: true,
            ),
            MembershipPlan(
              packageId: 'lifetime_plan',
              tier: MembershipTier.lifetime,
              priceLabel: '¥32',
            ),
          ],
        ),
      ),
    );

    expect(find.text('立即开通年会员'), findsOneWidget);

    await tester.tap(find.text('月付'));
    await tester.pumpAndSettle();
    expect(find.text('立即开通月会员'), findsOneWidget);

    await tester.tap(find.text('永久'));
    await tester.pumpAndSettle();
    expect(find.text('立即开通年会员'), findsNothing);
  });

  testWidgets('切换套餐时卡片尺寸保持稳定，避免选中外框抖动', (tester) async {
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
              priceLabel: '¥3',
            ),
            MembershipPlan(
              packageId: 'annual_plan',
              tier: MembershipTier.annual,
              priceLabel: '¥16',
              isRecommended: true,
            ),
            MembershipPlan(
              packageId: 'lifetime_plan',
              tier: MembershipTier.lifetime,
              priceLabel: '¥32',
            ),
          ],
        ),
      ),
    );

    final monthlyCard = find.ancestor(
      of: find.text('月付'),
      matching: find.byType(InkWell),
    );
    final annualCard = find.ancestor(
      of: find.text('年付'),
      matching: find.byType(InkWell),
    );

    final monthlySizeBefore = tester.getSize(monthlyCard);
    final annualSizeBefore = tester.getSize(annualCard);

    await tester.tap(find.text('月付'));
    await tester.pumpAndSettle();

    final monthlySizeAfter = tester.getSize(monthlyCard);
    final annualSizeAfter = tester.getSize(annualCard);

    expect(monthlySizeAfter, monthlySizeBefore);
    expect(annualSizeAfter, annualSizeBefore);
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
              priceLabel: '¥16',
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
              priceLabel: '¥16',
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
