import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/features/membership/domain/membership_entitlement.dart';
import 'package:rhythm/features/membership/domain/membership_snapshot.dart';

part 'purchases_membership_data_source.g.dart';

/// 提供 RevenueCat 会员边界默认实例，统一处理未配置时的免费版降级。
@riverpod
PurchasesMembershipDataSource purchasesMembershipDataSource(Ref ref) {
  return const PurchasesMembershipDataSource();
}

/// 封装 `purchases_flutter` 调用细节，避免应用层和显示层直接依赖 SDK 结构。
class PurchasesMembershipDataSource {
  /// 创建 RevenueCat 会员数据源。
  const PurchasesMembershipDataSource();

  /// 读取当前会员快照；当 SDK 尚未配置时自动退回到免费版兜底。
  Future<MembershipSnapshot> loadSnapshot() async {
    final isConfigured = await Purchases.isConfigured;
    if (!isConfigured) {
      return _fallbackSnapshot();
    }

    try {
      final customerInfo = await Purchases.getCustomerInfo();
      final offerings = await _loadOfferingsSafely();
      return _buildSnapshot(
        customerInfo: customerInfo,
        offerings: offerings,
        isConfigured: true,
      );
    } catch (_) {
      // SDK 已接入但当前环境不可用时，继续回落到免费版，避免会员链路拖垮首屏。
      return _fallbackSnapshot(isConfigured: true);
    }
  }

  /// 发起套餐购买，并在购买完成后返回最新会员快照。
  Future<MembershipSnapshot> purchasePlan(String packageId) async {
    final isConfigured = await Purchases.isConfigured;
    if (!isConfigured) {
      return _fallbackSnapshot();
    }

    final offerings = await _loadOfferingsSafely();
    final package = _findPackage(offerings: offerings, packageId: packageId);
    if (package == null) {
      return _buildSnapshotFromOfferingsOnly(
        offerings: offerings,
        isConfigured: true,
      );
    }

    final purchaseResult = await Purchases.purchasePackage(package);
    return _buildSnapshot(
      customerInfo: purchaseResult.customerInfo,
      offerings: offerings,
      isConfigured: true,
    );
  }

  /// 恢复购买并返回恢复后的会员快照。
  Future<MembershipSnapshot> restoreMembership() async {
    final isConfigured = await Purchases.isConfigured;
    if (!isConfigured) {
      return _fallbackSnapshot();
    }

    final customerInfo = await Purchases.restorePurchases();
    final offerings = await _loadOfferingsSafely();
    return _buildSnapshot(
      customerInfo: customerInfo,
      offerings: offerings,
      isConfigured: true,
    );
  }

  /// 在 offerings 拉取失败时保留页面可渲染的套餐骨架，避免付费墙空白。
  Future<Offerings?> _loadOfferingsSafely() async {
    try {
      return await Purchases.getOfferings();
    } catch (_) {
      return null;
    }
  }

  /// 将 RevenueCat 返回的客户信息与套餐信息收口为项目内部快照。
  MembershipSnapshot _buildSnapshot({
    required CustomerInfo customerInfo,
    required Offerings? offerings,
    required bool isConfigured,
  }) {
    final entitlement = _resolveEntitlement(customerInfo);
    final currentOffering = _resolveOffering(offerings);
    final plans = _buildPlans(currentOffering);
    return MembershipSnapshot(
      isConfigured: isConfigured,
      entitlement: entitlement,
      plans: plans.isEmpty ? _fallbackPlans() : plans,
      managementUrl: customerInfo.managementURL ?? entitlement.managementUrl,
      activeOfferingId: currentOffering?.identifier,
    );
  }

  /// 当仅拿到套餐信息而未能完成购买时，仍返回可继续展示的会员中心快照。
  MembershipSnapshot _buildSnapshotFromOfferingsOnly({
    required Offerings? offerings,
    required bool isConfigured,
  }) {
    final currentOffering = _resolveOffering(offerings);
    final plans = _buildPlans(currentOffering);
    return MembershipSnapshot.fallback(
      isConfigured: isConfigured,
      entitlement: const MembershipEntitlement.free(),
      plans: plans.isEmpty ? _fallbackPlans() : plans,
      activeOfferingId: currentOffering?.identifier,
    );
  }

  /// 创建 RevenueCat 不可用时的兜底会员快照，保证会员页和付费墙始终有可展示内容。
  MembershipSnapshot _fallbackSnapshot({bool isConfigured = false}) {
    return MembershipSnapshot.fallback(
      isConfigured: isConfigured,
      entitlement: const MembershipEntitlement.free(),
      plans: _fallbackPlans(),
    );
  }

