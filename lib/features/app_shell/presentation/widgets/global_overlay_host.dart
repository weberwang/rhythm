import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rhythm/app/theme/rhythm_theme.dart';
import 'package:rhythm/features/app_shell/domain/app_shell_models.dart';

/// 根级 overlay 宿主。
class GlobalOverlayHost extends HookWidget {
  /// 创建 overlay 宿主。
  const GlobalOverlayHost({
    required this.events,
    required this.onDismiss,
    super.key,
  });

  /// 待展示的事件队列。
  final List<AppShellOverlayEvent> events;

  /// 当宿主消费完非阻断反馈后回传移除动作。
  final ValueChanged<AppShellOverlayEvent> onDismiss;

  @override
  Widget build(BuildContext context) {
    final activeEvent = _pickHighestPriorityEvent(events);
    if (activeEvent == null) {
      return const SizedBox.shrink();
    }

    useEffect(() {
      if (activeEvent.type == AppShellOverlayType.blockingError) {
        return null;
      }

      var cancelled = false;
      Future<void>.delayed(const Duration(seconds: 3), () {
        if (!cancelled) {
          onDismiss(activeEvent);
        }
      });

      return () {
        cancelled = true;
      };
    }, [activeEvent]);

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: _backgroundColor(activeEvent.type),
                borderRadius: BorderRadius.circular(RhythmRadius.control),
                border: Border.all(color: RhythmColors.borderSubtle),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: RhythmSpacing.m,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Icon(
                      _iconForType(activeEvent.type),
                      color: _foregroundColor(activeEvent.type),
                    ),
                    const SizedBox(width: RhythmSpacing.s),
                    Expanded(
                      child: Text(
                        activeEvent.message,
                        style: RhythmTextStyles.body.copyWith(
                          color: _foregroundColor(activeEvent.type),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 选择优先级最高的事件。
  AppShellOverlayEvent? _pickHighestPriorityEvent(
    List<AppShellOverlayEvent> queue,
  ) {
    if (queue.isEmpty) {
      return null;
    }

    final sorted = [...queue]
      ..sort((left, right) {
        return _priorityOf(left.type).compareTo(_priorityOf(right.type));
      });
    return sorted.first;
  }

  /// 输出优先级数值，数值越小优先级越高。
  int _priorityOf(AppShellOverlayType type) {
    switch (type) {
      case AppShellOverlayType.blockingError:
        return 0;
      case AppShellOverlayType.success:
        return 1;
      case AppShellOverlayType.info:
        return 2;
    }
  }

  /// 计算不同事件类型的背景色。
  Color _backgroundColor(AppShellOverlayType type) {
    switch (type) {
      case AppShellOverlayType.blockingError:
        return const Color(0xFFFFF3EF);
      case AppShellOverlayType.success:
        return const Color(0xFFF1F8F0);
      case AppShellOverlayType.info:
        return RhythmColors.surfaceElevated;
    }
  }

  /// 计算不同事件类型的前景色。
  Color _foregroundColor(AppShellOverlayType type) {
    switch (type) {
      case AppShellOverlayType.blockingError:
        return RhythmColors.error;
      case AppShellOverlayType.success:
        return RhythmColors.success;
      case AppShellOverlayType.info:
        return RhythmColors.textPrimary;
    }
  }

  /// 计算不同事件类型的图标。
  IconData _iconForType(AppShellOverlayType type) {
    switch (type) {
      case AppShellOverlayType.blockingError:
        return Icons.error_outline_rounded;
      case AppShellOverlayType.success:
        return Icons.check_circle_outline_rounded;
      case AppShellOverlayType.info:
        return Icons.info_outline_rounded;
    }
  }
}
