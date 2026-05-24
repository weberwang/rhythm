import 'analytics_event.dart';
import 'analytics_gateway.dart';

/// 提供测试可观察的内存埋点实现，避免测试依赖真实外部 SDK。
class InMemoryAnalyticsGateway implements AnalyticsGateway {
  /// 按写入顺序保留的事件列表。
  final List<AnalyticsEvent> events = <AnalyticsEvent>[];

  @override
  Future<void> track(AnalyticsEvent event) async {
    events.add(event);
  }
}
