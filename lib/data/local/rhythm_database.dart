import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'rhythm_database.g.dart';

/// 目标作息表，持久化用户设定的核心作息基准。
class GoalSchedules extends Table {
  /// 目标记录唯一标识。
  TextColumn get id => text()();

  /// 目标入睡时间，按 0 点起分钟数存储，避免时区转换时丢失业务语义。
  IntColumn get targetBedtimeMinutes => integer()();

  /// 目标起床时间。
  IntColumn get targetWakeMinutes => integer()();

  /// 熬夜阈值分钟数。
  IntColumn get lateThresholdMinutes => integer()();

  /// 一天起始时间分钟数。
  IntColumn get dayStartMinutes => integer()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

/// 睡眠记录表，保留核心字段供后续同步和统计使用。
class SleepRecords extends Table {
  /// 睡眠记录唯一标识。
  TextColumn get id => text()();

  /// 归属日期，统一保存为 UTC 0 点方便范围查询。
  DateTimeColumn get recordDate => dateTime()();

  /// 实际入睡时间。
  DateTimeColumn get fellAsleepAt => dateTime()();

  /// 实际起床时间。
  DateTimeColumn get wokeUpAt => dateTime()();

  /// 数据来源枚举名。
  TextColumn get source => text()();

  /// 数据可信度枚举名。
  TextColumn get confidence => text()();

  /// 记录时区。
  TextColumn get timezone => text()();

  /// 是否已被用户手动修正。
  BoolColumn get isUserEdited => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

/// 睡前会话表，记录睡前模式的最小行为数据。
class BedtimeSessions extends Table {
  /// 会话唯一标识。
  TextColumn get id => text()();

  /// 会话开始时间。
  DateTimeColumn get startedAt => dateTime()();

  /// 会话完成时间。
  DateTimeColumn get completedAt => dateTime().nullable()();

  /// 进入来源。
  TextColumn get entryPoint => text()();

  /// 距离目标入睡时间的分钟差。
  IntColumn get minutesToTarget => integer()();

  /// 睡前状态。
  TextColumn get status => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

/// Rhythm 本地数据库，作为后续持久化和同步的统一入口。
@DriftDatabase(tables: [GoalSchedules, SleepRecords, BedtimeSessions])
class RhythmDatabase extends _$RhythmDatabase {
  RhythmDatabase([QueryExecutor? executor])
    : super(executor ?? NativeDatabase.memory());

  /// 当前数据库 schema 版本。
  @override
  int get schemaVersion => 1;
}

/// 目标作息仓储接口，隔离页面与存储实现。
abstract interface class GoalScheduleStore {
  /// 保存最新的目标作息设置。
  Future<void> saveGoalSchedule({
    required String id,
    required int targetBedtimeMinutes,
    required int targetWakeMinutes,
    required int lateThresholdMinutes,
    required int dayStartMinutes,
  });
}
