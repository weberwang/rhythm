import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/profile/presentation/data_access_page.dart';
import 'package:rhythm/features/sleep_records/application/effective_sleep_record_provider.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_providers.dart';
import 'package:rhythm/features/sleep_records/data/health_permission_gateway.dart';
import 'package:rhythm/features/sleep_records/domain/effective_sleep_record.dart';
import 'package:rhythm/features/sleep_records/domain/health_platform_state.dart';
import 'package:rhythm/l10n/app_localizations.dart';

import '../../../support/sleep_records_test_doubles.dart';

/// 验证数据接入与权限页会展示健康接入状态、主操作和来源说明。
void main() {
  testWidgets('数据接入页展示接入状态、主操作和来源说明', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          healthPlatformStateProvider.overrideWith(
            (ref) async => HealthPlatformState.iosAvailable(),
          ),
          recentEffectiveSleepRecordsProvider.overrideWith(
            (ref) async => const <EffectiveSleepRecord>[],
          ),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: DataAccessPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('健康数据接入状态'), findsOneWidget);
    expect(find.text('重新授权'), findsOneWidget);
    expect(find.text('改用手动模式'), findsOneWidget);
    expect(find.text('来源与可信度'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
  });

  testWidgets('重新授权后会刷新为最新健康接入状态', (tester) async {
    final gateway = TestHealthPermissionGateway(
      platformState: HealthPlatformState.iosPermissionRequired(),
      requestAccessResult: HealthPlatformState.iosAvailable(),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          healthPermissionGatewayProvider.overrideWith(
            (ref) => gateway as HealthPermissionGateway,
          ),
          recentEffectiveSleepRecordsProvider.overrideWith(
            (ref) async => const <EffectiveSleepRecord>[],
          ),
        ],
        child: MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: DataAccessPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('需要重新授权'), findsOneWidget);

    await tester.tap(find.text('重新授权'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(gateway.accessRequested, isTrue);
    expect(find.text('HealthKit 已连接'), findsOneWidget);
    expect(find.text('需要重新授权'), findsNothing);
  });
}
