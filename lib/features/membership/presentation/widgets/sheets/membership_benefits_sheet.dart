import 'package:flutter/material.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示会员权益边界说明，统一复用设计稿中的轻量对比弹层结构。
class MembershipBenefitsSheet extends StatelessWidget {
  /// 创建会员权益说明弹层。
  const MembershipBenefitsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            for (final item in <String>[
              l10n.membershipBenefitRecoveryShort,
              l10n.membershipBenefitHistoryShort,
              l10n.membershipBenefitMonthlyShort,
            ]) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(
                  item,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
