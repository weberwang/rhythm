import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sleep_records/application/sleep_record_sync_controller.dart';
import 'package:rhythm/features/sleep_records/presentation/widgets/sleep_records_sync_card.dart';
import 'package:rhythm/l10n/app_localizations.dart';

/// 验证同步状态卡会展示最近同步时间和失败原因摘要。
void main() {
  testWidgets('同步成功时展示最近同步时间摘要', (tester) async {
    await tester.pumpWidget(
      _buildTestApp(
        child: SleepRecordsSyncCard(
          syncState: SleepRecordSyncState(
            status: SleepRecordSyncStatus.success,
            syncedCount: 3,
            lastSyncedAt: DateTime.utc(2026, 5, 24, 20),
          ),
          onPrimaryPressed: _noop,
          onSecondaryPressed: _noop,
        ),
      ),
    );

    expect(find.text('最近同步'), findsOneWidget);
    expect(find.textContaining('20:00'), findsOneWidget);
  });

  testWidgets('同步失败时展示失败原因摘要', (tester) async {
    await tester.pumpWidget(
      _buildTestApp(
        child: SleepRecordsSyncCard(
          syncState: const SleepRecordSyncState(
            status: SleepRecordSyncStatus.error,
            failureReason: 'sync_failed',
          ),
          onPrimaryPressed: _noop,
          onSecondaryPressed: _noop,
        ),
      ),
    );

    expect(find.text('失败原因'), findsOneWidget);
    expect(find.text('健康数据读取失败，请稍后重试。'), findsOneWidget);
  });

  testWidgets('同步状态卡占满手机内容区宽度', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _buildTestApp(
        child: SleepRecordsSyncCard(
          syncState: const SleepRecordSyncState(
            status: SleepRecordSyncStatus.idle,
          ),
          onPrimaryPressed: _noop,
          onSecondaryPressed: _noop,
        ),
      ),
    );

    final card = find.byType(Card).first;

    expect(tester.getSize(card).width, closeTo(390, 0.1));
  });
}

/// 构造带本地化上下文的最小测试壳。
Widget _buildTestApp({required Widget child}) {
  return MaterialApp(
    locale: const Locale('zh'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}

/// 占位回调，供纯展示测试复用。
void _noop() {}
