import 'package:flutter/material.dart';
import 'package:rhythm/app/theme/app_theme_tokens.dart';
import 'package:rhythm/features/insights/domain/weekly_report.dart';

/// 展示主要晚睡原因分布，保持首页与详情页的排序和比例口径一致。
class ReasonDistributionSection extends StatelessWidget {
  /// 创建原因分布区块。
  const ReasonDistributionSection({
    super.key,
    required this.items,
  });

  final List<ReasonDistributionItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = theme.brightness == Brightness.dark
        ? AppThemeTokens.dark
        : AppThemeTokens.light;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tokens.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '主要晚睡原因',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          for (final item in items.take(3)) ...[
            _ReasonRow(item: item),
            if (item != items.take(3).last) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _ReasonRow extends StatelessWidget {
  const _ReasonRow({required this.item});

  final ReasonDistributionItem item;

  @override
  Widget build(BuildContext context) {
    final percentage = (item.ratio * 100).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                item.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Text('$percentage%'),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: item.ratio,
            minHeight: 10,
            backgroundColor: const Color(0xFFDCE8D8),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2D5E3A)),
          ),
        ),
      ],
    );
  }
}
