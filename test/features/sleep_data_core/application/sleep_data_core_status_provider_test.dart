import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhythm/features/sleep_data_core/application/providers/sleep_data_core_status_provider.dart';
import 'package:rhythm/features/sleep_data_core/domain/entities/sleep_data_core_status.dart';

/// 验证共享状态契约会把来源、同步与时区语义聚合成统一快照。
void main() {
  test('sleepDataCoreStatus aggregates shared state semantics', () {
    final container = ProviderContainer(
      overrides: [
        sleepSourceConfidenceProvider.overrideWithValue(
          SleepSourceConfidence.partial,
        ),
        sleepSyncStatusProvider.overrideWithValue(
          SleepSyncStatus.failedRecoverable,
        ),
        sleepTimezoneContextProvider.overrideWithValue(
          SleepTimezoneContext.shiftPending,
        ),
      ],
    );

    addTearDown(container.dispose);

    final status = container.read(sleepDataCoreStatusProvider);

    expect(status.sourceConfidence, SleepSourceConfidence.partial);
    expect(status.syncStatus, SleepSyncStatus.failedRecoverable);
    expect(status.timezoneContext, SleepTimezoneContext.shiftPending);
  });
}
