import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rhythm_database.g.dart';

/// 目标作息表是初始化阶段最小的结构化持久化入口。
class GoalScheduleEntries extends Table {
  /// 主键。
  IntColumn get id => integer().autoIncrement()();

  /// 睡觉时间，使用当天分钟偏移持久化。
  IntColumn get bedtimeMinutes => integer()();

  /// 起床时间，使用当天分钟偏移持久化。
  IntColumn get wakeTimeMinutes => integer()();

  /// 记录创建时间，便于后续扩展版本或迁移策略。
  DateTimeColumn get createdAt => dateTime()();
}

/// 睡眠记录表先承接 today 所需的最小闭环字段，后续再扩展同步和标签关联。
class SleepRecordEntries extends Table {
  /// 记录主键使用业务 id，便于后续和同步任务或修正链路对齐。
  TextColumn get id => text()();

  /// 这条记录归属的睡眠日期，用于 today 与 calendar 的日粒度聚合。
  DateTimeColumn get sleepDate => dateTime()();

  /// 入睡时间采用分钟偏移存储，避免页面层重复处理时分转换。
  IntColumn get bedtimeMinutes => integer()();

  /// 起床时间同样采用分钟偏移，支持跨午夜时长计算。
  IntColumn get wakeTimeMinutes => integer()();

  /// 来源先落字符串枚举，后续健康同步可在 migration 中平滑扩展。
  TextColumn get source => text()();

  /// 可信度保留为共享语义字段，避免 UI 自行发明状态。
  TextColumn get confidence => text()();

  /// 标记是否来自用户手动补录或修正。
  BoolColumn get isManuallyAdjusted => boolean()();

  /// 备注是补录链路的可选上下文，不强迫用户每次输入。
  TextColumn get note => text().nullable()();

  /// 创建时间用于同日多次修正时的最近值排序。
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// 睡前会话表先承接当晚草稿和完成态，避免 bedtime 交互只存在于内存。
class BedtimeSessionEntries extends Table {
  /// 会话按日粒度唯一，足够支撑当前睡前主路径。
  DateTimeColumn get sessionDate => dateTime()();

  /// 当前选中的三态判断允许为空，表示用户尚未明确选择。
  TextColumn get selectedChoice => text().nullable()();

  /// 入口来源用于后续区分通知、小组件和普通进入。
  TextColumn get entrySource => text()();

  /// 当前会话是否已经完成主动作。
  BoolColumn get isCompleted => boolean()();

  /// 最近更新时间用于后续恢复优先级和调试。
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {sessionDate};
}

/// Drift 数据库基线，承接 local-first 结构化数据入口。
@DriftDatabase(
  tables: [GoalScheduleEntries, SleepRecordEntries, BedtimeSessionEntries],
)
class RhythmDatabase extends _$RhythmDatabase {
  /// 创建数据库实例。
  RhythmDatabase() : super(_openConnection());

  /// 为测试提供内存或自定义执行器入口，避免业务测试依赖真实文件系统。
  RhythmDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(sleepRecordEntries);
      }
      if (from < 3) {
        await migrator.createTable(bedtimeSessionEntries);
      }
    },
  );
}

/// 为数据库提供统一生命周期管理，避免 feature 各自持有连接。
@Riverpod(keepAlive: true)
RhythmDatabase rhythmDatabase(Ref ref) {
  final database = RhythmDatabase();
  ref.onDispose(database.close);
  return database;
}

/// 打开 Drift 连接；当前初始化阶段先覆盖原生平台持久化路径与测试内存模式。
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    if (kIsWeb) {
      return NativeDatabase.memory();
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File(path.join(directory.path, 'rhythm.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
