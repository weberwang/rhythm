import 'analytics_event.dart';

/// 定义应用内埋点上报边界，避免业务层直接依赖具体分析 SDK。
abstract class AnalyticsGateway {
  /// 上报单次事件。
  Future<void> track(AnalyticsEvent event);
}
