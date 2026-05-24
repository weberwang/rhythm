import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/analytics/analytics_event.dart';
import 'package:rhythm/core/analytics/in_memory_analytics_gateway.dart';
import 'package:rhythm/features/calendar/application/calendar_analytics.dart';

/// 验证阶段六埋点边界会记录日历相关事件。
void main() {
  test('日历埋点会透传事件名和参数', () async {
    final gateway = InMemoryAnalyticsGateway();
    final container = ProviderContainer(
      overrides: [
        calendarAnalyticsGatewayProvider.overrideWithValue(gateway),
      ],
    );
    addTearDown(container.dispose);

    final analytics = container.read(calendarAnalyticsProvider);
    await analytics.trackViewed(month: DateTime.utc(2026, 5));
    await analytics.trackDayDetailViewed(recordDate: DateTime.utc(2026, 5, 24));
    await analytics.trackDelayTagAdded(
      recordDate: DateTime.utc(2026, 5, 24),
      tag: '刷手机',
    );

    expect(gateway.events.map((event) => event.name).toList(), [
      AnalyticsEventName.calendarViewed,
      AnalyticsEventName.dayDetailViewed,
      AnalyticsEventName.delayTagAdded,
    ]);
  });
}
