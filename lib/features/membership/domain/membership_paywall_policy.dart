import 'package:freezed_annotation/freezed_annotation.dart';

import 'membership_entitlement.dart';

part 'membership_paywall_policy.freezed.dart';

/// 约束阶段十所有会员入口来源，确保拦截只发生在高意图点击之后。
enum PaywallEntryContext {
  /// 历史洞察中的超出免费窗口入口。
  history,

  /// 稳定度详细解释入口。
  stabilityExplainer,

  /// 恢复计划详情入口。
  recoveryPlanDetail,

  /// 月报入口。
  monthlyReport,

  /// 我的页中的会员入口。
  profile,

  /// 会员中心内部刷新或再展示入口。
  membershipCenter,
}

/// 描述一次会员能力判定结果，供路由和页面统一处理跳转与提示。
@freezed
abstract class MembershipAccessResult with _$MembershipAccessResult {
  const MembershipAccessResult._();

  /// 创建会员能力判定结果。
  const factory MembershipAccessResult({
    required PaywallEntryContext entryContext,
    required bool isBlocked,
    DateTime? freeHistoryStartDate,
  }) = _MembershipAccessResult;
}

/// 承载阶段十“只拦高意图场景”的核心策略，避免页面各自散落判断逻辑。
class MembershipPaywallPolicy {
  /// 创建会员付费墙策略。
  const MembershipPaywallPolicy();

  /// 免费历史可见窗口，超过该窗口的历史记录才会进入付费墙。
  static const int freeHistoryDays = 30;

  /// 根据权益层级和入口上下文判断当前访问是否需要进入付费墙。
  MembershipAccessResult evaluateAccess({
    required MembershipEntitlement entitlement,
    required PaywallEntryContext entryContext,
    required DateTime now,
    DateTime? targetDate,
  }) {
    if (entitlement.hasPremiumAccess) {
      return MembershipAccessResult(
        entryContext: entryContext,
        isBlocked: false,
      );
    }

    switch (entryContext) {
      case PaywallEntryContext.history:
        final cutoffDate = _normalizeDate(now).subtract(
          const Duration(days: freeHistoryDays),
        );
        final normalizedTarget = targetDate == null ? null : _normalizeDate(targetDate);
        final isBlocked = normalizedTarget != null && normalizedTarget.isBefore(cutoffDate);
        return MembershipAccessResult(
          entryContext: entryContext,
          isBlocked: isBlocked,
          freeHistoryStartDate: cutoffDate,
        );
      case PaywallEntryContext.stabilityExplainer:
      case PaywallEntryContext.recoveryPlanDetail:
      case PaywallEntryContext.monthlyReport:
        return MembershipAccessResult(
          entryContext: entryContext,
          isBlocked: true,
        );
      case PaywallEntryContext.profile:
      case PaywallEntryContext.membershipCenter:
        return MembershipAccessResult(
          entryContext: entryContext,
          isBlocked: false,
        );
    }
  }

  /// 统一按业务归属日截断时间，避免因为时分秒差异导致免费窗口抖动。
  DateTime _normalizeDate(DateTime dateTime) {
    return DateTime.utc(dateTime.year, dateTime.month, dateTime.day);
  }
}
