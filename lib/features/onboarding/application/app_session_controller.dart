import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 应用会话状态，控制首次激活与主流程的切换。
class AppSessionState {
  const AppSessionState({
    required this.hasCompletedOnboarding,
    this.goalScheduleId,
  });

  /// 是否已经完成首次激活。
  final bool hasCompletedOnboarding;

  /// 当前已保存的目标作息标识。
  final String? goalScheduleId;

  /// 基于局部更新构造新的会话状态。
  AppSessionState copyWith({
    bool? hasCompletedOnboarding,
    String? goalScheduleId,
  }) {
    return AppSessionState(
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      goalScheduleId: goalScheduleId ?? this.goalScheduleId,
    );
  }
}

/// 应用会话控制器，先用内存状态驱动首次激活流程，后续再接本地持久化。
class AppSessionController extends Notifier<AppSessionState> {
  /// 初始化会话状态，新用户默认未完成首次激活。
  @override
  AppSessionState build() {
    return const AppSessionState(hasCompletedOnboarding: false);
  }

  /// 标记首次激活完成，并保存目标作息标识。
  void completeOnboarding({required String goalScheduleId}) {
    state = state.copyWith(
      hasCompletedOnboarding: true,
      goalScheduleId: goalScheduleId,
    );
  }
}

/// 暴露应用会话状态，供路由和页面共同读取。
final appSessionControllerProvider =
    NotifierProvider<AppSessionController, AppSessionState>(
      AppSessionController.new,
    );
