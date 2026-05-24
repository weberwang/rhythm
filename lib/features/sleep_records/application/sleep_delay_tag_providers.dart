import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhythm/data/local/rhythm_database.dart';
import 'package:rhythm/features/sleep_records/data/drift_sleep_delay_tag_repository.dart';
import 'package:rhythm/features/sleep_records/domain/repositories/sleep_delay_tag_repository.dart';

/// 提供阶段六原因标签仓储。
final sleepDelayTagRepositoryProvider = Provider<SleepDelayTagRepository>((ref) {
  return DriftSleepDelayTagRepository(
    ref.watch(rhythmDatabaseProvider),
  );
});
