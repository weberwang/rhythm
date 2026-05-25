import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/goal_schedule/application/goal_schedule_providers.dart';
import 'package:rhythm/features/goal_schedule/domain/goal_schedule_settings.dart';
import 'package:rhythm/features/goal_schedule/domain/repositories/goal_schedule_settings_repository.dart';
import 'package:rhythm/features/goal_schedule/presentation/goal_schedule_settings_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证目标作息编辑页会加载当前设置并允许保存。
void main() {
  testWidgets('目标作息编辑页展示标题并允许保存当前设置', (tester) async {
    final repository = _FakeGoalScheduleSettingsRepository(
      const GoalScheduleSettings(
        targetBedtimeMinutes: 23 * 60 + 30,
        targetWakeMinutes: 7 * 60 + 30,
        lateThresholdMinutes: 30,
        dayStartMinutes: 4 * 60,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          goalScheduleSettingsRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: GoalScheduleSettingsPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('微调你的参考线'), findsOneWidget);
    expect(find.text('保存修改'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

    await tester.tap(find.text('保存修改'));
    await tester.pumpAndSettle();

    expect(repository.savedSettings, isNotNull);
  });
}

/// 提供目标作息设置测试仓储，便于断言二级页保存动作是否真正落到仓储层。
class _FakeGoalScheduleSettingsRepository
    extends GoalScheduleSettingsRepository {
  _FakeGoalScheduleSettingsRepository(this._readSettings);

  final GoalScheduleSettings? _readSettings;
  GoalScheduleSettings? savedSettings;

  @override
  Future<GoalScheduleSettings?> read() async => _readSettings;

  @override
  Future<void> save(GoalScheduleSettings settings) async {
    savedSettings = settings;
  }
}
