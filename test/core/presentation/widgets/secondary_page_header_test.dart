import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rhythm/core/presentation/widgets/secondary_page_header.dart';

/// 验证二级页头会优先返回来源页，并在没有返回栈时跳到兜底页。
void main() {
  testWidgets('点击返回按钮时优先返回来源页', (tester) async {
    final router = GoRouter(
      initialLocation: '/source',
      routes: [
        GoRoute(
          path: '/source',
          builder: (context, state) => Scaffold(
            body: Center(
              child: FilledButton(
                onPressed: () => context.push('/detail'),
                child: const Text('open-detail'),
              ),
            ),
          ),
        ),
        GoRoute(
          path: '/detail',
          builder: (context, state) => const Scaffold(
            body: SecondaryPageHeader(
              title: 'detail',
              fallbackLocation: '/fallback',
            ),
          ),
        ),
        GoRoute(
          path: '/fallback',
          builder: (context, state) => const Scaffold(body: Text('fallback')),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    await tester.tap(find.text('open-detail'));
    await tester.pumpAndSettle();

    expect(find.text('detail'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    expect(find.text('open-detail'), findsOneWidget);
    expect(find.text('fallback'), findsNothing);
  });

  testWidgets('没有返回栈时点击返回按钮会进入兜底页', (tester) async {
    final router = GoRouter(
      initialLocation: '/detail',
      routes: [
        GoRoute(
          path: '/detail',
          builder: (context, state) => const Scaffold(
            body: SecondaryPageHeader(
              title: 'detail',
              fallbackLocation: '/fallback',
            ),
          ),
        ),
        GoRoute(
          path: '/fallback',
          builder: (context, state) => const Scaffold(body: Text('fallback')),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    expect(find.text('fallback'), findsOneWidget);
  });
}
