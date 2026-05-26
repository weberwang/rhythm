import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/features/membership/application/membership_service.dart';
import 'package:rhythm/features/membership/domain/membership_snapshot.dart';

part 'membership_controller.g.dart';

/// 聚合会员页面所需的快照、当前选中套餐和操作中状态，避免显示层自己拼装。
class MembershipViewState {
  /// 创建会员页面状态。
  const MembershipViewState({
    required this.snapshot,
    this.selectedPackageId,
    this.isProcessing = false,
  });

  /// 当前会员快照。
  final MembershipSnapshot snapshot;

  /// 当前选中的套餐标识。
  final String? selectedPackageId;

  /// 是否正在执行购买或恢复动作。
  final bool isProcessing;

  /// 当前默认应高亮的套餐标识；如果用户尚未主动切换，则跟随推荐套餐。
  String? get effectiveSelectedPackageId {
    return selectedPackageId ?? snapshot.recommendedPlan?.packageId;
  }

  /// 当前默认应作为主 CTA 的套餐。
  MembershipPlan? get selectedPlan {
    final selectedId = effectiveSelectedPackageId;
    if (selectedId == null) {
      return null;
    }
    for (final plan in snapshot.plans) {
      if (plan.packageId == selectedId) {
        return plan;
      }
    }
    return snapshot.recommendedPlan;
  }

  /// 复制状态并更新局部字段，便于控制器在异步过程中保持状态一致。
  MembershipViewState copyWith({
    MembershipSnapshot? snapshot,
    String? selectedPackageId,
    bool? isProcessing,
  }) {
    return MembershipViewState(
      snapshot: snapshot ?? this.snapshot,
      selectedPackageId: selectedPackageId ?? this.selectedPackageId,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

/// 提供会员页面控制器，统一编排首屏快照、套餐切换与购买恢复动作。
@riverpod
class MembershipController extends _$MembershipController {
  /// 初始化会员页面快照。
  @override
  Future<MembershipViewState> build() async {
    final snapshot = await ref.watch(membershipServiceProvider).loadSnapshot();
    return MembershipViewState(snapshot: snapshot);
  }

  /// 更新当前选中的套餐，供付费墙和会员中心复用同一交互状态。
  void selectPackage(String packageId) {
    final current = state.asData?.value;
    if (current == null) {
      return;
    }
    state = AsyncData(current.copyWith(selectedPackageId: packageId));
  }

  /// 执行当前选中套餐购买，并在完成后刷新会员状态。
  Future<void> purchaseSelectedPlan() async {
    final current = state.asData?.value;
    final selectedPlan = current?.selectedPlan;
    if (current == null || selectedPlan == null) {
      return;
    }

    state = AsyncData(current.copyWith(isProcessing: true));
    final snapshot = await ref
        .read(membershipServiceProvider)
        .purchasePlan(selectedPlan.packageId);
    state = AsyncData(
      MembershipViewState(
        snapshot: snapshot,
        selectedPackageId: selectedPlan.packageId,
      ),
    );
  }

  /// 执行恢复购买，并在完成后刷新会员状态。
  Future<void> restoreMembership() async {
    final current = state.asData?.value;
    if (current == null) {
      return;
    }

    state = AsyncData(current.copyWith(isProcessing: true));
    final snapshot = await ref.read(membershipServiceProvider).restoreMembership();
    state = AsyncData(
      MembershipViewState(
        snapshot: snapshot,
        selectedPackageId: current.effectiveSelectedPackageId,
      ),
    );
  }
}
