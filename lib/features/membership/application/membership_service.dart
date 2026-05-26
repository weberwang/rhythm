import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/membership/data/membership_repository.dart';
import 'package:rhythm/features/membership/domain/membership_entitlement.dart';
import 'package:rhythm/features/membership/domain/membership_paywall_policy.dart';
import 'package:rhythm/features/membership/domain/membership_snapshot.dart';

part 'membership_service.g.dart';

/// 提供会员服务默认实例，统一收口快照读取与权益判断。
@riverpod
MembershipService membershipService(Ref ref) {
  return MembershipService(
    repository: ref.watch(membershipRepositoryProvider),
    policy: const MembershipPaywallPolicy(),
    now: () => ref.watch(timeContextProvider).now,
  );
}

/// 聚合会员快照、购买恢复与付费墙判定，避免页面层各自编排流程。
class MembershipService {
  /// 创建会员服务。
  MembershipService({
    required MembershipRepository repository,
    required MembershipPaywallPolicy policy,
    required DateTime Function() now,
  }) : _repository = repository,
       _policy = policy,
       _now = now;

  final MembershipRepository _repository;
  final MembershipPaywallPolicy _policy;
  final DateTime Function() _now;

  /// 读取最新会员快照，供会员中心和付费墙统一消费。
  Future<MembershipSnapshot> loadSnapshot() {
    return _withFallbackPlans(_repository.loadSnapshot());
  }

  /// 购买指定套餐并返回最新权益状态。
  Future<MembershipSnapshot> purchasePlan(String packageId) {
    return _withFallbackPlans(_repository.purchasePlan(packageId));
  }

  /// 恢复用户已有购买并返回最新权益状态。
  Future<MembershipSnapshot> restoreMembership() {
    return _withFallbackPlans(_repository.restoreMembership());
  }

  /// 对单个高意图入口执行统一会员判定，避免页面层复制规则。
  Future<MembershipAccessResult> evaluateAccess({
    required PaywallEntryContext entryContext,
    DateTime? targetDate,
  }) async {
    final snapshot = await loadSnapshot();
    return _policy.evaluateAccess(
      entitlement: snapshot.entitlement,
      entryContext: entryContext,
      now: _now(),
      targetDate: targetDate,
    );
  }

  /// 统一为无套餐快照补上兜底套餐，确保未接真实 offering 时页面仍可稳定展示。
  Future<MembershipSnapshot> _withFallbackPlans(
    Future<MembershipSnapshot> snapshotFuture,
  ) async {
    final snapshot = await snapshotFuture;
    if (snapshot.plans.isNotEmpty) {
      return snapshot;
    }
    return snapshot.copyWith(plans: _fallbackPlans);
  }
}

/// 兜底套餐保持一份静态定义，确保会员中心与付费墙价格一致。
const List<MembershipPlan> _fallbackPlans = <MembershipPlan>[
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
];
