import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/data/purchases/purchases_membership_data_source.dart';

import '../domain/membership_snapshot.dart';

export '../domain/membership_entitlement.dart';
export '../domain/membership_paywall_policy.dart';
export '../domain/membership_snapshot.dart';

part 'membership_repository.g.dart';

/// 定义会员数据访问边界，避免应用层与 `purchases_flutter` 直接耦合。
abstract class MembershipRepository {
  /// 读取当前会员快照。
  Future<MembershipSnapshot> loadSnapshot();

  /// 购买指定套餐并返回最新快照。
  Future<MembershipSnapshot> purchasePlan(String packageId);

  /// 恢复购买并返回恢复后的快照。
  Future<MembershipSnapshot> restoreMembership();
}

/// 提供会员仓储默认实现，统一复用 RevenueCat 数据源。
@riverpod
MembershipRepository membershipRepository(Ref ref) {
  return RevenueCatMembershipRepository(
    dataSource: ref.watch(purchasesMembershipDataSourceProvider),
  );
}

/// 使用 RevenueCat 数据源实现会员仓储，负责承接项目内部读取契约。
class RevenueCatMembershipRepository implements MembershipRepository {
  /// 创建会员仓储默认实现。
  RevenueCatMembershipRepository({
    required PurchasesMembershipDataSource dataSource,
  }) : _dataSource = dataSource;

  final PurchasesMembershipDataSource _dataSource;

  @override
  Future<MembershipSnapshot> loadSnapshot() {
    return _dataSource.loadSnapshot();
  }

  @override
  Future<MembershipSnapshot> purchasePlan(String packageId) {
    return _dataSource.purchasePlan(packageId);
  }

  @override
  Future<MembershipSnapshot> restoreMembership() {
    return _dataSource.restoreMembership();
  }
}
