import 'package:flutter/material.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 渲染今日页恢复建议卡，首轮只承载最小提示结构。
class TodayRecoverySection extends StatelessWidget {
  /// 创建恢复建议卡。
  const TodayRecoverySection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      color: const Color(0xFFF4E8CF),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.todayRecoverySectionTitle),
            const SizedBox(height: 8),
            Text(l10n.todayRecoveryDescription),
          ],
        ),
      ),
    );
  }
}
