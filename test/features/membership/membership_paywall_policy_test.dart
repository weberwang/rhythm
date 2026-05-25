import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/membership/domain/membership_entitlement.dart';
import 'package:rhythm/features/membership/domain/membership_paywall_policy.dart';

/// 验证会员付费墙策略会严格按阶段十约定拦截高意图场景。
void main() {
  const policy = MembershipPaywallPolicy();
  final now = DateTime.utc(2026, 5, 25);

  test('免费版可查看最近 30 天历史，但会拦截更早历史', () {
    final withinWindow = policy.evaluateAccess(
      entitlement: MembershipEntitlement.free(),
      entryContext: PaywallEntryContext.history,
      now: now,
      targetDate: DateTime.utc(2026, 5, 1),
    );
    final outsideWindow = policy.evaluateAccess(
      entitlement: MembershipEntitlement.free(),
      entryContext: PaywallEntryContext.history,
      now: now,
      targetDate: DateTime.utc(2026, 4, 20),
    );

    expect(withinWindow.isBlocked, isFalse);
    expect(outsideWindow.isBlocked, isTrue);
    expect(outsideWindow.entryContext, PaywallEntryContext.history);
  });

  test('免费版会拦截稳定度说明、恢复计划详情和月报入口', () {
    const entitlement = MembershipEntitlement.free();
    final contexts = <PaywallEntryContext>[
      PaywallEntryContext.stabilityExplainer,
      PaywallEntryContext.recoveryPlanDetail,
      PaywallEntryContext.monthlyReport,
    ];

    for (final context in contexts) {
      final result = policy.evaluateAccess(
        entitlement: entitlement,
        entryContext: context,
        now: now,
      );
      expect(result.isBlocked, isTrue, reason: 'context=$context');
    }
  });

  test('试用与付费会员不会再被高意图入口拦截', () {
    final entitlements = <MembershipEntitlement>[
      const MembershipEntitlement(
        tier: MembershipTier.trial,
        isActive: true,
      ),
      const MembershipEntitlement(
        tier: MembershipTier.annual,
        isActive: true,
      ),
      const MembershipEntitlement(
        tier: MembershipTier.lifetime,
        isActive: true,
      ),
    ];

    for (final entitlement in entitlements) {
      expect(
        policy
            .evaluateAccess(
              entitlement: entitlement,
              entryContext: PaywallEntryContext.history,
              now: now,
              targetDate: DateTime.utc(2026, 4, 1),
            )
            .isBlocked,
        isFalse,
        reason: 'history ${entitlement.tier}',
      );
      expect(
        policy
            .evaluateAccess(
              entitlement: entitlement,
              entryContext: PaywallEntryContext.stabilityExplainer,
              now: now,
            )
            .isBlocked,
        isFalse,
        reason: 'stability ${entitlement.tier}',
      );
      expect(
        policy
            .evaluateAccess(
              entitlement: entitlement,
              entryContext: PaywallEntryContext.recoveryPlanDetail,
              now: now,
            )
            .isBlocked,
        isFalse,
        reason: 'recovery ${entitlement.tier}',
      );
      expect(
        policy
            .evaluateAccess(
              entitlement: entitlement,
              entryContext: PaywallEntryContext.monthlyReport,
              now: now,
            )
            .isBlocked,
        isFalse,
        reason: 'monthly ${entitlement.tier}',
      );
    }
  });

  test('非拦截入口只作为展示来源，不会被错误拦截', () {
    final contexts = <PaywallEntryContext>[
      PaywallEntryContext.profile,
      PaywallEntryContext.membershipCenter,
    ];

    for (final context in contexts) {
      final result = policy.evaluateAccess(
        entitlement: MembershipEntitlement.free(),
        entryContext: context,
        now: now,
      );
      expect(result.isBlocked, isFalse, reason: 'context=$context');
    }
  });
}
