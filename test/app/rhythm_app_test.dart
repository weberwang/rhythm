import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/goal_schedule/domain/repositories/goal_schedule_settings_repository.dart';
import 'package:rhythm/features/sleep_records/application/effective_sleep_record_provider.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';

import '../support/test_app.dart';

/// 验证根应用在不同首次引导状态下维持既有主题与主导航行为。
void main() {
  testWidgets('英文环境下首页和底部导航文案使用国际化资源', (tester) async {
    await pumpRhythmApp(
      tester,
      onboardingCompleted: true,
      locale: const Locale('en'),
      overrides: _rootReadyOverrides,
    );
    await tester.pumpAndSettle();

    expect(find.text('Today'), findsWidgets);
    expect(find.text('Calendar'), findsOneWidget);
    expect(find.text('There is no record from last night yet'), findsOneWidget);
    await tester.tap(find.text('Bedtime'));
    await tester.pumpAndSettle();
    expect(find.text('Bedtime mode'), findsOneWidget);
  });

  testWidgets('应用同时挂载亮色和暗色主题并跟随系统', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: true);

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(materialApp.theme, isNotNull);
    expect(materialApp.darkTheme, isNotNull);
    expect(materialApp.themeMode, ThemeMode.system);
    expect(materialApp.darkTheme!.brightness, Brightness.dark);
    expect(
      materialApp.darkTheme!.scaffoldBackgroundColor,
      isNot(equals(materialApp.theme!.scaffoldBackgroundColor)),
    );
  });

  testWidgets('首次打开默认进入引导流', (tester) async {
    await pumpRhythmApp(tester, onboardingCompleted: false);
    await tester.pumpAndSettle();

    expect(find.text('欢迎使用 Rhythm'), findsOneWidget);
  });

  testWidgets('完成引导后展示五个一级模块并默认进入今日页', (tester) async {
    await pumpRhythmApp(
      tester,
      onboardingCompleted: true,
      overrides: _rootReadyOverrides,
    );
    await tester.pumpAndSettle();

    expect(find.text('今日'), findsWidgets);
    expect(find.text('日历'), findsOneWidget);
    expect(find.text('睡前'), findsOneWidget);
    expect(find.text('洞察'), findsOneWidget);
    expect(find.text('我的'), findsOneWidget);
    expect(find.text('昨晚还没有记录'), findsOneWidget);
  });

  testWidgets('点击底部模块后切换到对应页面', (tester) async {
    await pumpRhythmApp(
      tester,
      onboardingCompleted: true,
      overrides: _rootReadyOverrides,
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('日历'));
    await tester.pumpAndSettle();

    expect(find.text('颜色不是坏消息，而是你与目标时间的距离。'), findsOneWidget);
    expect(find.text('本月还没有可用节律样本。先记录几天，再回来看走势。'), findsOneWidget);

    await tester.tap(find.text('睡前'));
    await tester.pumpAndSettle();

    expect(find.text('睡前模式'), findsOneWidget);
  });

  testWidgets('点击我的后能进入阶段八的我的页', (tester) async {
    await pumpRhythmApp(
      tester,
      onboardingCompleted: true,
      overrides: _rootReadyOverrides,
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('我的'));
    await tester.pumpAndSettle();

    expect(find.text('匿名用户'), findsOneWidget);
    expect(find.text('目标作息设置'), findsOneWidget);
    expect(find.text('桌面存在感'), findsOneWidget);
  });
}

const _settings = GoalScheduleSettings(
  targetBedtimeMinutes: 23 * 60 + 30,
  targetWakeMinutes: 7 * 60 + 30,
  lateThresholdMinutes: 30,
  dayStartMinutes: 4 * 60,
);

/// 为根应用测试提供固定目标作息，避免阶段六页面被缺省空态抢占。
class _FakeGoalScheduleSettingsRepository
    extends GoalScheduleSettingsRepository {
  _FakeGoalScheduleSettingsRepository(this._settings);

  final GoalScheduleSettings? _settings;

  @override
  Future<GoalScheduleSettings?> read() async => _settings;

  @override
  Future<void> save(GoalScheduleSettings settings) async {}
}

final List<dynamic> _rootReadyOverrides = [
  goalScheduleSettingsRepositoryProvider.overrideWithValue(
    _FakeGoalScheduleSettingsRepository(_settings),
  ),
  recentEffectiveSleepRecordsProvider.overrideWith(
    (ref) async => const <EffectiveSleepRecord>[],
  ),
  healthPlatformStateProvider.overrideWith(
    (ref) async => HealthPlatformState.iosAvailable(),
  ),
];
