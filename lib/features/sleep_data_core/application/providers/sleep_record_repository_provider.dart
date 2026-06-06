import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/rhythm_database.dart';
import '../../domain/repositories/sleep_record_repository.dart';
import '../../infrastructure/repositories/local_sleep_record_repository.dart';

part 'sleep_record_repository_provider.g.dart';

/// 暴露睡眠记录仓储入口，让 today、calendar、insights 共享同一条数据边界。
@riverpod
SleepRecordRepository sleepRecordRepository(Ref ref) {
  final database = ref.watch(rhythmDatabaseProvider);
  return LocalSleepRecordRepository(database);
}
