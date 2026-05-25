import 'package:flutter/material.dart';

/// 渲染会员入口的轻提示横幅，强调“免费闭环仍可继续使用”的非强打断语义。
class PaywallEntryBanner extends StatelessWidget {
  /// 创建会员入口横幅。
  const PaywallEntryBanner({
    super.key,
    required this.title,
    required this.description,
  });

  /// 横幅标题。
  final String title;

  /// 横幅说明。
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4E8CF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
