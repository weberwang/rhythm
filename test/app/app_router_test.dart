import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/app/rhythm_app.dart';
import 'package:rhythm/app/router/app_router.dart';
import 'package:rhythm/features/app_shell/application/providers/account_session_repository_provider.dart';
import 'package:rhythm/features/app_shell/application/providers/current_account_session_provider.dart';
import 'package:rhythm/features/app_shell/application/providers/current_entry_intent_provider.dart';
import 'package:rhythm/features/app_shell/domain/entities/account_session.dart';
import 'package:rhythm/features/app_shell/domain/entities/entry_intent.dart';
import 'package:rhythm/features/app_shell/domain/repositories/account_session_repository.dart';
import 'package:rhythm/features/bedtime/presentation/pages/bedtime_page.dart';
import 'package:rhythm/features/bedtime/application/providers/bedtime_session_repository_provider.dart';
import 'package:rhythm/features/bedtime/domain/entities/bedtime_session_record.dart';
import 'package:rhythm/features/bedtime/domain/repositories/bedtime_session_repository.dart';
import 'package:rhythm/features/onboarding_activation/application/providers/onboarding_capability_gateways.dart';
import 'package:rhythm/features/onboarding_activation/domain/entities/onboarding_draft.dart';
import 'package:rhythm/features/onboarding_activation/domain/entities/onboarding_widget_guide.dart';
import 'package:rhythm/features/onboarding_activation/domain/gateways/onboarding_health_permission_gateway.dart';
import 'package:rhythm/features/onboarding_activation/domain/gateways/onboarding_widget_guide_gateway.dart';
import 'package:rhythm/features/onboarding_activation/presentation/pages/onboarding_flow_page.dart';
import 'package:rhythm/features/profile_settings/presentation/pages/profile_settings_page.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/goal_schedule_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/sleep_record_repository_provider.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/goal_schedule.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/sleep_record.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/goal_schedule_repository.dart';
import 'package:rhythm/features/sleep_data_core/domain/repositories/sleep_record_repository.dart';
import 'package:rhythm/features/today/presentation/pages/today_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 用可控仓储隔离目标作息状态，确保路由测试只验证 guard 行为。
class _FakeGoalScheduleRepository implements GoalScheduleRepository {
  /// 创建用于测试的作息仓储。
  _FakeGoalScheduleRepository(this._schedule);

  GoalSchedule? _schedule;

  @override
  Future<GoalSchedule?> readActiveSchedule() async => _schedule;

  @override
  Future<void> saveActiveSchedule(GoalSchedule schedule) async {
    _schedule = schedule;
  }
}

/// 用空记录仓储隔离 today 首页新增的数据依赖，避免路由测试触发真实 Drift。
class _FakeSleepRecordRepository implements SleepRecordRepository {
  @override
  Future<SleepRecord?> readLatestRecord() async => null;

  @override
  Future<List<SleepRecord>> readRecentRecords({required int limit}) async {
    return const <SleepRecord>[];
  }

  @override
  Future<List<SleepRecord>> readRecordsInRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return const <SleepRecord>[];
  }

  @override
  Future<void> saveManualRecord(SleepRecord record) async {}
}

/// 用空睡前会话仓储隔离路由测试，避免 BedtimePage 构建时触发真实本地库。
class _FakeBedtimeSessionRepository implements BedtimeSessionRepository {
  @override
  Future<BedtimeSessionRecord?> readSessionForDate(DateTime sessionDate) async {
    return null;
  }

  @override
  Future<void> saveSession(BedtimeSessionRecord record) async {}
}

/// 用假的健康权限网关稳定复现 onboarding 权限步骤，不依赖真实插件环境。
class _FakeOnboardingHealthPermissionGateway
    implements OnboardingHealthPermissionGateway {
  _FakeOnboardingHealthPermissionGateway();

  int requestCount = 0;

  @override
  Future<OnboardingHealthPermissionStatus> requestSleepPermission() async {
    requestCount += 1;
    return OnboardingHealthPermissionStatus.denied;
  }
}

/// 用假的小组件网关稳定复现 widget guide 步骤，不依赖真实平台支持。
class _FakeOnboardingWidgetGuideGateway
    implements OnboardingWidgetGuideGateway {
  const _FakeOnboardingWidgetGuideGateway();

  @override
  Future<OnboardingWidgetGuide> loadGuide() async {
    return const OnboardingWidgetGuide(
      support: OnboardingWidgetGuideSupport.manualOnly,
      installedWidgetCount: 0,
      canRequestPin: false,
    );
  }
}

