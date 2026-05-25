import 'package:flutter/material.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/app/router/secondary_navigation.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sleep_record_time_formatter.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 承载阶段三管理页的有效记录列表区，避免页面文件继续堆积展示细节。
class SleepRecordListSection extends StatelessWidget {
  /// 创建记录列表区实例。
  const SleepRecordListSection({super.key, required this.records});

  /// 当前可展示的有效记录。
  final List<EffectiveSleepRecord> records;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (records.isEmpty) {
      return Center(child: Text(l10n.sleepRecordsHubEmptyState));
    }

    return ListView.separated(
      itemCount: records.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final record = records[index];
        final title = switch (record.source) {
          SleepRecordSource.manual => l10n.sleepRecordsHubManualRecordTitle,
          SleepRecordSource.healthConnect =>
            l10n.sleepRecordsHubHealthConnectRecordTitle,
          SleepRecordSource.healthKit =>
            l10n.sleepRecordsHubHealthKitRecordTitle,
          SleepRecordSource.imported => l10n.sleepRecordsHubImportedRecordTitle,
        };

        return Card(
          child: ListTile(
            title: Text(title),
            subtitle: Text(
              '${formatSleepRecordTime(record.fellAsleepAt.hour, record.fellAsleepAt.minute)} - '
              '${formatSleepRecordTime(record.wokeUpAt.hour, record.wokeUpAt.minute)}',
            ),
            onTap: () {
              context.pushSecondary(manualSleepRecordEditPath(record.recordId));
            },
          ),
        );
      },
    );
  }
}
