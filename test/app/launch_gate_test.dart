import 'package:flutter_test/flutter_test.dart';

import 'package:rhythm/app/bootstrap/bootstrap_launch_entry.dart';

import '../support/test_app.dart';

/// 验证启动分发页会先展示视觉承载，再根据启动状态跳到正确页面。
void main() {
  testWidgets('首次启动时先显示启动分发视觉，再进入欢迎页', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pump();

    expect(find.text('启动中'), findsOneWidget);
    expect(find.text('先把今晚的节律准备好'), findsOneWidget);
    expect(find.text('准备进入 Rhythm'), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('今晚开始，把作息慢慢拉回你想要的节奏'), findsOneWidget);
    expect(find.text('还没有设置作息目标'), findsNothing);
  });

  testWidgets('已完成引导时仍进入今日页', (tester) async {
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
