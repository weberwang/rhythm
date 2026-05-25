import 'package:flutter_test/flutter_test.dart';

import 'package:rhythm/app/bootstrap/bootstrap_launch_entry.dart';

import '../support/test_app.dart';

/// 验证启动分发会根据首次引导状态进入正确页面。
void main() {
  testWidgets('首次启动时跳转到引导欢迎页', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    expect(find.text('先把节奏跑起来'), findsOneWidget);
    expect(find.text('还没有设置作息目标'), findsNothing);
  });

  testWidgets('已完成引导时跳转到今日页', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: true);
    await tester.pumpAndSettle();

    expect(find.text('还没有设置作息目标'), findsOneWidget);
  });

  testWidgets('today 小组件冷启动时直接进入今日页', (tester) async {
    await pumpRhythmApp(
      tester,
      onboardingCompleted: true,
      overrides: [
        bootstrapLaunchEntryProvider.overrideWithValue(
          const BootstrapLaunchEntry(target: BootstrapEntryTarget.today),
        ),
      ],
    );
    await tester.pumpAndSettle();

    expect(find.text('还没有设置作息目标'), findsOneWidget);
  });
}
