import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/app/theme/app_theme.dart';
import 'package:rhythm/features/bedtime/application/bedtime_controller.dart';
import 'package:rhythm/features/bedtime/application/bedtime_view_state.dart';
import 'package:rhythm/features/bedtime/domain/bedtime_action.dart';
import 'package:rhythm/features/bedtime/domain/bedtime_status.dart';
import 'package:rhythm/features/bedtime/presentation/bedtime_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';
import 'package:rhythm/shared/presentation/theme/rhythm_theme_extensions.dart';

/// 验证睡前页根据控制器状态渲染倒计时、状态选择和动作建议。
void main() {
  Future<void> pumpPage(
    WidgetTester tester, {
    required BedtimeViewState state,
    Locale locale = const Locale('zh'),
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          bedtimeControllerProvider.overrideWith(
            () => _FakeBedtimeController(state),
          ),
        ],
        child: MaterialApp(
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: BedtimePage()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('ready 状态显示倒计时 hero 和三种状态', (tester) async {
    await pumpPage(tester, state: _readyState());

    expect(find.text('距离目标入睡还有 45 分钟'), findsOneWidget);
    expect(find.text('现在还来得及。你不需要一次做很多，只要先让今晚少拖一点点。'), findsOneWidget);
    expect(find.text('准备睡觉'), findsOneWidget);
    expect(find.text('还想拖一会儿'), findsOneWidget);
    expect(find.text('今晚大概率会晚睡'), findsNothing);
  });

  testWidgets('ready 状态显示当前建议动作', (tester) async {
    await pumpPage(
      tester,
      state: _readyState(
        selectedStatus: BedtimeStatus.readyToSleep,
        actions: const <BedtimeAction>[
          BedtimeAction(
            type: BedtimeActionType.dimLights,
            analyticsName: 'dim_lights',
            priority: 0,
          ),
        ],
      ),
    );

    expect(find.text('先把灯光收暗一点'), findsOneWidget);
  });

  testWidgets('动作建议卡占满手机内容区宽度', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await pumpPage(tester, state: _readyState());

    final card = find.ancestor(
      of: find.text('下一步先轻一点'),
      matching: find.byType(Card),
    );

    expect(tester.getSize(card).width, closeTo(350, 0.1));
  });

  testWidgets('goalMissing 状态显示去设置目标空态', (tester) async {
    await pumpPage(
      tester,
      state: const BedtimeViewState(status: BedtimeViewStatus.goalMissing),
    );

    expect(find.text('还没有设置今晚目标'), findsOneWidget);
    expect(find.text('去设置目标作息'), findsOneWidget);
  });

  testWidgets('likelyLate 状态改为警示条而不是第三个同级选项', (tester) async {
    await pumpPage(
      tester,
      state: _readyState(
        selectedStatus: BedtimeStatus.likelyLate,
        actions: const <BedtimeAction>[
          BedtimeAction(
            type: BedtimeActionType.planRecoveryTomorrow,
            analyticsName: 'plan_recovery_tomorrow',
            priority: 0,
          ),
        ],
      ),
    );

    expect(find.text('准备睡觉'), findsOneWidget);
    expect(find.text('还想拖一会儿'), findsOneWidget);
    expect(find.text('今晚大概率会晚睡'), findsOneWidget);
    expect(find.text('给明早留一个轻恢复动作'), findsOneWidget);
  });

  testWidgets('英文环境下 hero 和趋势卡使用英文文案', (tester) async {
    await pumpPage(tester, locale: const Locale('en'), state: _readyState());

    expect(find.text('45 minutes until your target bedtime'), findsOneWidget);
    expect(
      find.text(
        'There is still time tonight. You do not need to do a lot at once, only make tonight drag a little less.',
      ),
      findsOneWidget,
    );
    expect(find.text('Last 7 days'), findsOneWidget);
    expect(find.text('现在'), findsNothing);
  });

  testWidgets('暗色主题下睡前页状态卡和选中胶囊使用主题色', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          bedtimeControllerProvider.overrideWith(
            () => _FakeBedtimeController(_readyState()),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: ThemeMode.dark,
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: BedtimePage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final statusCard = tester.widget<Card>(
      find.byKey(const Key('bedtime-status-card')),
    );
    expect(
      statusCard.color,
      AppTheme.dark().colorScheme.surface.withValues(alpha: 0.9),
    );

    final selectedPill = tester.widget<Ink>(
      find.byKey(const Key('bedtime-status-pill-readyToSleep')),
    );
    final selectedDecoration = selectedPill.decoration! as BoxDecoration;
    expect(
      selectedDecoration.color,
      AppTheme.dark()
          .extension<RhythmChipThemeExtension>()!
          .selectedBackgroundColor,
    );
  });

  testWidgets('暗色主题下睡前 hero 退回低对比表层而不是品牌渐变', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          bedtimeControllerProvider.overrideWith(
            () => _FakeBedtimeController(_readyState()),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: ThemeMode.dark,
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: BedtimePage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final heroContainer = tester.widget<Container>(
      find.byKey(const Key('bedtime-hero-card')),
    );
    final decoration = heroContainer.decoration! as BoxDecoration;

    expect(
      decoration.color,
      AppTheme.dark().colorScheme.surfaceContainerHighest,
    );
    expect(decoration.gradient, isNull);
  });
}

BedtimeViewState _readyState({
  BedtimeStatus? selectedStatus,
  List<BedtimeAction> actions = const <BedtimeAction>[
    BedtimeAction(
      type: BedtimeActionType.dimLights,
      analyticsName: 'dim_lights',
      priority: 0,
    ),
    BedtimeAction(
      type: BedtimeActionType.putPhoneAway,
      analyticsName: 'put_phone_away',
      priority: 1,
    ),
  ],
}) {
  return BedtimeViewState(
    status: BedtimeViewStatus.ready,
    sessionId: 'session-1',
    now: DateTime(2026, 5, 24, 22, 45),
    targetBedtime: DateTime(2026, 5, 24, 23, 30),
    minutesUntilTarget: 45,
    progress: 0,
    selectedStatus: selectedStatus,
    recommendedStatus: BedtimeStatus.readyToSleep,
    actions: actions,
  );
}

/// 提供可控的假控制器，避免页面测试依赖真实业务装配。
class _FakeBedtimeController extends BedtimeController {
  _FakeBedtimeController(this._state);

  final BedtimeViewState _state;

  @override
  Future<BedtimeViewState> build() async {
    return _state;
  }
}
