import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/bedtime/application/bedtime_controller.dart';
import 'package:rhythm/features/bedtime/application/bedtime_view_state.dart';
import 'package:rhythm/features/bedtime/domain/bedtime_action.dart';
import 'package:rhythm/features/bedtime/domain/bedtime_status.dart';
import 'package:rhythm/features/bedtime/presentation/bedtime_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证睡前页根据控制器状态渲染倒计时、状态选择和动作建议。
void main() {
  Future<void> pumpPage(
    WidgetTester tester, {
    required BedtimeViewState state,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          bedtimeControllerProvider.overrideWith(() => _FakeBedtimeController(state)),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: BedtimePage()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('ready 状态显示当前时间、倒计时和三种状态', (tester) async {
    await pumpPage(
      tester,
      state: _readyState(),
    );

    expect(find.text('睡前模式'), findsOneWidget);
    expect(find.text('距离目标入睡还有 45 分钟'), findsOneWidget);
    expect(find.text('准备睡觉'), findsOneWidget);
    expect(find.text('还想拖一会儿'), findsOneWidget);
    expect(find.text('今晚大概率会晚睡'), findsOneWidget);
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

  testWidgets('goalMissing 状态显示去设置目标空态', (tester) async {
    await pumpPage(
      tester,
      state: const BedtimeViewState(
        status: BedtimeViewStatus.goalMissing,
      ),
    );

    expect(find.text('还没有设置今晚目标'), findsOneWidget);
    expect(find.text('去设置目标作息'), findsOneWidget);
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
