import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/storage/rhythm_database.dart';
import '../../domain/repositories/goal_schedule_repository.dart';
import '../../infrastructure/repositories/local_goal_schedule_repository.dart';

part 'goal_schedule_repository_provider.g.dart';

/// 统一暴露目标作息仓储实现，后续页面只通过应用层消费该依赖。
@Riverpod(keepAlive: true)
GoalScheduleRepository goalScheduleRepository(Ref ref) {
  final database = ref.watch(rhythmDatabaseProvider);
  return LocalGoalScheduleRepository(database);
}
