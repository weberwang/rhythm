import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/rhythm_database.dart';
import '../../domain/repositories/bedtime_session_repository.dart';
import '../../infrastructure/repositories/local_bedtime_session_repository.dart';

part 'bedtime_session_repository_provider.g.dart';

/// 暴露睡前会话仓储，让 bedtime 控制器只通过应用层消费持久化边界。
@riverpod
BedtimeSessionRepository bedtimeSessionRepository(Ref ref) {
  final database = ref.watch(rhythmDatabaseProvider);
  return LocalBedtimeSessionRepository(database);
}
