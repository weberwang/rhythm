import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/rhythm_app.dart';

/// 验证应用根组件接入 Flutter 国际化生成配置。
void main() {
  testWidgets('App 根组件配置本地化代理和支持语言', (tester) async {
    await tester.pumpWidget(const RhythmApp());

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(app.localizationsDelegates, isNotNull);
    expect(app.localizationsDelegates!.length, greaterThanOrEqualTo(4));
    expect(app.supportedLocales, contains(const Locale('en')));
    expect(app.supportedLocales, contains(const Locale('zh')));
  });
}
