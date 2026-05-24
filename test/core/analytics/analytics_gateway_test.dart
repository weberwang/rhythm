import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/analytics/analytics_event.dart';
import 'package:rhythm/core/analytics/analytics_gateway.dart';
import 'package:rhythm/core/analytics/in_memory_analytics_gateway.dart';

/// 验证内存埋点网关会保留事件名和参数，供阶段五控制器测试复用。
void main() {
  test('内存埋点网关会记录事件', () async {
    final gateway = InMemoryAnalyticsGateway();

    await gateway.track(
      const AnalyticsEvent(
        name: AnalyticsEventName.bedtimeModeEntered,
        parameters: <String, Object?>{
          'source': 'tab',
        },
      ),
    );

    expect(gateway.events, hasLength(1));
    expect(gateway.events.first.name, AnalyticsEventName.bedtimeModeEntered);
    expect(gateway.events.first.parameters['source'], 'tab');
  });
}
