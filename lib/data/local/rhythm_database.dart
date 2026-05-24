import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_confidence.dart';
import 'package:rhythm/features/sleep_records/domain/sleep_record_source.dart';

part 'rhythm_database.g.dart';

/// 睡眠记录表，承载原始记录、手动补录和用户修正结果。
@DataClassName('SleepRecordEntry')
class SleepRecords extends Table {
  /// 记录主键，统一使用业务侧生成的稳定 id。
  TextColumn get id => text()();

  /// 业务归属日，按项目定义的一天起始时间归档。
  DateTimeColumn get recordDate => dateTime()();

  /// 实际入睡时间。
  DateTimeColumn get fellAsleepAt => dateTime()();

  /// 实际起床时间。
  DateTimeColumn get wokeUpAt => dateTime()();

  /// 睡眠时长，单位为分钟。
  IntColumn get durationMinutes => integer()();

  /// 记录来源枚举。
  TextColumn get source => textEnum<SleepRecordSource>()();

  /// 记录可信度枚举。
  TextColumn get confidence => textEnum<SleepRecordConfidence>()();

  /// 记录发生时所在时区。
  TextColumn get timezone => text()();

  /// 是否属于用户编辑结果。
  BoolColumn get isUserEdited => boolean()();

  /// 若当前记录修正了原始系统记录，则保留被修正记录主键。
  TextColumn get sourceRecordId => text().nullable()();

  /// 创建时间。
  DateTimeColumn get createdAt => dateTime()();

  /// 更新时间。
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// 晚睡原因标签表，按日期保存最终标签集合。
@DataClassName('SleepDelayTagEntry')
class SleepDelayTags extends Table {
  /// 业务归属日，作为晚睡标签主键。
  DateTimeColumn get recordDate => dateTime()();

  /// 该日期下最终保存的标签 JSON 数组。
  TextColumn get tagsJson => text()();

  /// 更新时间，便于后续同步或冲突判断。
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {recordDate};
}

@DriftDatabase(tables: [SleepRecords, SleepDelayTags])
class RhythmDatabase extends _$RhythmDatabase {
  /// 创建数据库实例。
  RhythmDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// 创建内存数据库实例，供测试和轻量运行环境使用。
  RhythmDatabase.inMemory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (migrator) async {
          await migrator.createAll();
        },
      );
}

/// 提供全局数据库实例，供结构化本地数据仓储共享连接。
final rhythmDatabaseProvider = Provider<RhythmDatabase>((ref) {
  final database = RhythmDatabase();
  ref.onDispose(database.close);
  return database;
});

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await _resolveDatabaseDirectory();
    final file = File(path.join(directory.path, 'rhythm.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

Future<Directory> _resolveDatabaseDirectory() async {
  try {
    return await getApplicationDocumentsDirectory();
  } on MissingPluginException {
    return Directory.systemTemp.createTemp('rhythm_db_');
  }
}
