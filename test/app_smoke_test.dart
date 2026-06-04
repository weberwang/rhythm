import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/app/rhythm_app.dart';

/// 验证初始化后的应用根节点至少可以正常启动到启动页。
void main() {
  testWidgets('Rhythm app boots to launch page', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RhythmApp()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
