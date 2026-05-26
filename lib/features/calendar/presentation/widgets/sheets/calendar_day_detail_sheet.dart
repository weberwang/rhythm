import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/presentation/widgets/calendar_mood_style.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';
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
    final mood = summary.primaryMood;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (mood != null) ...[
              Container(
                key: const Key('calendar-day-mood-accent'),
                width: 44,
                height: 6,
                decoration: BoxDecoration(
                  color: resolveCalendarMoodStyle(context, mood).edgeColor,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 12),
            ],
            Text(
              _formatDateLabel(context),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
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
                value: l10n.calendarDetailOffsetValue(
                  summary.sleepOffsetMinutes ?? 0,
                ),
              ),
              _DetailRow(
                title: l10n.calendarDetailSource,
                value:
                    '${_sourceLabel(record.source, l10n)} / ${_confidenceLabel(record.confidence, l10n)}',
              ),
            ] else
              Text(l10n.calendarDetailNoRecord),
            const SizedBox(height: 16),
            Text(
              l10n.calendarDetailTagsTitle,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final tag in summary.tags)
                  Chip(label: Text(tag), visualDensity: VisualDensity.compact),
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

  /// 按语言环境输出单日标题，中文保留现有阅读习惯，英文走本地化月日格式。
  String _formatDateLabel(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (locale.startsWith('zh')) {
      return DateFormat('M 月 d 日').format(summary.date);
    }
    return DateFormat.MMMd(locale).format(summary.date);
  }

  /// 将来源枚举映射成可展示文案，避免显示层直接暴露原始枚举值。
  String _sourceLabel(SleepRecordSource source, AppLocalizations l10n) {
    switch (source) {
      case SleepRecordSource.healthKit:
        return l10n.commonRecordSourceHealthKit;
      case SleepRecordSource.healthConnect:
        return l10n.commonRecordSourceHealthConnect;
      case SleepRecordSource.manual:
        return l10n.commonRecordSourceManual;
      case SleepRecordSource.imported:
        return l10n.commonRecordSourceImported;
    }
  }

  /// 将可信度枚举映射成本地化标签，避免中文页面出现英文枚举名。
  String _confidenceLabel(
    SleepRecordConfidence confidence,
    AppLocalizations l10n,
  ) {
    switch (confidence) {
      case SleepRecordConfidence.high:
        return l10n.commonConfidenceHigh;
      case SleepRecordConfidence.medium:
        return l10n.commonConfidenceMedium;
      case SleepRecordConfidence.low:
        return l10n.commonConfidenceLow;
      case SleepRecordConfidence.unknown:
        return l10n.commonConfidenceUnknown;
    }
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
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
