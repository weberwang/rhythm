import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/membership/application/membership_service.dart';
import 'package:rhythm/features/membership/data/membership_repository.dart';
import 'package:rhythm/features/membership/domain/membership_entitlement.dart';
import 'package:rhythm/features/membership/domain/membership_paywall_policy.dart';

/// 验证会员服务会统一收口快照读取、购买恢复和拦截判断。
void main() {
  final now = DateTime.utc(2026, 5, 25, 9);

  test('读取快照时会直接透传仓储返回的当前权益与套餐', () async {
    final repository = _FakeMembershipRepository(
      snapshot: MembershipSnapshot.fallback(
        isConfigured: false,
        entitlement: MembershipEntitlement.free(),
      ),
    );
    final service = MembershipService(
      repository: repository,
      policy: const MembershipPaywallPolicy(),
      now: () => now,
    );

    final snapshot = await service.loadSnapshot();

    expect(snapshot.entitlement.tier, MembershipTier.free);
    expect(snapshot.plans, hasLength(2));
    expect(snapshot.recommendedPlan?.tier, MembershipTier.annual);
    expect(repository.loadCount, 1);
  });

  test('购买指定套餐后会返回新的会员快照并记录购买目标', () async {
    final repository = _FakeMembershipRepository(
      snapshot: MembershipSnapshot.fallback(
        isConfigured: false,
        entitlement: MembershipEntitlement.free(),
      ),
      purchasedSnapshot: MembershipSnapshot.fallback(
        isConfigured: true,
        entitlement: const MembershipEntitlement(
          tier: MembershipTier.annual,
          isActive: true,
          willRenew: true,
        ),
      ),
    );
    final service = MembershipService(
      repository: repository,
      policy: const MembershipPaywallPolicy(),
      now: () => now,
    );

    final snapshot = await service.purchasePlan('annual_plan');

    expect(snapshot.entitlement.tier, MembershipTier.annual);
    expect(snapshot.entitlement.hasPremiumAccess, isTrue);
    expect(repository.purchasedPackageIds, <String>['annual_plan']);
  });

  test('恢复购买会刷新当前权益快照', () async {
    final repository = _FakeMembershipRepository(
      snapshot: MembershipSnapshot.fallback(
        isConfigured: false,
        entitlement: MembershipEntitlement.free(),
      ),
      restoredSnapshot: MembershipSnapshot.fallback(
        isConfigured: true,
        entitlement: const MembershipEntitlement(
          tier: MembershipTier.lifetime,
          isActive: true,
        ),
      ),
    );
    final service = MembershipService(
      repository: repository,
      policy: const MembershipPaywallPolicy(),
      now: () => now,
    );

    final snapshot = await service.restoreMembership();

    expect(snapshot.entitlement.tier, MembershipTier.lifetime);
    expect(snapshot.entitlement.hasPremiumAccess, isTrue);
    expect(repository.restoreCount, 1);
  });

  test('服务会按当前时间统一判断历史入口是否需要付费墙', () async {
    final repository = _FakeMembershipRepository(
      snapshot: MembershipSnapshot.fallback(
        isConfigured: false,
        entitlement: MembershipEntitlement.free(),
      ),
    );
    final service = MembershipService(
      repository: repository,
      policy: const MembershipPaywallPolicy(),
      now: () => now,
    );

    final recentHistory = await service.evaluateAccess(
      entryContext: PaywallEntryContext.history,
      targetDate: DateTime.utc(2026, 5, 2),
    );
    final oldHistory = await service.evaluateAccess(
      entryContext: PaywallEntryContext.history,
      targetDate: DateTime.utc(2026, 4, 18),
    );
    final stability = await service.evaluateAccess(
      entryContext: PaywallEntryContext.stabilityExplainer,
    );

    expect(recentHistory.isBlocked, isFalse);
    expect(oldHistory.isBlocked, isTrue);
    expect(stability.isBlocked, isTrue);
    expect(repository.loadCount, 3);
  });
}

/// 提供会员服务测试仓储，便于直接控制快照与购买恢复结果。
class _FakeMembershipRepository implements MembershipRepository {
  _FakeMembershipRepository({
    required this.snapshot,
    MembershipSnapshot? purchasedSnapshot,
    MembershipSnapshot? restoredSnapshot,
  }) : _purchasedSnapshot = purchasedSnapshot ?? snapshot,
       _restoredSnapshot = restoredSnapshot ?? snapshot;

  final MembershipSnapshot snapshot;
  final MembershipSnapshot _purchasedSnapshot;
  final MembershipSnapshot _restoredSnapshot;
  final List<String> purchasedPackageIds = <String>[];
  int loadCount = 0;
  int restoreCount = 0;

  @override
  Future<MembershipSnapshot> loadSnapshot() async {
    loadCount += 1;
    return snapshot;
  }

  @override
  Future<MembershipSnapshot> purchasePlan(String packageId) async {
    purchasedPackageIds.add(packageId);
    return _purchasedSnapshot;
  }

  @override
  Future<MembershipSnapshot> restoreMembership() async {
    restoreCount += 1;
    return _restoredSnapshot;
  }
}
