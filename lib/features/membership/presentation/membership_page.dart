import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/features/membership/application/membership_controller.dart';
import 'package:rhythm/features/membership/domain/membership_entitlement.dart';
import 'package:rhythm/features/membership/domain/membership_snapshot.dart';
import 'package:rhythm/features/membership/presentation/widgets/sheets/membership_benefits_sheet.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示阶段十会员中心页，承接权益说明、套餐选择和恢复购买入口。
class MembershipPage extends HookConsumerWidget {
  /// 创建会员中心页。
  const MembershipPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(membershipControllerProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: stateAsync.when(
          data: (state) => _MembershipBody(state: state, l10n: l10n),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(l10n.paywallHintDescription),
            ),
          ),
        ),
      ),
    );
  }
}

/// 承载会员中心页主体结构，避免主页面堆叠过多布局分支。
class _MembershipBody extends StatelessWidget {
  const _MembershipBody({
    required this.state,
    required this.l10n,
  });

  final MembershipViewState state;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final selectedPlan = state.selectedPlan;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: const Color(0xFFD5DFCE)),
                ),
                alignment: Alignment.center,
                child: const Text('‹', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(width: 12),
              Text(
                l10n.membershipCenterPageTitle,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            l10n.membershipCenterHeroTitle,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.membershipCenterHeroDescription,
            style: textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          _MembershipStatusCard(
            title: _statusTitle(l10n, state.snapshot.entitlement.tier),
            description: l10n.membershipStatusDescription,
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final plan in state.snapshot.plans) ...[
                Expanded(child: _PlanCard(plan: plan, isSelected: plan.packageId == state.effectiveSelectedPackageId)),
                if (plan != state.snapshot.plans.last) const SizedBox(width: 12),
              ],
            ],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BenefitItem(text: l10n.membershipBenefitRecoveryDetail),
                  _BenefitItem(text: l10n.membershipBenefitStabilityExplainer),
                  _BenefitItem(text: l10n.membershipBenefitHistoryMonthly),
                  _BenefitItem(text: l10n.membershipBenefitRestoreSync),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: state.isProcessing ? null : () {},
              child: Text(_primaryActionLabel(l10n, state, selectedPlan)),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const MembershipBenefitsSheet(),
                  ),
                  child: Text(l10n.membershipViewBenefitsButton),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.tonal(
                  onPressed: () {},
                  child: Text(l10n.membershipRestoreButton),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 根据当前权益和选中套餐推导主按钮文案，保持会员中心主 CTA 明确。
  String _primaryActionLabel(
    AppLocalizations l10n,
    MembershipViewState state,
    MembershipPlan? selectedPlan,
  ) {
    if (state.snapshot.entitlement.hasPremiumAccess) {
      return l10n.membershipPrimaryActionManage;
    }
    if (selectedPlan?.tier == MembershipTier.annual) {
      return l10n.membershipPrimaryActionAnnual;
    }
    return l10n.membershipPrimaryActionMonthly;
  }

  /// 根据权益层级映射会员状态标题，避免业务层直接持有最终展示文案。
  String _statusTitle(AppLocalizations l10n, MembershipTier tier) {
    switch (tier) {
      case MembershipTier.free:
        return l10n.membershipStatusFree;
      case MembershipTier.trial:
        return l10n.membershipStatusTrial;
      case MembershipTier.monthly:
        return l10n.membershipStatusMonthly;
      case MembershipTier.annual:
        return l10n.membershipStatusAnnual;
      case MembershipTier.lifetime:
        return l10n.membershipStatusLifetime;
    }
  }
}

/// 展示当前会员状态卡片，复用设计稿里的“免费版中 / 已激活”信息层级。
class _MembershipStatusCard extends StatelessWidget {
  const _MembershipStatusCard({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1B3A28),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFF264735),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFD7E7DA),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// 展示单个套餐卡片，保持会员中心与付费墙一致的价格与推荐层级。
class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.plan,
    required this.isSelected,
  });

  final MembershipPlan plan;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final highlight = plan.isRecommended;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: highlight ? const Color(0xFFF9FBF6) : const Color(0xFFE8F0E1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: highlight ? const Color(0xFFC8913C) : const Color(0xFFD5DFCE),
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (plan.isRecommended || plan.isTrialEligible)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: highlight ? const Color(0xFFF4E8CF) : const Color(0xFFD7E7DA),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                highlight
                    ? l10n.membershipPlanRecommendedBadge
                    : l10n.membershipPlanTryBadge,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: highlight ? const Color(0xFFC8913C) : const Color(0xFF1B3A28),
                ),
              ),
            ),
          if (plan.isRecommended || plan.isTrialEligible) const SizedBox(height: 8),
          Text(
            _planLabel(plan.tier, l10n),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            plan.priceLabel,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  /// 将套餐层级映射成设计稿里的展示名称。
  String _planLabel(MembershipTier tier, AppLocalizations l10n) {
    switch (tier) {
      case MembershipTier.monthly:
        return l10n.membershipPlanMonthly;
      case MembershipTier.annual:
        return l10n.membershipPlanAnnual;
      case MembershipTier.lifetime:
        return l10n.membershipPlanLifetime;
      case MembershipTier.trial:
        return l10n.membershipPlanTrial;
      case MembershipTier.free:
        return l10n.membershipPlanFree;
    }
  }
}

/// 展示会员权益列表项，保持设计稿中的“• 权益”层级。
class _BenefitItem extends StatelessWidget {
  const _BenefitItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        '• $text',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4),
      ),
    );
  }
}
