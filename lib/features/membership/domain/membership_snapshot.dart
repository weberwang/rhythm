import 'package:freezed_annotation/freezed_annotation.dart';

import 'membership_entitlement.dart';

part 'membership_snapshot.freezed.dart';

/// 描述一个可购买的会员套餐，供付费墙和会员中心统一渲染。
@freezed
abstract class MembershipPlan with _$MembershipPlan {
  const MembershipPlan._();

  /// 创建会员套餐实体。
  const factory MembershipPlan({
    required String packageId,
    required MembershipTier tier,
    required String priceLabel,
    @Default(false) bool isRecommended,
    @Default(false) bool isTrialEligible,
  }) = _MembershipPlan;
}

/// 聚合当前权益、套餐列表和管理入口，作为会员模块统一快照。
@freezed
abstract class MembershipSnapshot with _$MembershipSnapshot {
  const MembershipSnapshot._();

  /// 创建会员模块快照。
  const factory MembershipSnapshot({
    required bool isConfigured,
    required MembershipEntitlement entitlement,
    @Default(<MembershipPlan>[]) List<MembershipPlan> plans,
    String? managementUrl,
    String? activeOfferingId,
  }) = _MembershipSnapshot;

  /// 创建降级快照，供 RevenueCat 未配置或读取失败时兜底。
  const factory MembershipSnapshot.fallback({
    required bool isConfigured,
    required MembershipEntitlement entitlement,
    @Default(<MembershipPlan>[]) List<MembershipPlan> plans,
    String? managementUrl,
    String? activeOfferingId,
  }) = _MembershipSnapshotFallback;

  /// 优先返回被标记为推荐的套餐；若未标记，则退回第一个套餐。
  MembershipPlan? get recommendedPlan {
    for (final plan in plans) {
      if (plan.isRecommended) {
        return plan;
      }
    }
    if (plans.isEmpty) {
      return null;
    }
    return plans.first;
  }
}
