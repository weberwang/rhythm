import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../sleep_records/application/manual_sleep_record_controller.dart';
import '../domain/today_summary.dart';

/// 今日页摘要 Provider，后续会继续并入目标、恢复建议和趋势等信息。
final todaySummaryProvider = Provider<TodaySummary>((ref) {
  final record = ref.watch(manualSleepRecordProvider);
  if (record == null) {
    return const TodaySummary.empty();
  }

  String formatTime(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  return TodaySummary.fromRecordTimes(
    fellAsleepLabel: formatTime(record.fellAsleepAt),
    wokeUpLabel: formatTime(record.wokeUpAt),
  );
});
