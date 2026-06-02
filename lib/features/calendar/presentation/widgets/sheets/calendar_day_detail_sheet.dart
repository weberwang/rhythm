import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rhythm/features/calendar/domain/calendar_day_summary.dart';
import 'package:rhythm/features/calendar/presentation/widgets/calendar_mood_style.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 展示某一天记录详情，按 Pencil 半屏卡结构解释结果、来源和标签。
class CalendarDayDetailSheet extends StatelessWidget {
  /// 创建单日详情弹层。
  const CalendarDayDetailSheet({
    super.key,
    required this.summary,
    required this.onAddTag,
    required this.onExplainSource,
    this.onEditRecord,
  });

  /// 当前日期摘要。
  final CalendarDaySummary summary;

  /// 点击添加标签时的回调。
  final VoidCallback onAddTag;

  /// 点击来源说明时的回调。
  final VoidCallback onExplainSource;

  /// 点击编辑记录时的回调。
  final VoidCallback? onEditRecord;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final record = summary.record;
    final mood = summary.primaryMood;

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
            const SizedBox(height: 12),
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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Geist',
                color: const Color(0xFF1B3A28),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _buildSummaryText(context),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: 'Geist',
                color: const Color(0xFF4A6B52),
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 12),
            _DetailCard(
              child: record == null
                  ? Text(
                      l10n.calendarDetailNoRecord,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Geist',
                        color: const Color(0xFF4A6B52),
                      ),
                    )
                  : Column(
                      children: [
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
                          isLast: true,
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 12),
            _DetailCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.calendarDetailSource,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontFamily: 'Geist',
                      color: const Color(0xFF1B3A28),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    record == null
                        ? l10n.calendarDetailNoRecord
                        : '${_sourceLabel(record.source, l10n)} / ${_confidenceLabel(record.confidence, l10n)}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'Geist',
                      color: const Color(0xFF4A6B52),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.tonal(
                    onPressed: onExplainSource,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFE3EEE0),
                      foregroundColor: const Color(0xFF4A6B52),
                    ),
                    child: Text(l10n.recordSourceExplainerTitle),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _DetailCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.calendarDetailTagsTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontFamily: 'Geist',
                      color: const Color(0xFF1B3A28),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final tag in summary.tags)
                        _TagChip(label: tag),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      FilledButton.tonal(
                        onPressed: onAddTag,
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFFE3EEE0),
                          foregroundColor: const Color(0xFF4A6B52),
                        ),
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
          ],
        ),
      ),
    );
  }

  /// 中文保留月日阅读习惯，英文沿用本地化简写。
  String _formatDateLabel(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (locale.startsWith('zh')) {
      return DateFormat('M 月 d 日').format(summary.date);
    }
    return DateFormat.MMMd(locale).format(summary.date);
  }

  /// 半屏卡摘要优先输出当晚结果，帮助用户在展开后先建立语义焦点。
  String _buildSummaryText(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final record = summary.record;
    if (record == null) {
      return l10n.calendarDetailNoRecord;
    }
    final offset = summary.sleepOffsetMinutes ?? 0;
    final offsetLabel = l10n.calendarDetailOffsetValue(offset);
    return '${DateFormat('HH:mm').format(record.fellAsleepAt)} 入睡｜$offsetLabel';
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

/// 详情半屏卡里的信息卡，统一控制背景、圆角和阴影层级。
class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBF6),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// 详情信息行。
class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.title,
    required this.value,
    this.isLast = false,
  });

  final String title;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: 'Geist',
                color: const Color(0xFF4A6B52),
              ),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontFamily: 'IBM Plex Mono',
              color: const Color(0xFF1B3A28),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// 标签胶囊统一对齐 Pencil 的轻量色块样式。
class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFE3EEE0),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontFamily: 'Geist',
            color: const Color(0xFF4A6B52),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
