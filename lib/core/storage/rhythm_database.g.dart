// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rhythm_database.dart';

// ignore_for_file: type=lint
class $GoalScheduleEntriesTable extends GoalScheduleEntries
    with TableInfo<$GoalScheduleEntriesTable, GoalScheduleEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalScheduleEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bedtimeMinutesMeta = const VerificationMeta(
    'bedtimeMinutes',
  );
  @override
  late final GeneratedColumn<int> bedtimeMinutes = GeneratedColumn<int>(
    'bedtime_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wakeTimeMinutesMeta = const VerificationMeta(
    'wakeTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> wakeTimeMinutes = GeneratedColumn<int>(
    'wake_time_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bedtimeMinutes,
    wakeTimeMinutes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_schedule_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalScheduleEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bedtime_minutes')) {
      context.handle(
        _bedtimeMinutesMeta,
        bedtimeMinutes.isAcceptableOrUnknown(
          data['bedtime_minutes']!,
          _bedtimeMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bedtimeMinutesMeta);
    }
    if (data.containsKey('wake_time_minutes')) {
      context.handle(
        _wakeTimeMinutesMeta,
        wakeTimeMinutes.isAcceptableOrUnknown(
          data['wake_time_minutes']!,
          _wakeTimeMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wakeTimeMinutesMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalScheduleEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalScheduleEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bedtimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bedtime_minutes'],
      )!,
      wakeTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wake_time_minutes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GoalScheduleEntriesTable createAlias(String alias) {
    return $GoalScheduleEntriesTable(attachedDatabase, alias);
  }
}

class GoalScheduleEntry extends DataClass
    implements Insertable<GoalScheduleEntry> {
  /// 主键。
  final int id;

  /// 睡觉时间，使用当天分钟偏移持久化。
  final int bedtimeMinutes;

  /// 起床时间，使用当天分钟偏移持久化。
  final int wakeTimeMinutes;

  /// 记录创建时间，便于后续扩展版本或迁移策略。
  final DateTime createdAt;
  const GoalScheduleEntry({
    required this.id,
    required this.bedtimeMinutes,
    required this.wakeTimeMinutes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bedtime_minutes'] = Variable<int>(bedtimeMinutes);
    map['wake_time_minutes'] = Variable<int>(wakeTimeMinutes);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GoalScheduleEntriesCompanion toCompanion(bool nullToAbsent) {
    return GoalScheduleEntriesCompanion(
      id: Value(id),
      bedtimeMinutes: Value(bedtimeMinutes),
      wakeTimeMinutes: Value(wakeTimeMinutes),
      createdAt: Value(createdAt),
    );
  }

  factory GoalScheduleEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalScheduleEntry(
      id: serializer.fromJson<int>(json['id']),
      bedtimeMinutes: serializer.fromJson<int>(json['bedtimeMinutes']),
      wakeTimeMinutes: serializer.fromJson<int>(json['wakeTimeMinutes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bedtimeMinutes': serializer.toJson<int>(bedtimeMinutes),
      'wakeTimeMinutes': serializer.toJson<int>(wakeTimeMinutes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GoalScheduleEntry copyWith({
    int? id,
    int? bedtimeMinutes,
    int? wakeTimeMinutes,
    DateTime? createdAt,
  }) => GoalScheduleEntry(
    id: id ?? this.id,
    bedtimeMinutes: bedtimeMinutes ?? this.bedtimeMinutes,
    wakeTimeMinutes: wakeTimeMinutes ?? this.wakeTimeMinutes,
    createdAt: createdAt ?? this.createdAt,
  );
  GoalScheduleEntry copyWithCompanion(GoalScheduleEntriesCompanion data) {
    return GoalScheduleEntry(
      id: data.id.present ? data.id.value : this.id,
      bedtimeMinutes: data.bedtimeMinutes.present
          ? data.bedtimeMinutes.value
          : this.bedtimeMinutes,
      wakeTimeMinutes: data.wakeTimeMinutes.present
          ? data.wakeTimeMinutes.value
          : this.wakeTimeMinutes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalScheduleEntry(')
          ..write('id: $id, ')
          ..write('bedtimeMinutes: $bedtimeMinutes, ')
          ..write('wakeTimeMinutes: $wakeTimeMinutes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, bedtimeMinutes, wakeTimeMinutes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalScheduleEntry &&
          other.id == this.id &&
          other.bedtimeMinutes == this.bedtimeMinutes &&
          other.wakeTimeMinutes == this.wakeTimeMinutes &&
          other.createdAt == this.createdAt);
}

class GoalScheduleEntriesCompanion extends UpdateCompanion<GoalScheduleEntry> {
  final Value<int> id;
  final Value<int> bedtimeMinutes;
  final Value<int> wakeTimeMinutes;
  final Value<DateTime> createdAt;
  const GoalScheduleEntriesCompanion({
    this.id = const Value.absent(),
    this.bedtimeMinutes = const Value.absent(),
    this.wakeTimeMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  GoalScheduleEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int bedtimeMinutes,
    required int wakeTimeMinutes,
    required DateTime createdAt,
  }) : bedtimeMinutes = Value(bedtimeMinutes),
       wakeTimeMinutes = Value(wakeTimeMinutes),
       createdAt = Value(createdAt);
  static Insertable<GoalScheduleEntry> custom({
    Expression<int>? id,
    Expression<int>? bedtimeMinutes,
    Expression<int>? wakeTimeMinutes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bedtimeMinutes != null) 'bedtime_minutes': bedtimeMinutes,
      if (wakeTimeMinutes != null) 'wake_time_minutes': wakeTimeMinutes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  GoalScheduleEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? bedtimeMinutes,
    Value<int>? wakeTimeMinutes,
    Value<DateTime>? createdAt,
  }) {
    return GoalScheduleEntriesCompanion(
      id: id ?? this.id,
      bedtimeMinutes: bedtimeMinutes ?? this.bedtimeMinutes,
      wakeTimeMinutes: wakeTimeMinutes ?? this.wakeTimeMinutes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bedtimeMinutes.present) {
      map['bedtime_minutes'] = Variable<int>(bedtimeMinutes.value);
    }
    if (wakeTimeMinutes.present) {
      map['wake_time_minutes'] = Variable<int>(wakeTimeMinutes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalScheduleEntriesCompanion(')
          ..write('id: $id, ')
          ..write('bedtimeMinutes: $bedtimeMinutes, ')
          ..write('wakeTimeMinutes: $wakeTimeMinutes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$RhythmDatabase extends GeneratedDatabase {
  _$RhythmDatabase(QueryExecutor e) : super(e);
  $RhythmDatabaseManager get managers => $RhythmDatabaseManager(this);
  late final $GoalScheduleEntriesTable goalScheduleEntries =
      $GoalScheduleEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [goalScheduleEntries];
}

typedef $$GoalScheduleEntriesTableCreateCompanionBuilder =
    GoalScheduleEntriesCompanion Function({
      Value<int> id,
      required int bedtimeMinutes,
      required int wakeTimeMinutes,
      required DateTime createdAt,
    });
typedef $$GoalScheduleEntriesTableUpdateCompanionBuilder =
    GoalScheduleEntriesCompanion Function({
      Value<int> id,
      Value<int> bedtimeMinutes,
      Value<int> wakeTimeMinutes,
      Value<DateTime> createdAt,
    });

class $$GoalScheduleEntriesTableFilterComposer
    extends Composer<_$RhythmDatabase, $GoalScheduleEntriesTable> {
  $$GoalScheduleEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bedtimeMinutes => $composableBuilder(
    column: $table.bedtimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wakeTimeMinutes => $composableBuilder(
    column: $table.wakeTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GoalScheduleEntriesTableOrderingComposer
    extends Composer<_$RhythmDatabase, $GoalScheduleEntriesTable> {
  $$GoalScheduleEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bedtimeMinutes => $composableBuilder(
    column: $table.bedtimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wakeTimeMinutes => $composableBuilder(
    column: $table.wakeTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalScheduleEntriesTableAnnotationComposer
    extends Composer<_$RhythmDatabase, $GoalScheduleEntriesTable> {
  $$GoalScheduleEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get bedtimeMinutes => $composableBuilder(
    column: $table.bedtimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wakeTimeMinutes => $composableBuilder(
    column: $table.wakeTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$GoalScheduleEntriesTableTableManager
    extends
        RootTableManager<
          _$RhythmDatabase,
          $GoalScheduleEntriesTable,
          GoalScheduleEntry,
          $$GoalScheduleEntriesTableFilterComposer,
          $$GoalScheduleEntriesTableOrderingComposer,
          $$GoalScheduleEntriesTableAnnotationComposer,
          $$GoalScheduleEntriesTableCreateCompanionBuilder,
          $$GoalScheduleEntriesTableUpdateCompanionBuilder,
          (
            GoalScheduleEntry,
            BaseReferences<
              _$RhythmDatabase,
              $GoalScheduleEntriesTable,
              GoalScheduleEntry
            >,
          ),
          GoalScheduleEntry,
          PrefetchHooks Function()
        > {
  $$GoalScheduleEntriesTableTableManager(
    _$RhythmDatabase db,
    $GoalScheduleEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalScheduleEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalScheduleEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GoalScheduleEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bedtimeMinutes = const Value.absent(),
                Value<int> wakeTimeMinutes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => GoalScheduleEntriesCompanion(
                id: id,
                bedtimeMinutes: bedtimeMinutes,
                wakeTimeMinutes: wakeTimeMinutes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bedtimeMinutes,
                required int wakeTimeMinutes,
                required DateTime createdAt,
              }) => GoalScheduleEntriesCompanion.insert(
                id: id,
                bedtimeMinutes: bedtimeMinutes,
                wakeTimeMinutes: wakeTimeMinutes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoalScheduleEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$RhythmDatabase,
      $GoalScheduleEntriesTable,
      GoalScheduleEntry,
      $$GoalScheduleEntriesTableFilterComposer,
      $$GoalScheduleEntriesTableOrderingComposer,
      $$GoalScheduleEntriesTableAnnotationComposer,
      $$GoalScheduleEntriesTableCreateCompanionBuilder,
      $$GoalScheduleEntriesTableUpdateCompanionBuilder,
      (
        GoalScheduleEntry,
        BaseReferences<
          _$RhythmDatabase,
          $GoalScheduleEntriesTable,
          GoalScheduleEntry
        >,
      ),
      GoalScheduleEntry,
      PrefetchHooks Function()
    >;

class $RhythmDatabaseManager {
  final _$RhythmDatabase _db;
  $RhythmDatabaseManager(this._db);
  $$GoalScheduleEntriesTableTableManager get goalScheduleEntries =>
      $$GoalScheduleEntriesTableTableManager(_db, _db.goalScheduleEntries);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 为数据库提供统一生命周期管理，避免 feature 各自持有连接。

@ProviderFor(rhythmDatabase)
const rhythmDatabaseProvider = RhythmDatabaseProvider._();

/// 为数据库提供统一生命周期管理，避免 feature 各自持有连接。

final class RhythmDatabaseProvider
    extends $FunctionalProvider<RhythmDatabase, RhythmDatabase, RhythmDatabase>
    with $Provider<RhythmDatabase> {
  /// 为数据库提供统一生命周期管理，避免 feature 各自持有连接。
  const RhythmDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rhythmDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rhythmDatabaseHash();

  @$internal
  @override
  $ProviderElement<RhythmDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RhythmDatabase create(Ref ref) {
    return rhythmDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RhythmDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RhythmDatabase>(value),
    );
  }
}

String _$rhythmDatabaseHash() => r'684b5f22b769948fb0e5461eb5d196bb5ef37edc';
