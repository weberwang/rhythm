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

/// Drift 数据库基线，承接 local-first 结构化数据入口。
@DriftDatabase(tables: [GoalScheduleEntries])
class RhythmDatabase extends _$RhythmDatabase {
  /// 创建数据库实例。
  RhythmDatabase() : super(_openConnection());

  /// 为测试提供内存或自定义执行器入口，避免业务测试依赖真实文件系统。
  RhythmDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
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
