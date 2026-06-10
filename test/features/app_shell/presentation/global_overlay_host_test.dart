import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/theme/rhythm_theme.dart';
import 'package:rhythm/features/app_shell/domain/app_shell_models.dart';
import 'package:rhythm/features/app_shell/presentation/widgets/global_overlay_host.dart';

void main() {
  testWidgets('blocking error 优先于 success 和 info', (tester) async {
    await tester.pumpWidget(
      _OverlayTestApp(
        child: GlobalOverlayHost(
          events: const [
            AppShellOverlayEvent.info(message: 'info'),
            AppShellOverlayEvent.success(message: 'ok'),
            AppShellOverlayEvent.blockingError(message: 'fatal'),
          ],
          onDismiss: (_) {},
        ),
      ),
    );

    expect(find.text('fatal'), findsOneWidget);
    expect(find.text('ok'), findsNothing);
    expect(find.text('info'), findsNothing);
  });

  testWidgets('无事件时不渲染 overlay', (tester) async {
    await tester.pumpWidget(
      const _OverlayTestApp(
        child: GlobalOverlayHost(events: [], onDismiss: _noopDismiss),
      ),
    );

    expect(find.byType(Icon), findsNothing);
    expect(find.byType(Text), findsNothing);
  });

  testWidgets('success 反馈会在展示后自动回收', (tester) async {
    AppShellOverlayEvent? dismissedEvent;

    await tester.pumpWidget(
      _OverlayTestApp(
        child: GlobalOverlayHost(
          events: const [AppShellOverlayEvent.success(message: 'restored')],
          onDismiss: (event) {
            dismissedEvent = event;
          },
        ),
      ),
    );

    expect(find.text('restored'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

    expect(
      dismissedEvent,
      const AppShellOverlayEvent.success(message: 'restored'),
    );
  });
}

/// 为 const 构造测试提供空 dismiss 回调。
void _noopDismiss(AppShellOverlayEvent _) {}

class _OverlayTestApp extends StatelessWidget {
  const _OverlayTestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildRhythmLightTheme(),
      home: Scaffold(body: child),
    );
  }
}
