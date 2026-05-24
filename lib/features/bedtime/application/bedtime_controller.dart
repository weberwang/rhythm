import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/core/analytics/analytics_event.dart';
import 'package:rhythm/core/analytics/analytics_gateway.dart';
import 'package:rhythm/core/analytics/in_memory_analytics_gateway.dart';
import 'package:rhythm/core/time/time_context_provider.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:uuid/uuid.dart';

import '../data/in_memory_bedtime_session_repository.dart';
import '../domain/bedtime_action.dart';
import '../domain/bedtime_mode_summary.dart';
import '../domain/bedtime_session.dart';
import '../domain/bedtime_status.dart';
import '../domain/repositories/bedtime_session_repository.dart';
import 'bedtime_view_state.dart';

/// 提供睡前会话仓储，先用内存实现支撑阶段五的控制器与页面开发。
final bedtimeSessionRepositoryProvider = Provider<BedtimeSessionRepository>((
  ref,
) {
  return InMemoryBedtimeSessionRepository();
});

/// 提供应用级埋点上报边界，当前默认使用内存实现便于测试和后续替换。
final analyticsGatewayProvider = Provider<AnalyticsGateway>((ref) {
  return InMemoryAnalyticsGateway();
});

/// 聚合目标作息、当前时间和会话仓储，向睡前页输出单一可渲染状态。
final bedtimeControllerProvider =
    AsyncNotifierProvider.autoDispose<BedtimeController, BedtimeViewState>(
      BedtimeController.new,
    );

/// 承载睡前页的会话创建、状态选择和动作埋点逻辑。
class BedtimeController extends AsyncNotifier<BedtimeViewState> {
  late BedtimeSessionRepository _sessionRepository;
  late AnalyticsGateway _analyticsGateway;
  late DateTime _now;
  late DateTime _targetBedtime;
  late BedtimeSession _session;

  @override
  Future<BedtimeViewState> build() async {
    _sessionRepository = ref.read(bedtimeSessionRepositoryProvider);
    _analyticsGateway = ref.read(analyticsGatewayProvider);

    final settings = await ref.read(savedGoalScheduleSettingsProvider.future);
    if (settings == null) {
      return const BedtimeViewState(status: BedtimeViewStatus.goalMissing);
    }

    final timeContext = ref.read(timeContextProvider);
    _now = timeContext.now;
    _targetBedtime = DateTime(
      _now.year,
      _now.month,
      _now.day,
      settings.targetBedtimeMinutes ~/ 60,
      settings.targetBedtimeMinutes % 60,
    );

    _session = await _sessionRepository.findByDate(_now) ??
        BedtimeSession(
          id: const Uuid().v4(),
          startedAt: _now,
          targetBedtime: _targetBedtime,
          createdAt: _now,
        );
    await _sessionRepository.save(_session);

    await _analyticsGateway.track(
      const AnalyticsEvent(
        name: AnalyticsEventName.bedtimeModeEntered,
        parameters: <String, Object?>{
          'source': 'tab',
        },
      ),
    );

    return _buildReadyState(
      selectedStatus: _session.selectedStatus,
    );
  }

  /// 更新今晚状态选择，并同步刷新动作建议与埋点。
  Future<void> selectStatus(BedtimeStatus status) async {
    final readyState = state.requireValue;
    if (readyState.status != BedtimeViewStatus.ready) {
      return;
    }

    _session = _session.copyWith(
      selectedStatus: status,
      selectedAt: _now,
    );
    await _sessionRepository.save(_session);
    await _analyticsGateway.track(
      AnalyticsEvent(
        name: AnalyticsEventName.bedtimeStatusSelected,
        parameters: <String, Object?>{
          'status': status.name,
        },
      ),
    );

    state = AsyncData(_buildReadyState(selectedStatus: status));
  }

  /// 记录动作点击，供后续分析哪类建议更容易被执行。
  Future<void> completeAction(BedtimeAction action) async {
    final readyState = state.requireValue;
    if (readyState.status != BedtimeViewStatus.ready) {
      return;
    }

    _session = _session.copyWith(completedActionName: action.analyticsName);
    await _sessionRepository.save(_session);
    await _analyticsGateway.track(
      AnalyticsEvent(
        name: AnalyticsEventName.bedtimeActionClicked,
        parameters: <String, Object?>{
          'action': action.analyticsName,
        },
      ),
    );
  }

  /// 根据当前推荐状态和用户选择产出可直接渲染的 ready 状态。
  BedtimeViewState _buildReadyState({
    required BedtimeStatus? selectedStatus,
  }) {
    final summary = BedtimeModeSummary.calculate(
      now: _now,
      targetBedtime: _targetBedtime,
      softReminderLeadMinutes: 45,
    );
    final effectiveStatus = selectedStatus ?? summary.recommendedStatus;

    return BedtimeViewState(
      status: BedtimeViewStatus.ready,
      sessionId: _session.id,
      now: _now,
      targetBedtime: _targetBedtime,
      minutesUntilTarget: summary.minutesUntilTarget,
      progress: summary.progress,
      selectedStatus: selectedStatus,
      recommendedStatus: summary.recommendedStatus,
      actions: _actionsForStatus(effectiveStatus),
    );
  }

  /// 根据最终状态输出页面建议，确保用户主动选择后建议跟着切换。
  List<BedtimeAction> _actionsForStatus(BedtimeStatus status) {
    switch (status) {
      case BedtimeStatus.readyToSleep:
        return const <BedtimeAction>[
          BedtimeAction(
            type: BedtimeActionType.dimLights,
            analyticsName: 'dim_lights',
            priority: 0,
          ),
          BedtimeAction(
            type: BedtimeActionType.putPhoneAway,
            analyticsName: 'put_phone_away',
            priority: 1,
          ),
        ];
      case BedtimeStatus.wantsMoreTime:
        return const <BedtimeAction>[
          BedtimeAction(
            type: BedtimeActionType.tenMinuteWrapUp,
            analyticsName: 'ten_minute_wrap_up',
            priority: 0,
          ),
          BedtimeAction(
            type: BedtimeActionType.closeTonight,
            analyticsName: 'close_tonight',
            priority: 1,
          ),
        ];
      case BedtimeStatus.likelyLate:
        return const <BedtimeAction>[
          BedtimeAction(
            type: BedtimeActionType.planRecoveryTomorrow,
            analyticsName: 'plan_recovery_tomorrow',
            priority: 0,
          ),
          BedtimeAction(
            type: BedtimeActionType.closeTonight,
            analyticsName: 'close_tonight',
            priority: 1,
          ),
        ];
    }
  }
}