  /// 解析当前活跃权益；当存在多个活跃权益时优先取能力最完整的一档。
  MembershipEntitlement _resolveEntitlement(CustomerInfo customerInfo) {
    final activeEntitlements = customerInfo.entitlements.active.values.toList(
      growable: false,
    );
    if (activeEntitlements.isEmpty) {
      return MembershipEntitlement.free(
        managementUrl: customerInfo.managementURL,
      );
    }

    activeEntitlements.sort((left, right) {
      return _tierWeight(_tierFromEntitlement(right)).compareTo(
        _tierWeight(_tierFromEntitlement(left)),
      );
    });

    final current = activeEntitlements.first;
    return MembershipEntitlement(
      tier: _tierFromEntitlement(current),
      isActive: current.isActive,
      willRenew: current.willRenew,
      productId: current.productIdentifier,
      expiresAt: _parseRevenueCatDate(current.expirationDate),
      managementUrl: customerInfo.managementURL,
    );
  }

  /// 优先读取当前 targeting 选中的 offering；若为空，再退回到任意可用 offering。
  Offering? _resolveOffering(Offerings? offerings) {
    if (offerings == null) {
      return null;
    }
    if (offerings.current != null) {
      return offerings.current;
    }
    if (offerings.all.isEmpty) {
      return null;
    }
    return offerings.all.values.first;
  }

  /// 把 RevenueCat 套餐转换成项目内部套餐实体，避免显示层理解 SDK 细节。
  List<MembershipPlan> _buildPlans(Offering? offering) {
    if (offering == null) {
      return const <MembershipPlan>[];
    }

    return offering.availablePackages.map((package) {
      final tier = _tierFromPackage(package);
      final hasTrial = _hasTrialOption(package.storeProduct);
      return MembershipPlan(
        packageId: package.identifier,
        tier: tier,
        priceLabel: package.storeProduct.priceString,
        isRecommended: tier == MembershipTier.annual,
        isTrialEligible: hasTrial,
      );
    }).toList(growable: false);
  }

  /// 根据 packageId 在所有 offering 中定位可购买套餐，避免购买动作只依赖 current offering。
  Package? _findPackage({
    required Offerings? offerings,
    required String packageId,
  }) {
    if (offerings == null) {
      return null;
    }

    for (final offering in offerings.all.values) {
      for (final package in offering.availablePackages) {
        if (package.identifier == packageId) {
          return package;
        }
      }
    }
    return null;
  }

  /// 兜底套餐保持轻量低门槛价格，保证未接真实后台时也能完整演示会员路径。
  List<MembershipPlan> _fallbackPlans() {
    return const <MembershipPlan>[
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
  }

  /// 基于 RevenueCat 权益信息推断当前会员层级，优先信任试用与生命周期信息。
  MembershipTier _tierFromEntitlement(EntitlementInfo entitlement) {
    if (entitlement.periodType == PeriodType.trial) {
      return MembershipTier.trial;
    }
    return _tierFromProductId(entitlement.productIdentifier);
  }

  /// 基于 RevenueCat 套餐类型推断内部会员层级。
  MembershipTier _tierFromPackage(Package package) {
    switch (package.packageType) {
      case PackageType.lifetime:
        return MembershipTier.lifetime;
      case PackageType.annual:
        return MembershipTier.annual;
      case PackageType.monthly:
      case PackageType.weekly:
      case PackageType.twoMonth:
      case PackageType.threeMonth:
      case PackageType.sixMonth:
        return MembershipTier.monthly;
      case PackageType.custom:
      case PackageType.unknown:
        return _tierFromProductId(package.storeProduct.identifier);
    }
  }

  /// 通过产品标识兜底推断会员层级，兼容 current offering 缺少明确 packageType 的场景。
  MembershipTier _tierFromProductId(String productId) {
    final normalized = productId.toLowerCase();
    if (normalized.contains('lifetime') || normalized.contains('forever')) {
      return MembershipTier.lifetime;
    }
    if (normalized.contains('annual') || normalized.contains('year')) {
      return MembershipTier.annual;
    }
    if (normalized.contains('trial') || normalized.contains('intro')) {
      return MembershipTier.trial;
    }
    return MembershipTier.monthly;
  }

  /// 统一检测套餐是否暴露试用或首购优惠，以便页面复用“先试试看”视觉语义。
  bool _hasTrialOption(StoreProduct product) {
    if (product.defaultOption?.freePhase != null ||
        product.defaultOption?.introPhase != null) {
      return true;
    }
    final options = product.subscriptionOptions;
    if (options == null) {
      return product.introductoryPrice != null;
    }
    for (final option in options) {
      if (option.freePhase != null || option.introPhase != null) {
        return true;
      }
    }
    return product.introductoryPrice != null;
  }

  /// 解析 RevenueCat 的 ISO 时间字符串，失败时回退为空，避免异常沿显示层冒泡。
  DateTime? _parseRevenueCatDate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return DateTime.tryParse(value);
  }

  /// 用固定权重表达权益层级，便于在多权益同时存在时选出最强能力。
  int _tierWeight(MembershipTier tier) {
    switch (tier) {
      case MembershipTier.free:
        return 0;
      case MembershipTier.trial:
        return 1;
      case MembershipTier.monthly:
        return 2;
      case MembershipTier.annual:
        return 3;
      case MembershipTier.lifetime:
        return 4;
    }
  }
}
