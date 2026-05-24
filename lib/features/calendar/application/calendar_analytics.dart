import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/core/analytics/analytics_event.dart';
import 'package:rhythm/core/analytics/analytics_gateway.dart';
import 'package:rhythm/core/analytics/in_memory_analytics_gateway.dart';

/// 提供阶段六日历埋点网关，当前沿用内存实现便于测试。
final calendarAnalyticsGatewayProvider = Provider<AnalyticsGateway>((ref) {
  return InMemoryAnalyticsGateway();
});

/// 提供阶段六日历埋点边界，统一收口页面层事件名。
final calendarAnalyticsProvider = Provider<CalendarAnalytics>((ref) {
  return CalendarAnalytics(ref.read(calendarAnalyticsGatewayProvider));
});

/// 承接阶段六日历页相关埋点。
class CalendarAnalytics {
  /// 创建日历埋点实例。
  CalendarAnalytics(this._gateway);

  final AnalyticsGateway _gateway;

  /// 记录用户进入日历页。
  Future<void> trackViewed({required DateTime month}) {
    return _gateway.track(
      AnalyticsEvent(
        name: AnalyticsEventName.calendarViewed,
        parameters: <String, Object?>{
          'month': '${month.year}-${month.month.toString().padLeft(2, '0')}',
        },
      ),
    );
  }

  /// 记录用户查看单日详情。
  Future<void> trackDayDetailViewed({required DateTime recordDate}) {
    return _gateway.track(
      AnalyticsEvent(
        name: AnalyticsEventName.dayDetailViewed,
        parameters: <String, Object?>{
          'record_date':
              '${recordDate.year}-${recordDate.month.toString().padLeft(2, '0')}-${recordDate.day.toString().padLeft(2, '0')}',
        },
      ),
    );
  }

  /// 记录用户补充原因标签。
  Future<void> trackDelayTagAdded({
    required DateTime recordDate,
    required String tag,
  }) {
    return _gateway.track(
      AnalyticsEvent(
        name: AnalyticsEventName.delayTagAdded,
        parameters: <String, Object?>{
          'record_date':
              '${recordDate.year}-${recordDate.month.toString().padLeft(2, '0')}-${recordDate.day.toString().padLeft(2, '0')}',
          'tag': tag,
        },
      ),
    );
  }
}
