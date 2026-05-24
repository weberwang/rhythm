import 'package:flutter_test/flutter_test.dart';

import '../../support/sleep_records_test_app.dart';

/// 验证阶段三管理页可进入手动补录页。
void main() {
  testWidgets('从睡眠记录管理页进入手动补录页', (tester) async {
    await pumpSleepRecordsFlowApp(tester);
    await tester.pumpAndSettle();

    await tester.tap(find.text('改用手动模式'));
    await tester.pumpAndSettle();

    expect(find.text('手动补录'), findsOneWidget);
    expect(find.text('手动确认昨晚的睡眠结果'), findsOneWidget);
    expect(find.text('归属日期'), findsOneWidget);
    expect(find.text('入睡时间'), findsOneWidget);
    expect(find.text('起床时间'), findsOneWidget);
    expect(find.text('保存补录结果'), findsOneWidget);
  });
}
