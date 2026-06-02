import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_page_hero.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_page_scaffold.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_primary_button.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_secondary_button.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_surface_card.dart';

/// 验证共享页面骨架能够固定底部动作区并允许正文滚动。
void main() {
  testWidgets('页面骨架会显示 hero 和主按钮，并固定底部动作区', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RhythmPageScaffold(
          backgroundColor: const Color(0xFFF5F3EE),
          hero: const RhythmPageHero(
            eyebrow: '眉标',
            title: '标题',
            description: '说明',
          ),
          body: Column(
            children: List<Widget>.generate(
              8,
              (index) => Container(
                height: 80,
                margin: const EdgeInsets.only(bottom: 12),
                color: Colors.white,
              ),
            ),
          ),
          primaryAction: RhythmPrimaryButton(label: '继续', onPressed: () {}),
        ),
      ),
    );

    expect(find.text('标题'), findsOneWidget);
    expect(find.byType(RhythmPageHero), findsOneWidget);
    expect(find.byType(RhythmPrimaryButton), findsOneWidget);

    final actionTop = tester.getTopLeft(find.byType(RhythmPrimaryButton)).dy;

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();

    expect(tester.getTopLeft(find.byType(RhythmPrimaryButton)).dy, actionTop);
  });

  testWidgets('页面骨架会按 footer、secondary、primary 顺序渲染底部动作区', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RhythmPageScaffold(
          backgroundColor: const Color(0xFFF5F3EE),
          hero: const RhythmPageHero(
            eyebrow: '眉标',
            title: '标题',
            description: '说明',
            trailing: Text('尾部内容'),
          ),
          body: const SizedBox(height: 40),
          footer: const Text('页脚说明'),
          secondaryAction: const RhythmSecondaryButton(
            label: '次按钮',
            onPressed: null,
          ),
          primaryAction: RhythmPrimaryButton(label: '主按钮', onPressed: () {}),
        ),
      ),
    );

    expect(find.text('尾部内容'), findsOneWidget);

    final footerTop = tester.getTopLeft(find.text('页脚说明')).dy;
    final secondaryTop = tester.getTopLeft(find.text('次按钮')).dy;
    final primaryTop = tester.getTopLeft(find.text('主按钮')).dy;

    expect(footerTop, lessThan(secondaryTop));
    expect(secondaryTop, lessThan(primaryTop));
  });

  testWidgets('共享按钮允许页面传入自定义 child 承载扩展内容', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Column(
          children: [
            RhythmPrimaryButton(
              label: '主按钮',
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check),
                  SizedBox(width: 8),
                  Text('主按钮自定义内容'),
                ],
              ),
            ),
            const RhythmSecondaryButton(
              label: '次按钮',
              onPressed: null,
              child: Text('次按钮自定义内容'),
            ),
          ],
        ),
      ),
    );

    expect(find.text('主按钮自定义内容'), findsOneWidget);
    expect(find.text('次按钮自定义内容'), findsOneWidget);
    expect(find.text('主按钮'), findsNothing);
    expect(find.text('次按钮'), findsNothing);
  });

  testWidgets('深色卡片会为普通文本提供浅色默认前景', (tester) async {
    Color? inheritedTextColor;

    await tester.pumpWidget(
      MaterialApp(
        home: RhythmSurfaceCard(
          tone: RhythmSurfaceCardTone.inverse,
          child: Builder(
            builder: (context) {
              inheritedTextColor = DefaultTextStyle.of(context).style.color;
              return const Text('深色卡片正文');
            },
          ),
        ),
      ),
    );

    expect(inheritedTextColor, const Color(0xFFD7E7DA));
    expect(find.text('深色卡片正文'), findsOneWidget);
  });
}