/// 用内存账号仓储隔离完成引导后的账号快照写入，避免路由测试依赖真实安全存储。
class _FakeAccountSessionRepository implements AccountSessionRepository {
  AppAccountSession? _session;

  @override
  Future<void> clear() async {
    _session = null;
  }

  @override
  Future<AppAccountSession?> read() async => _session;

  @override
  Future<void> save(AppAccountSession session) async {
    _session = session;
  }
}

/// 验证根路由会在启动 guard 收敛后拦截非法入口。
void main() {
  testWidgets(
    'shell routes redirect back to onboarding when setup is incomplete',
    (tester) async {
      SharedPreferences.setMockInitialValues({'onboarding_completed': false});
      final container = ProviderContainer(
        overrides: [
          goalScheduleRepositoryProvider.overrideWithValue(
            _FakeGoalScheduleRepository(null),
          ),
          bedtimeSessionRepositoryProvider.overrideWithValue(
            _FakeBedtimeSessionRepository(),
          ),
          sleepRecordRepositoryProvider.overrideWithValue(
            _FakeSleepRecordRepository(),
          ),
          currentAccountSessionProvider.overrideWith((ref) async => null),
        ],
      );

      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const RhythmApp(),
        ),
      );
      await tester.pumpAndSettle();

      final router = container.read(appRouterProvider);
      router.go(ProfileSettingsPage.routePath);
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingFlowPage), findsOneWidget);
      expect(find.byType(ProfileSettingsPage), findsNothing);
    },
  );

  testWidgets('shell ready users cannot navigate back to onboarding route', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'onboarding_completed': true});
    final container = ProviderContainer(
      overrides: [
        goalScheduleRepositoryProvider.overrideWithValue(
          _FakeGoalScheduleRepository(
            GoalSchedule(
              id: 'fixture',
              bedtimeMinutes: 23 * 60,
              wakeTimeMinutes: 7 * 60,
              createdAt: DateTime(2026, 6, 4),
            ),
          ),
        ),
        bedtimeSessionRepositoryProvider.overrideWithValue(
          _FakeBedtimeSessionRepository(),
        ),
        sleepRecordRepositoryProvider.overrideWithValue(
          _FakeSleepRecordRepository(),
        ),
        currentAccountSessionProvider.overrideWith((ref) async => null),
      ],
    );

    addTearDown(container.dispose);
    container
        .read(currentEntryIntentProvider.notifier)
        .setIntent(const EntryIntent.notification(target: 'bedtime'));

    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const RhythmApp()),
    );
    await tester.pumpAndSettle();

    final router = container.read(appRouterProvider);
    router.go(OnboardingFlowPage.routePath);
    await tester.pumpAndSettle();

    expect(find.byType(BedtimePage), findsOneWidget);
    expect(find.byType(OnboardingFlowPage), findsNothing);
  });

  testWidgets('completing onboarding enters today page', (tester) async {
    Future<void> pumpFlow() async {
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
    }

    SharedPreferences.setMockInitialValues({'onboarding_completed': false});
    final repository = _FakeGoalScheduleRepository(null);
    final accountSessionRepository = _FakeAccountSessionRepository();
    final healthPermissionGateway = _FakeOnboardingHealthPermissionGateway();
    final container = ProviderContainer(
      overrides: [
        goalScheduleRepositoryProvider.overrideWithValue(repository),
        bedtimeSessionRepositoryProvider.overrideWithValue(
          _FakeBedtimeSessionRepository(),
        ),
        sleepRecordRepositoryProvider.overrideWithValue(
          _FakeSleepRecordRepository(),
        ),
        accountSessionRepositoryProvider.overrideWithValue(
          accountSessionRepository,
        ),
        currentAccountSessionProvider.overrideWith((ref) async => null),
        onboardingHealthPermissionGatewayProvider.overrideWithValue(
          healthPermissionGateway,
        ),
        onboardingWidgetGuideGatewayProvider.overrideWithValue(
          const _FakeOnboardingWidgetGuideGateway(),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const RhythmApp()),
    );
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingFlowPage), findsOneWidget);

    await tester.tap(find.text('Start setup'));
    await pumpFlow();
    await tester.tap(find.text('Start in local-first mode'));
    await pumpFlow();
    await tester.tap(find.text('Continue'));
    await pumpFlow();
    await tester.tap(find.text('Continue'));
    await pumpFlow();
    await tester.tap(find.text('Continue'));
    await pumpFlow();
    await tester.tap(find.text('Gentle bedtime nudge'));
    await pumpFlow();
    await tester.tap(find.text('Continue'));
    await pumpFlow();
    await tester.tap(find.text('Continue'));
    await pumpFlow();
    await tester.tap(find.text('Finish setup'));
    await tester.pumpAndSettle();

    expect(find.byType(TodayPage), findsOneWidget);
    expect(find.byType(OnboardingFlowPage), findsNothing);
    expect(healthPermissionGateway.requestCount, 0);
  });

  testWidgets(
    'completing onboarding ignores pre-onboarding notification intent and still enters today page',
    (tester) async {
      Future<void> pumpFlow() async {
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
      }

      SharedPreferences.setMockInitialValues({'onboarding_completed': false});
      final repository = _FakeGoalScheduleRepository(null);
      final accountSessionRepository = _FakeAccountSessionRepository();
      final healthPermissionGateway = _FakeOnboardingHealthPermissionGateway();
      final container = ProviderContainer(
        overrides: [
          goalScheduleRepositoryProvider.overrideWithValue(repository),
          bedtimeSessionRepositoryProvider.overrideWithValue(
            _FakeBedtimeSessionRepository(),
          ),
          sleepRecordRepositoryProvider.overrideWithValue(
            _FakeSleepRecordRepository(),
          ),
          accountSessionRepositoryProvider.overrideWithValue(
            accountSessionRepository,
          ),
          currentAccountSessionProvider.overrideWith((ref) async => null),
          onboardingHealthPermissionGatewayProvider.overrideWithValue(
            healthPermissionGateway,
          ),
          onboardingWidgetGuideGatewayProvider.overrideWithValue(
            const _FakeOnboardingWidgetGuideGateway(),
          ),
        ],
      );
      addTearDown(container.dispose);
      container
          .read(currentEntryIntentProvider.notifier)
          .setIntent(const EntryIntent.notification(target: 'bedtime'));

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const RhythmApp(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingFlowPage), findsOneWidget);

      await tester.tap(find.text('Start setup'));
      await pumpFlow();
      await tester.tap(find.text('Start in local-first mode'));
      await pumpFlow();
      await tester.tap(find.text('Continue'));
      await pumpFlow();
      await tester.tap(find.text('Continue'));
      await pumpFlow();
      await tester.tap(find.text('Continue'));
      await pumpFlow();
      await tester.tap(find.text('Gentle bedtime nudge'));
      await pumpFlow();
      await tester.tap(find.text('Continue'));
      await pumpFlow();
      await tester.tap(find.text('Continue'));
      await pumpFlow();
      await tester.tap(find.text('Finish setup'));
      await tester.pumpAndSettle();

      expect(find.byType(TodayPage), findsOneWidget);
      expect(find.byType(BedtimePage), findsNothing);
      expect(healthPermissionGateway.requestCount, 0);
    },
  );

  testWidgets('skip onboarding from welcome enters today page', (tester) async {
    SharedPreferences.setMockInitialValues({'onboarding_completed': false});
    final repository = _FakeGoalScheduleRepository(null);
    final accountSessionRepository = _FakeAccountSessionRepository();
    final container = ProviderContainer(
      overrides: [
        goalScheduleRepositoryProvider.overrideWithValue(repository),
        bedtimeSessionRepositoryProvider.overrideWithValue(
          _FakeBedtimeSessionRepository(),
        ),
        sleepRecordRepositoryProvider.overrideWithValue(
          _FakeSleepRecordRepository(),
        ),
        accountSessionRepositoryProvider.overrideWithValue(
          accountSessionRepository,
        ),
        currentAccountSessionProvider.overrideWith((ref) async => null),
        onboardingHealthPermissionGatewayProvider.overrideWithValue(
          _FakeOnboardingHealthPermissionGateway(),
        ),
        onboardingWidgetGuideGatewayProvider.overrideWithValue(
          const _FakeOnboardingWidgetGuideGateway(),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const RhythmApp()),
    );
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingFlowPage), findsOneWidget);

    await tester.tap(find.text('Skip onboarding'));
    await tester.pumpAndSettle();

    expect(find.byType(TodayPage), findsOneWidget);
    expect(find.byType(OnboardingFlowPage), findsNothing);
  });
}
