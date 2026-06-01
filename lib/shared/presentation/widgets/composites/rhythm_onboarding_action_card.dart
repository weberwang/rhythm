import 'package:flutter/material.dart';

import 'rhythm_glass_panel.dart';

/// 首启链路统一底部操作区，承接单主动作和一条轻量次动作。
class RhythmOnboardingActionCard extends StatelessWidget {
  /// 创建首启操作区。
  const RhythmOnboardingActionCard({
    super.key,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.onPrimary,
    required this.onSecondary,
  });

  /// 主动作文案。
  final String primaryLabel;

  /// 次动作文案。
  final String secondaryLabel;

  /// 点击主动作后的处理。
  final VoidCallback onPrimary;

  /// 点击次动作后的处理。
  final VoidCallback onSecondary;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return RhythmGlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledButton(onPressed: onPrimary, child: Text(primaryLabel)),
          const SizedBox(height: 14),
          Center(
            child: TextButton(
              onPressed: onSecondary,
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.onSurfaceVariant,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                secondaryLabel,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
