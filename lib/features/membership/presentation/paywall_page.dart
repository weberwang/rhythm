import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/features/membership/application/membership_controller.dart';
import 'package:rhythm/features/membership/domain/membership_entitlement.dart';
import 'package:rhythm/features/membership/domain/membership_snapshot.dart';
import 'package:rhythm/features/membership/presentation/widgets/paywall_entry_banner.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示轻量付费墙，只在高意图入口点击后出现，不阻断首次核心体验。
class PaywallPage extends HookConsumerWidget {
  /// 创建轻量付费墙页。
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(membershipControllerProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF102419),
      body: SafeArea(
        child: stateAsync.when(
          data: (state) => _PaywallBody(state: state, l10n: l10n),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                l10n.paywallHintDescription,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 承载轻量付费墙主体结构，对齐深色背景、标题、套餐与双按钮层级。
class _PaywallBody extends ConsumerWidget {
  const _PaywallBody({
    required this.state,
    required this.l10n,
  });

  final MembershipViewState state;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF254535),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      l10n.paywallHeroBadge,
                      style: textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.paywallHeroTitle,
                    style: textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      height: 1.1,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.paywallHeroDescription,
                    style: textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFFD7E7DA),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 18),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final plan in state.snapshot.plans) ...[
                          Expanded(
                            child: _PaywallPlanCard(
                              plan: plan,
                              isSelected:
                                  plan.packageId ==
                                  state.effectiveSelectedPackageId,
                              onTap: state.isProcessing
                                  ? null
                                  : () => ref
                                        .read(
                                          membershipControllerProvider.notifier,
                                        )
                                        .selectPackage(plan.packageId),
                            ),
                          ),
                          if (plan != state.snapshot.plans.last)
                            const SizedBox(width: 12),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  PaywallEntryBanner(
                    title: l10n.paywallHintTitle,
                    description: l10n.paywallHintDescription,
                  ),
                  const SizedBox(height: 18),
                  _PaywallBenefitItem(text: l10n.paywallBenefitRecoveryDetail),
                  _PaywallBenefitItem(
                    text: l10n.paywallBenefitStabilityExplainer,
                  ),
                  _PaywallBenefitItem(text: l10n.paywallBenefitHistoryMonthly),
                  _PaywallBenefitItem(text: l10n.paywallBenefitWidgetSync),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: state.isProcessing ? null : () {},
              child: Text(_primaryActionLabel(l10n, state.selectedPlan)),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFFD7E7DA)),
              ),
              child: Text(l10n.paywallContinueFreeButton),
            ),
          ),
        ],
      ),
    );
  }

  /// 根据当前选中套餐生成主操作文案，保持轻量付费墙 CTA 聚焦在被选套餐。
  String _primaryActionLabel(
    AppLocalizations l10n,
    MembershipPlan? plan,
  ) {
    switch (plan?.tier) {
      case MembershipTier.monthly:
        return l10n.paywallPrimaryActionMonthly;
      case MembershipTier.lifetime:
        return l10n.paywallPrimaryActionLifetime;
      case MembershipTier.trial:
        return l10n.paywallPrimaryActionTrial;
      case MembershipTier.free:
      case null:
      case MembershipTier.annual:
        return l10n.paywallPrimaryActionAnnual;
    }
  }
}

/// 渲染轻量付费墙套餐卡，保持与设计稿一致的“推荐 / 试试看”语义。
class _PaywallPlanCard extends StatelessWidget {
  const _PaywallPlanCard({
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  final MembershipPlan plan;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final recommended = plan.isRecommended;
    final background = recommended
        ? const Color(0xFFF9FBF6)
        : const Color(0xFF173324);
    final foreground = recommended
        ? const Color(0xFF1B3A28)
        : Colors.white;
    final l10n = AppLocalizations.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: recommended
                  ? const Color(0xFFC8913C)
                  : const Color(0xFF2A5641),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (plan.isRecommended || plan.isTrialEligible)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: recommended
                        ? const Color(0xFFF4E8CF)
                        : const Color(0xFF224634),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    recommended
                        ? l10n.membershipPlanRecommendedBadge
                        : l10n.membershipPlanTryBadge,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: recommended
                          ? const Color(0xFFC8913C)
                          : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              if (plan.isRecommended || plan.isTrialEligible)
                const SizedBox(height: 10),
              Text(
                _labelForTier(plan.tier, l10n),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                plan.priceLabel,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 将套餐层级映射成轻量付费墙中的简洁名称。
  String _labelForTier(MembershipTier tier, AppLocalizations l10n) {
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

/// 渲染轻量付费墙权益点，保持设计稿里的“• 权益”形式。
class _PaywallBenefitItem extends StatelessWidget {
  const _PaywallBenefitItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        '• $text',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          height: 1.4,
        ),
      ),
    );
  }
}
