import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示某一天记录详情，解释睡眠结果、来源和标签。
class CalendarDayDetailSheet extends StatelessWidget {
  /// 创建单日详情弹层。
  const CalendarDayDetailSheet({
    super.key,
    required this.summary,
    required this.onAddTag,
    this.onEditRecord,
  });

  /// 当前日期摘要。
  final CalendarDaySummary summary;

  /// 点击添加标签时的回调。
  final VoidCallback onAddTag;

  /// 点击编辑记录时的回调。
  final VoidCallback? onEditRecord;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final record = summary.record;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('M 月 d 日').format(summary.date),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 16),
            if (record != null) ...[
              _DetailRow(
                title: l10n.calendarDetailSleepTime,
                value: DateFormat('HH:mm').format(record.fellAsleepAt),
              ),
              _DetailRow(
                title: l10n.calendarDetailWakeTime,
                value: DateFormat('HH:mm').format(record.wokeUpAt),
              ),
              _DetailRow(
                title: l10n.calendarDetailOffset,
                value: '${summary.sleepOffsetMinutes ?? 0} 分钟',
              ),
              _DetailRow(
                title: l10n.calendarDetailSource,
                value: '${record.source.name} / ${record.confidence.name}',
              ),
            ] else
              Text(l10n.calendarDetailNoRecord),
            const SizedBox(height: 16),
            Text(
              l10n.calendarDetailTagsTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final tag in summary.tags)
                  Chip(
                    label: Text(tag),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                FilledButton.tonal(
                  onPressed: onAddTag,
                  child: Text(l10n.calendarDetailAddTag),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: onEditRecord,
                  child: Text(l10n.calendarDetailEditRecord),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 详情信息行。
class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
