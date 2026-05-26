import 'package:flutter/material.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示会员权益边界说明，统一复用会员中心里的对比弹层结构。
class MembershipBenefitsSheet extends StatelessWidget {
  /// 创建会员权益说明弹层。
  const MembershipBenefitsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 64,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFD5DFCE),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.membershipBenefitsSheetTitle,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.membershipBenefitsSheetDescription,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            _BenefitsCompareHeader(
              freeLabel: '免费版',
              premiumLabel: '会员版',
            ),
            const SizedBox(height: 12),
            for (final item in <_BenefitsCompareItem>[
              const _BenefitsCompareItem(
                title: '恢复计划',
                freeValue: '基础摘要',
                premiumValue: '完整详情',
              ),
              const _BenefitsCompareItem(
                title: '长期历史',
                freeValue: '近 30 天',
                premiumValue: '更早历史',
              ),
              const _BenefitsCompareItem(
                title: '月报',
                freeValue: '暂不提供',
                premiumValue: '完整入口',
              ),
            ]) ...[
              _BenefitsCompareRow(item: item),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}

/// 展示对比表头，明确免费版与会员版两列语义。
class _BenefitsCompareHeader extends StatelessWidget {
  const _BenefitsCompareHeader({
    required this.freeLabel,
    required this.premiumLabel,
  });

  final String freeLabel;
  final String premiumLabel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        const Expanded(flex: 2, child: SizedBox.shrink()),
        Expanded(
          child: Text(
            freeLabel,
            textAlign: TextAlign.center,
            style: textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            premiumLabel,
            textAlign: TextAlign.center,
            style: textTheme.labelLarge?.copyWith(
              color: const Color(0xFF1B3A28),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

/// 描述单条权益对比项，避免在构建列表时散落字符串组合逻辑。
class _BenefitsCompareItem {
  const _BenefitsCompareItem({
    required this.title,
    required this.freeValue,
    required this.premiumValue,
  });

  final String title;
  final String freeValue;
  final String premiumValue;
}

/// 渲染单条权益对比行，让免费版与会员版差异直接可见。
class _BenefitsCompareRow extends StatelessWidget {
  const _BenefitsCompareRow({required this.item});

  final _BenefitsCompareItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBF6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E8D8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              item.title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              item.freeValue,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.premiumValue,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF1B3A28),
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
