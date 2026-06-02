import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/core/presentation/widgets/rhythm_surface_card.dart';
import 'package:rhythm/features/onboarding/presentation/widgets/onboarding_welcome_step.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../support/test_app.dart';

/// 验证首次引导会按欢迎、目标作息、提醒设置顺序推进。
void main() {
  testWidgets('欢迎页继续后直接进入目标作息设置页', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    expect(find.text('今晚开始，把作息慢慢拉回你想要的节奏'), findsOneWidget);
    expect(find.text('接下来只做三件事'), findsOneWidget);
    expect(find.text('定目标时间'), findsOneWidget);
    expect(find.text('补强体验条件'), findsOneWidget);
    expect(find.text('尽快看到今日页'), findsOneWidget);
    expect(find.byType(RhythmSurfaceCard), findsNWidgets(3));

    await tester.ensureVisible(find.text('开始设置'));
    await tester.tap(find.text('开始设置'));
    await tester.pumpAndSettle();

    expect(find.text('先定一个你想靠近的作息'), findsWidgets);
    expect(find.text('今晚开始，慢慢早一点睡'), findsNothing);
    expect(find.text('把自动反馈和夜晚提醒补齐'), findsNothing);
  });

  testWidgets('完成目标作息后进入提醒设置页，跳过后直接回到今日主链路', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('开始设置'));
    await tester.tap(find.text('开始设置'));
    await tester.pumpAndSettle();

    expect(find.text('先定一个你想靠近的作息'), findsWidgets);

    await tester.ensureVisible(find.text('这样开始'));
    await tester.tap(find.text('这样开始'));
    await tester.pumpAndSettle();

    expect(find.text('把自动反馈和夜晚提醒补齐'), findsOneWidget);
    expect(find.text('先按推荐值补齐体验'), findsOneWidget);
    expect(find.text('柔和提醒'), findsOneWidget);
    expect(find.text('授权后你会得到什么'), findsOneWidget);
    expect(find.text('先手动记录'), findsWidgets);

    await tester.ensureVisible(find.text('先手动记录').last);
    await tester.tap(find.text('先手动记录').last);
    await tester.pumpAndSettle();

    expect(find.text('今日'), findsOneWidget);
    expect(find.text('把自动反馈和夜晚提醒补齐'), findsNothing);
  });

  testWidgets('英文环境下首次引导不会混入中文文案', (tester) async {
    await pumpRhythmApp(
      tester,
      onboardingCompleted: false,
      locale: const Locale('en'),
    );
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Starting tonight, bring your routine back toward the rhythm you want',
      ),
      findsOneWidget,
    );
    expect(find.text('Set target times'), findsOneWidget);
    expect(find.text('Add support conditions'), findsOneWidget);
    expect(find.text('Reach Today quickly'), findsOneWidget);
    expect(find.text('今晚开始，把作息慢慢拉回你想要的节奏'), findsNothing);

    await tester.ensureVisible(find.text('Start setup'));
    await tester.tap(find.text('Start setup'));
    await tester.pumpAndSettle();

    expect(find.text('Set the rhythm you want to move toward'), findsWidgets);
    expect(find.text('Starting tonight, shift a little earlier'), findsNothing);
    expect(find.text('先定一个你想靠近的作息'), findsNothing);
  });

  testWidgets('欢迎页组件会展示三张价值卡和主按钮', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: OnboardingWelcomeStep(onContinue: _noop)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(RhythmSurfaceCard), findsNWidgets(3));
    expect(find.text('接下来只做三件事'), findsOneWidget);
    expect(find.text('开始设置'), findsOneWidget);
  });
}

void _noop() {}
