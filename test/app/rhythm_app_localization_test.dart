import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_app.dart';

/// 验证根应用已正确接入 Flutter 官方国际化配置。
void main() {
  testWidgets('App 根组件配置本地化代理和支持语言', (tester) async {
    await pumpRhythmApp(
      tester,
      onboardingCompleted: true,
      locale: const Locale('en'),
    );

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(app.localizationsDelegates, isNotNull);
    expect(app.localizationsDelegates!.length, greaterThanOrEqualTo(4));
    expect(app.supportedLocales, contains(const Locale('en')));
    expect(app.supportedLocales, contains(const Locale('zh')));
  });
}
