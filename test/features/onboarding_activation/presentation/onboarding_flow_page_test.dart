import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/features/onboarding_activation/application/providers/onboarding_capability_gateways.dart';
import 'package:rhythm/features/onboarding_activation/domain/entities/onboarding_account_connection_result.dart';
import 'package:rhythm/features/onboarding_activation/domain/entities/onboarding_draft.dart';
import 'package:rhythm/features/onboarding_activation/domain/entities/onboarding_widget_guide.dart';
import 'package:rhythm/features/onboarding_activation/domain/gateways/onboarding_account_gateway.dart';
import 'package:rhythm/features/onboarding_activation/domain/gateways/onboarding_health_permission_gateway.dart';
import 'package:rhythm/features/onboarding_activation/domain/gateways/onboarding_widget_guide_gateway.dart';
import 'package:rhythm/features/onboarding_activation/presentation/pages/onboarding_flow_page.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 用假的小组件网关锁定第 6 步展示，不依赖真实平台能力。
class _FakeOnboardingWidgetGuideGateway implements OnboardingWidgetGuideGateway {
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

/// 用假的健康权限网关锁定权限步骤，不依赖真实设备插件。
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

/// 用假的账号网关稳定 entry step 测试，不依赖真实登录 SDK。
class _FakeOnboardingAccountGateway implements OnboardingAccountGateway {
  const _FakeOnboardingAccountGateway();

  @override
  Future<OnboardingAccountConnectionResult> signIn(
    OnboardingAccountProvider provider,
  ) async {
    return OnboardingAccountConnectionResult(
      provider: provider,
      status: OnboardingAccountConnectionStatus.success,
      displayName: 'Jamie',
    );
  }
}

/// 验证 onboarding 首屏已从初始化占位页升级为真实激活入口。
void main() {
  testWidgets(
    'onboarding flow reaches widget guide before completion',
    (tester) async {
      Future<void> pumpFlow() async {
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
      }

      final healthPermissionGateway = _FakeOnboardingHealthPermissionGateway();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            onboardingAccountGatewayProvider.overrideWithValue(
              const _FakeOnboardingAccountGateway(),
            ),
            onboardingHealthPermissionGatewayProvider.overrideWithValue(
              healthPermissionGateway,
            ),
            onboardingWidgetGuideGatewayProvider.overrideWithValue(
              const _FakeOnboardingWidgetGuideGateway(),
            ),
          ],
          child: MaterialApp(
            locale: const Locale('zh'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const OnboardingFlowPage(),
          ),
        ),
      );
      await pumpFlow();

      expect(find.text('欢迎使用 Rhythm'), findsOneWidget);
      expect(find.text('第 1 步 / 7'), findsOneWidget);
      expect(find.text('开始设置'), findsOneWidget);

      await tester.tap(find.text('开始设置'));
      await pumpFlow();

      expect(find.text('选择进入方式'), findsOneWidget);
      expect(find.text('第 2 步 / 7'), findsOneWidget);
      expect(find.text('使用 Apple 登录'), findsOneWidget);
      expect(find.text('使用 Google 登录'), findsOneWidget);

      await tester.tap(find.text('先本地开始'));
      await pumpFlow();
      await tester.tap(find.text('继续设置'));
      await pumpFlow();

      expect(find.text('先理解价值，再决定是否授权'), findsOneWidget);

      await tester.tap(find.text('继续设置'));
      await pumpFlow();
      expect(healthPermissionGateway.requestCount, 0);

      await tester.tap(find.text('继续设置'));
      await pumpFlow();

      await tester.tap(find.text('先用轻提醒'));
      await pumpFlow();
      await tester.tap(find.text('继续设置'));
      await pumpFlow();

      expect(find.text('把 Rhythm 放到桌面，回到今晚更快'), findsOneWidget);
      expect(find.text('第 6 步 / 7'), findsOneWidget);

      await tester.tap(find.text('继续设置'));
      await pumpFlow();

      expect(find.text('你的首晚准备已就绪'), findsOneWidget);
      expect(find.text('第 7 步 / 7'), findsOneWidget);
    },
  );

  testWidgets('welcome step exposes skip action', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          onboardingAccountGatewayProvider.overrideWithValue(
            const _FakeOnboardingAccountGateway(),
          ),
          onboardingHealthPermissionGatewayProvider.overrideWithValue(
            _FakeOnboardingHealthPermissionGateway(),
          ),
          onboardingWidgetGuideGatewayProvider.overrideWithValue(
            const _FakeOnboardingWidgetGuideGateway(),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const OnboardingFlowPage(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('跳过引导'), findsOneWidget);
  });
}
