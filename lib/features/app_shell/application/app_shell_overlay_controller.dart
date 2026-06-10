import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rhythm/features/app_shell/domain/app_shell_models.dart';

part 'app_shell_overlay_controller.g.dart';

/// 管理 app-shell 级别的全局 overlay 事件队列。
@Riverpod(keepAlive: true)
class AppShellOverlayController extends _$AppShellOverlayController {
  @override
  List<AppShellOverlayEvent> build() {
    return const [];
  }

  /// 追加一条 overlay 事件，避免同一文案在短时间内重复入队。
  void enqueue(AppShellOverlayEvent event) {
    if (state.contains(event)) {
      return;
    }

    state = [...state, event];
  }

  /// 追加成功反馈，供启动恢复或业务回流链路复用。
  void showSuccess(String message) {
    enqueue(AppShellOverlayEvent.success(message: message));
  }

  /// 追加普通提示，供非阻断反馈链路复用。
  void showInfo(String message) {
    enqueue(AppShellOverlayEvent.info(message: message));
  }

  /// 追加阻断错误，优先级高于其他非阻断反馈。
  void showBlockingError(String message) {
    enqueue(AppShellOverlayEvent.blockingError(message: message));
  }

  /// 移除已经展示完成的事件，保持队列只承载待消费反馈。
  void dismiss(AppShellOverlayEvent event) {
    state = state.where((item) => item != event).toList(growable: false);
  }
}
