import 'package:freezed_annotation/freezed_annotation.dart';

part 'membership_entitlement.freezed.dart';

/// 定义阶段十会员体系的权益层级，供策略、服务和显示层统一判断。
enum MembershipTier {
  /// 免费版，仅保留核心闭环能力。
  free,

  /// 试用版，允许用户短期体验会员能力。
  trial,

  /// 月付会员。
  monthly,

  /// 年付会员。
  annual,

  /// 永久会员。
  lifetime,
}

/// 描述当前用户的会员权益快照，避免显示层直接依赖三方 SDK 结构。
@freezed
abstract class MembershipEntitlement with _$MembershipEntitlement {
  const MembershipEntitlement._();

  /// 创建一份标准化会员权益快照。
  const factory MembershipEntitlement({
    required MembershipTier tier,
    @Default(false) bool isActive,
    @Default(false) bool willRenew,
    String? productId,
    DateTime? expiresAt,
    String? managementUrl,
  }) = _MembershipEntitlement;

  /// 创建免费版权益快照，方便未配置和降级场景直接复用。
  const factory MembershipEntitlement.free({
    @Default(MembershipTier.free) MembershipTier tier,
    @Default(false) bool isActive,
    @Default(false) bool willRenew,
    String? productId,
    DateTime? expiresAt,
    String? managementUrl,
  }) = _FreeMembershipEntitlement;

  /// 是否已经拥有阶段十约定的会员增强能力。
  bool get hasPremiumAccess => isActive && tier != MembershipTier.free;

  /// 是否正处于试用窗口，供显示层渲染“先试试看”之类的轻提示。
  bool get isTrialActive => isActive && tier == MembershipTier.trial;
}
