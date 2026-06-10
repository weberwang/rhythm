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
        child: GlobalOverlayHost(events: []),
      ),
    );

    expect(find.byType(Icon), findsNothing);
    expect(find.byType(Text), findsNothing);
  });
}

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
