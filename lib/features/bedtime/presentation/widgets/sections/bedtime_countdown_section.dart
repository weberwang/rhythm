import 'package:flutter/material.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 渲染睡前页的目标摘要与倒计时，保证首屏先回答“今晚离目标还有多远”。
class BedtimeCountdownSection extends StatelessWidget {
  /// 创建倒计时区块。
  const BedtimeCountdownSection({
    super.key,
    required this.now,
    required this.targetBedtime,
    required this.minutesUntilTarget,
    required this.progress,
  });

  /// 当前时间。
  final DateTime now;

  /// 今晚目标入睡时间。
  final DateTime targetBedtime;

  /// 距离目标入睡的分钟差。
  final int minutesUntilTarget;

  /// 倒计时进度。
  final double progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.bedtimeCountdownTitle, style: textTheme.titleMedium),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _TimeChip(
                  label: l10n.bedtimeCurrentTimeLabel,
                  value: _formatTime(now),
                ),
                _TimeChip(
                  label: l10n.bedtimeTargetTimeLabel,
                  value: _formatTime(targetBedtime),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              minutesUntilTarget >= 0
                  ? l10n.bedtimeTargetDiffAhead(minutesUntilTarget)
                  : l10n.bedtimeTargetDiffLate(minutesUntilTarget.abs()),
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              borderRadius: BorderRadius.circular(9999),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

/// 渲染时间胶囊，避免倒计时主区块里散落重复格式布局。
class _TimeChip extends StatelessWidget {
  const _TimeChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: textTheme.labelMedium),
          const SizedBox(height: 4),
          Text(
            value,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
