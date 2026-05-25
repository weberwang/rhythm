import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/today/domain/today_summary.dart';

void main() {
  test('有最近记录时生成摘要文案', () {
    final summary = TodaySummary.fromRecordTimes(
      fellAsleepLabel: '23:40',
      wokeUpLabel: '07:20',
    );

    expect(summary.latestRecordLabel, '最近一条记录：23:40 - 07:20');
  });

  test('没有记录时不生成摘要文案', () {
    const summary = TodaySummary.empty();

    expect(summary.latestRecordLabel, isNull);
  });
}
