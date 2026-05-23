import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/notifications/domain/reminder_settings_state.dart';

import '../../support/test_app.dart';

/// 验证提醒策略默认状态与首次引导完成链路。
void main() {
  test('提醒策略默认值符合 MVP 预期', () {
    const state = ReminderSettingsState();

    expect(state.softReminderEnabled, isTrue);
    expect(state.targetReminderEnabled, isFalse);
    expect(state.weeklyReportEnabled, isTrue);
    expect(state.leadMinutes, 45);
  });

  testWidgets('提醒策略保存后进入今日页', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    await tester.tap(find.text('开始设置'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('匿名体验'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('先用手动模式'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('保存目标，继续下一步'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('完成设置，进入今日页'));
    await tester.pumpAndSettle();

    expect(find.text('今晚先轻一点'), findsOneWidget);
  });
}
