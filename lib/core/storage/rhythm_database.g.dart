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

class $SleepRecordEntriesTable extends SleepRecordEntries
    with TableInfo<$SleepRecordEntriesTable, SleepRecordEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepRecordEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sleepDateMeta = const VerificationMeta(
    'sleepDate',
  );
  @override
  late final GeneratedColumn<DateTime> sleepDate = GeneratedColumn<DateTime>(
    'sleep_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<String> confidence = GeneratedColumn<String>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isManuallyAdjustedMeta =
      const VerificationMeta('isManuallyAdjusted');
  @override
  late final GeneratedColumn<bool> isManuallyAdjusted = GeneratedColumn<bool>(
    'is_manually_adjusted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_manually_adjusted" IN (0, 1))',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    sleepDate,
    bedtimeMinutes,
    wakeTimeMinutes,
    source,
    confidence,
    isManuallyAdjusted,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_record_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepRecordEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sleep_date')) {
      context.handle(
        _sleepDateMeta,
        sleepDate.isAcceptableOrUnknown(data['sleep_date']!, _sleepDateMeta),
      );
    } else if (isInserting) {
      context.missing(_sleepDateMeta);
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
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('is_manually_adjusted')) {
      context.handle(
        _isManuallyAdjustedMeta,
        isManuallyAdjusted.isAcceptableOrUnknown(
          data['is_manually_adjusted']!,
          _isManuallyAdjustedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isManuallyAdjustedMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
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
  SleepRecordEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepRecordEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sleepDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sleep_date'],
      )!,
      bedtimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bedtime_minutes'],
      )!,
      wakeTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wake_time_minutes'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}confidence'],
      )!,
      isManuallyAdjusted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_manually_adjusted'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SleepRecordEntriesTable createAlias(String alias) {
    return $SleepRecordEntriesTable(attachedDatabase, alias);
  }
}

class SleepRecordEntry extends DataClass
    implements Insertable<SleepRecordEntry> {
  /// 记录主键使用业务 id，便于后续和同步任务或修正链路对齐。
  final String id;

  /// 这条记录归属的睡眠日期，用于 today 与 calendar 的日粒度聚合。
  final DateTime sleepDate;

  /// 入睡时间采用分钟偏移存储，避免页面层重复处理时分转换。
  final int bedtimeMinutes;

  /// 起床时间同样采用分钟偏移，支持跨午夜时长计算。
  final int wakeTimeMinutes;

  /// 来源先落字符串枚举，后续健康同步可在 migration 中平滑扩展。
  final String source;

  /// 可信度保留为共享语义字段，避免 UI 自行发明状态。
  final String confidence;

  /// 标记是否来自用户手动补录或修正。
  final bool isManuallyAdjusted;

  /// 备注是补录链路的可选上下文，不强迫用户每次输入。
  final String? note;

  /// 创建时间用于同日多次修正时的最近值排序。
  final DateTime createdAt;
  const SleepRecordEntry({
    required this.id,
    required this.sleepDate,
    required this.bedtimeMinutes,
    required this.wakeTimeMinutes,
    required this.source,
    required this.confidence,
    required this.isManuallyAdjusted,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sleep_date'] = Variable<DateTime>(sleepDate);
    map['bedtime_minutes'] = Variable<int>(bedtimeMinutes);
    map['wake_time_minutes'] = Variable<int>(wakeTimeMinutes);
    map['source'] = Variable<String>(source);
    map['confidence'] = Variable<String>(confidence);
    map['is_manually_adjusted'] = Variable<bool>(isManuallyAdjusted);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SleepRecordEntriesCompanion toCompanion(bool nullToAbsent) {
    return SleepRecordEntriesCompanion(
      id: Value(id),
      sleepDate: Value(sleepDate),
      bedtimeMinutes: Value(bedtimeMinutes),
      wakeTimeMinutes: Value(wakeTimeMinutes),
      source: Value(source),
      confidence: Value(confidence),
      isManuallyAdjusted: Value(isManuallyAdjusted),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory SleepRecordEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepRecordEntry(
      id: serializer.fromJson<String>(json['id']),
      sleepDate: serializer.fromJson<DateTime>(json['sleepDate']),
      bedtimeMinutes: serializer.fromJson<int>(json['bedtimeMinutes']),
      wakeTimeMinutes: serializer.fromJson<int>(json['wakeTimeMinutes']),
      source: serializer.fromJson<String>(json['source']),
      confidence: serializer.fromJson<String>(json['confidence']),
      isManuallyAdjusted: serializer.fromJson<bool>(json['isManuallyAdjusted']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sleepDate': serializer.toJson<DateTime>(sleepDate),
      'bedtimeMinutes': serializer.toJson<int>(bedtimeMinutes),
      'wakeTimeMinutes': serializer.toJson<int>(wakeTimeMinutes),
      'source': serializer.toJson<String>(source),
      'confidence': serializer.toJson<String>(confidence),
      'isManuallyAdjusted': serializer.toJson<bool>(isManuallyAdjusted),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SleepRecordEntry copyWith({
    String? id,
    DateTime? sleepDate,
    int? bedtimeMinutes,
    int? wakeTimeMinutes,
    String? source,
    String? confidence,
    bool? isManuallyAdjusted,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => SleepRecordEntry(
    id: id ?? this.id,
    sleepDate: sleepDate ?? this.sleepDate,
    bedtimeMinutes: bedtimeMinutes ?? this.bedtimeMinutes,
    wakeTimeMinutes: wakeTimeMinutes ?? this.wakeTimeMinutes,
    source: source ?? this.source,
    confidence: confidence ?? this.confidence,
    isManuallyAdjusted: isManuallyAdjusted ?? this.isManuallyAdjusted,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  SleepRecordEntry copyWithCompanion(SleepRecordEntriesCompanion data) {
    return SleepRecordEntry(
      id: data.id.present ? data.id.value : this.id,
      sleepDate: data.sleepDate.present ? data.sleepDate.value : this.sleepDate,
      bedtimeMinutes: data.bedtimeMinutes.present
          ? data.bedtimeMinutes.value
          : this.bedtimeMinutes,
      wakeTimeMinutes: data.wakeTimeMinutes.present
          ? data.wakeTimeMinutes.value
          : this.wakeTimeMinutes,
      source: data.source.present ? data.source.value : this.source,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      isManuallyAdjusted: data.isManuallyAdjusted.present
          ? data.isManuallyAdjusted.value
          : this.isManuallyAdjusted,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepRecordEntry(')
          ..write('id: $id, ')
          ..write('sleepDate: $sleepDate, ')
          ..write('bedtimeMinutes: $bedtimeMinutes, ')
          ..write('wakeTimeMinutes: $wakeTimeMinutes, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('isManuallyAdjusted: $isManuallyAdjusted, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sleepDate,
    bedtimeMinutes,
    wakeTimeMinutes,
    source,
    confidence,
    isManuallyAdjusted,
    note,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepRecordEntry &&
          other.id == this.id &&
          other.sleepDate == this.sleepDate &&
          other.bedtimeMinutes == this.bedtimeMinutes &&
          other.wakeTimeMinutes == this.wakeTimeMinutes &&
          other.source == this.source &&
          other.confidence == this.confidence &&
          other.isManuallyAdjusted == this.isManuallyAdjusted &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class SleepRecordEntriesCompanion extends UpdateCompanion<SleepRecordEntry> {
  final Value<String> id;
  final Value<DateTime> sleepDate;
  final Value<int> bedtimeMinutes;
  final Value<int> wakeTimeMinutes;
  final Value<String> source;
  final Value<String> confidence;
  final Value<bool> isManuallyAdjusted;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SleepRecordEntriesCompanion({
    this.id = const Value.absent(),
    this.sleepDate = const Value.absent(),
    this.bedtimeMinutes = const Value.absent(),
    this.wakeTimeMinutes = const Value.absent(),
    this.source = const Value.absent(),
    this.confidence = const Value.absent(),
    this.isManuallyAdjusted = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepRecordEntriesCompanion.insert({
    required String id,
    required DateTime sleepDate,
    required int bedtimeMinutes,
    required int wakeTimeMinutes,
    required String source,
    required String confidence,
    required bool isManuallyAdjusted,
    this.note = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sleepDate = Value(sleepDate),
       bedtimeMinutes = Value(bedtimeMinutes),
       wakeTimeMinutes = Value(wakeTimeMinutes),
       source = Value(source),
       confidence = Value(confidence),
       isManuallyAdjusted = Value(isManuallyAdjusted),
       createdAt = Value(createdAt);
  static Insertable<SleepRecordEntry> custom({
    Expression<String>? id,
    Expression<DateTime>? sleepDate,
    Expression<int>? bedtimeMinutes,
    Expression<int>? wakeTimeMinutes,
    Expression<String>? source,
    Expression<String>? confidence,
    Expression<bool>? isManuallyAdjusted,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sleepDate != null) 'sleep_date': sleepDate,
      if (bedtimeMinutes != null) 'bedtime_minutes': bedtimeMinutes,
      if (wakeTimeMinutes != null) 'wake_time_minutes': wakeTimeMinutes,
      if (source != null) 'source': source,
      if (confidence != null) 'confidence': confidence,
      if (isManuallyAdjusted != null)
        'is_manually_adjusted': isManuallyAdjusted,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepRecordEntriesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? sleepDate,
    Value<int>? bedtimeMinutes,
    Value<int>? wakeTimeMinutes,
    Value<String>? source,
    Value<String>? confidence,
    Value<bool>? isManuallyAdjusted,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SleepRecordEntriesCompanion(
      id: id ?? this.id,
      sleepDate: sleepDate ?? this.sleepDate,
      bedtimeMinutes: bedtimeMinutes ?? this.bedtimeMinutes,
      wakeTimeMinutes: wakeTimeMinutes ?? this.wakeTimeMinutes,
      source: source ?? this.source,
      confidence: confidence ?? this.confidence,
      isManuallyAdjusted: isManuallyAdjusted ?? this.isManuallyAdjusted,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sleepDate.present) {
      map['sleep_date'] = Variable<DateTime>(sleepDate.value);
    }
    if (bedtimeMinutes.present) {
      map['bedtime_minutes'] = Variable<int>(bedtimeMinutes.value);
    }
    if (wakeTimeMinutes.present) {
      map['wake_time_minutes'] = Variable<int>(wakeTimeMinutes.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<String>(confidence.value);
    }
    if (isManuallyAdjusted.present) {
      map['is_manually_adjusted'] = Variable<bool>(isManuallyAdjusted.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepRecordEntriesCompanion(')
          ..write('id: $id, ')
          ..write('sleepDate: $sleepDate, ')
          ..write('bedtimeMinutes: $bedtimeMinutes, ')
          ..write('wakeTimeMinutes: $wakeTimeMinutes, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('isManuallyAdjusted: $isManuallyAdjusted, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BedtimeSessionEntriesTable extends BedtimeSessionEntries
    with TableInfo<$BedtimeSessionEntriesTable, BedtimeSessionEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BedtimeSessionEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sessionDateMeta = const VerificationMeta(
    'sessionDate',
  );
  @override
  late final GeneratedColumn<DateTime> sessionDate = GeneratedColumn<DateTime>(
    'session_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selectedChoiceMeta = const VerificationMeta(
    'selectedChoice',
  );
  @override
  late final GeneratedColumn<String> selectedChoice = GeneratedColumn<String>(
    'selected_choice',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entrySourceMeta = const VerificationMeta(
    'entrySource',
  );
  @override
  late final GeneratedColumn<String> entrySource = GeneratedColumn<String>(
    'entry_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    sessionDate,
    selectedChoice,
    entrySource,
    isCompleted,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bedtime_session_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<BedtimeSessionEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('session_date')) {
      context.handle(
        _sessionDateMeta,
        sessionDate.isAcceptableOrUnknown(
          data['session_date']!,
          _sessionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionDateMeta);
    }
    if (data.containsKey('selected_choice')) {
      context.handle(
        _selectedChoiceMeta,
        selectedChoice.isAcceptableOrUnknown(
          data['selected_choice']!,
          _selectedChoiceMeta,
        ),
      );
    }
    if (data.containsKey('entry_source')) {
      context.handle(
        _entrySourceMeta,
        entrySource.isAcceptableOrUnknown(
          data['entry_source']!,
          _entrySourceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_entrySourceMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isCompletedMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sessionDate};
  @override
  BedtimeSessionEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BedtimeSessionEntry(
      sessionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}session_date'],
      )!,
      selectedChoice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_choice'],
      ),
      entrySource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_source'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BedtimeSessionEntriesTable createAlias(String alias) {
    return $BedtimeSessionEntriesTable(attachedDatabase, alias);
  }
}

class BedtimeSessionEntry extends DataClass
    implements Insertable<BedtimeSessionEntry> {
  /// 会话按日粒度唯一，足够支撑当前睡前主路径。
  final DateTime sessionDate;

  /// 当前选中的三态判断允许为空，表示用户尚未明确选择。
  final String? selectedChoice;

  /// 入口来源用于后续区分通知、小组件和普通进入。
  final String entrySource;

  /// 当前会话是否已经完成主动作。
  final bool isCompleted;

  /// 最近更新时间用于后续恢复优先级和调试。
  final DateTime updatedAt;
  const BedtimeSessionEntry({
    required this.sessionDate,
    this.selectedChoice,
    required this.entrySource,
    required this.isCompleted,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['session_date'] = Variable<DateTime>(sessionDate);
    if (!nullToAbsent || selectedChoice != null) {
      map['selected_choice'] = Variable<String>(selectedChoice);
    }
    map['entry_source'] = Variable<String>(entrySource);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BedtimeSessionEntriesCompanion toCompanion(bool nullToAbsent) {
    return BedtimeSessionEntriesCompanion(
      sessionDate: Value(sessionDate),
      selectedChoice: selectedChoice == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedChoice),
      entrySource: Value(entrySource),
      isCompleted: Value(isCompleted),
      updatedAt: Value(updatedAt),
    );
  }

  factory BedtimeSessionEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BedtimeSessionEntry(
      sessionDate: serializer.fromJson<DateTime>(json['sessionDate']),
      selectedChoice: serializer.fromJson<String?>(json['selectedChoice']),
      entrySource: serializer.fromJson<String>(json['entrySource']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sessionDate': serializer.toJson<DateTime>(sessionDate),
      'selectedChoice': serializer.toJson<String?>(selectedChoice),
      'entrySource': serializer.toJson<String>(entrySource),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BedtimeSessionEntry copyWith({
    DateTime? sessionDate,
    Value<String?> selectedChoice = const Value.absent(),
    String? entrySource,
    bool? isCompleted,
    DateTime? updatedAt,
  }) => BedtimeSessionEntry(
    sessionDate: sessionDate ?? this.sessionDate,
    selectedChoice: selectedChoice.present
        ? selectedChoice.value
        : this.selectedChoice,
    entrySource: entrySource ?? this.entrySource,
    isCompleted: isCompleted ?? this.isCompleted,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BedtimeSessionEntry copyWithCompanion(BedtimeSessionEntriesCompanion data) {
    return BedtimeSessionEntry(
      sessionDate: data.sessionDate.present
          ? data.sessionDate.value
          : this.sessionDate,
      selectedChoice: data.selectedChoice.present
          ? data.selectedChoice.value
          : this.selectedChoice,
      entrySource: data.entrySource.present
          ? data.entrySource.value
          : this.entrySource,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BedtimeSessionEntry(')
          ..write('sessionDate: $sessionDate, ')
          ..write('selectedChoice: $selectedChoice, ')
          ..write('entrySource: $entrySource, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    sessionDate,
    selectedChoice,
    entrySource,
    isCompleted,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BedtimeSessionEntry &&
          other.sessionDate == this.sessionDate &&
          other.selectedChoice == this.selectedChoice &&
          other.entrySource == this.entrySource &&
          other.isCompleted == this.isCompleted &&
          other.updatedAt == this.updatedAt);
}

class BedtimeSessionEntriesCompanion
    extends UpdateCompanion<BedtimeSessionEntry> {
  final Value<DateTime> sessionDate;
  final Value<String?> selectedChoice;
  final Value<String> entrySource;
  final Value<bool> isCompleted;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BedtimeSessionEntriesCompanion({
    this.sessionDate = const Value.absent(),
    this.selectedChoice = const Value.absent(),
    this.entrySource = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BedtimeSessionEntriesCompanion.insert({
    required DateTime sessionDate,
    this.selectedChoice = const Value.absent(),
    required String entrySource,
    required bool isCompleted,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : sessionDate = Value(sessionDate),
       entrySource = Value(entrySource),
       isCompleted = Value(isCompleted),
       updatedAt = Value(updatedAt);
  static Insertable<BedtimeSessionEntry> custom({
    Expression<DateTime>? sessionDate,
    Expression<String>? selectedChoice,
    Expression<String>? entrySource,
    Expression<bool>? isCompleted,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sessionDate != null) 'session_date': sessionDate,
      if (selectedChoice != null) 'selected_choice': selectedChoice,
      if (entrySource != null) 'entry_source': entrySource,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BedtimeSessionEntriesCompanion copyWith({
    Value<DateTime>? sessionDate,
    Value<String?>? selectedChoice,
    Value<String>? entrySource,
    Value<bool>? isCompleted,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BedtimeSessionEntriesCompanion(
      sessionDate: sessionDate ?? this.sessionDate,
      selectedChoice: selectedChoice ?? this.selectedChoice,
      entrySource: entrySource ?? this.entrySource,
      isCompleted: isCompleted ?? this.isCompleted,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sessionDate.present) {
      map['session_date'] = Variable<DateTime>(sessionDate.value);
    }
    if (selectedChoice.present) {
      map['selected_choice'] = Variable<String>(selectedChoice.value);
    }
    if (entrySource.present) {
      map['entry_source'] = Variable<String>(entrySource.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BedtimeSessionEntriesCompanion(')
          ..write('sessionDate: $sessionDate, ')
          ..write('selectedChoice: $selectedChoice, ')
          ..write('entrySource: $entrySource, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$RhythmDatabase extends GeneratedDatabase {
  _$RhythmDatabase(QueryExecutor e) : super(e);
  $RhythmDatabaseManager get managers => $RhythmDatabaseManager(this);
  late final $GoalScheduleEntriesTable goalScheduleEntries =
      $GoalScheduleEntriesTable(this);
  late final $SleepRecordEntriesTable sleepRecordEntries =
      $SleepRecordEntriesTable(this);
  late final $BedtimeSessionEntriesTable bedtimeSessionEntries =
      $BedtimeSessionEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    goalScheduleEntries,
    sleepRecordEntries,
    bedtimeSessionEntries,
  ];
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
typedef $$SleepRecordEntriesTableCreateCompanionBuilder =
    SleepRecordEntriesCompanion Function({
      required String id,
      required DateTime sleepDate,
      required int bedtimeMinutes,
      required int wakeTimeMinutes,
      required String source,
      required String confidence,
      required bool isManuallyAdjusted,
      Value<String?> note,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SleepRecordEntriesTableUpdateCompanionBuilder =
    SleepRecordEntriesCompanion Function({
      Value<String> id,
      Value<DateTime> sleepDate,
      Value<int> bedtimeMinutes,
      Value<int> wakeTimeMinutes,
      Value<String> source,
      Value<String> confidence,
      Value<bool> isManuallyAdjusted,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SleepRecordEntriesTableFilterComposer
    extends Composer<_$RhythmDatabase, $SleepRecordEntriesTable> {
  $$SleepRecordEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sleepDate => $composableBuilder(
    column: $table.sleepDate,
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

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isManuallyAdjusted => $composableBuilder(
    column: $table.isManuallyAdjusted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SleepRecordEntriesTableOrderingComposer
    extends Composer<_$RhythmDatabase, $SleepRecordEntriesTable> {
  $$SleepRecordEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sleepDate => $composableBuilder(
    column: $table.sleepDate,
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

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isManuallyAdjusted => $composableBuilder(
    column: $table.isManuallyAdjusted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SleepRecordEntriesTableAnnotationComposer
    extends Composer<_$RhythmDatabase, $SleepRecordEntriesTable> {
  $$SleepRecordEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get sleepDate =>
      $composableBuilder(column: $table.sleepDate, builder: (column) => column);

  GeneratedColumn<int> get bedtimeMinutes => $composableBuilder(
    column: $table.bedtimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wakeTimeMinutes => $composableBuilder(
    column: $table.wakeTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isManuallyAdjusted => $composableBuilder(
    column: $table.isManuallyAdjusted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SleepRecordEntriesTableTableManager
    extends
        RootTableManager<
          _$RhythmDatabase,
          $SleepRecordEntriesTable,
          SleepRecordEntry,
          $$SleepRecordEntriesTableFilterComposer,
          $$SleepRecordEntriesTableOrderingComposer,
          $$SleepRecordEntriesTableAnnotationComposer,
          $$SleepRecordEntriesTableCreateCompanionBuilder,
          $$SleepRecordEntriesTableUpdateCompanionBuilder,
          (
            SleepRecordEntry,
            BaseReferences<
              _$RhythmDatabase,
              $SleepRecordEntriesTable,
              SleepRecordEntry
            >,
          ),
          SleepRecordEntry,
          PrefetchHooks Function()
        > {
  $$SleepRecordEntriesTableTableManager(
    _$RhythmDatabase db,
    $SleepRecordEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepRecordEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepRecordEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepRecordEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> sleepDate = const Value.absent(),
                Value<int> bedtimeMinutes = const Value.absent(),
                Value<int> wakeTimeMinutes = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> confidence = const Value.absent(),
                Value<bool> isManuallyAdjusted = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SleepRecordEntriesCompanion(
                id: id,
                sleepDate: sleepDate,
                bedtimeMinutes: bedtimeMinutes,
                wakeTimeMinutes: wakeTimeMinutes,
                source: source,
                confidence: confidence,
                isManuallyAdjusted: isManuallyAdjusted,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime sleepDate,
                required int bedtimeMinutes,
                required int wakeTimeMinutes,
                required String source,
                required String confidence,
                required bool isManuallyAdjusted,
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SleepRecordEntriesCompanion.insert(
                id: id,
                sleepDate: sleepDate,
                bedtimeMinutes: bedtimeMinutes,
                wakeTimeMinutes: wakeTimeMinutes,
                source: source,
                confidence: confidence,
                isManuallyAdjusted: isManuallyAdjusted,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SleepRecordEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$RhythmDatabase,
      $SleepRecordEntriesTable,
      SleepRecordEntry,
      $$SleepRecordEntriesTableFilterComposer,
      $$SleepRecordEntriesTableOrderingComposer,
      $$SleepRecordEntriesTableAnnotationComposer,
      $$SleepRecordEntriesTableCreateCompanionBuilder,
      $$SleepRecordEntriesTableUpdateCompanionBuilder,
      (
        SleepRecordEntry,
        BaseReferences<
          _$RhythmDatabase,
          $SleepRecordEntriesTable,
          SleepRecordEntry
        >,
      ),
      SleepRecordEntry,
      PrefetchHooks Function()
    >;
typedef $$BedtimeSessionEntriesTableCreateCompanionBuilder =
    BedtimeSessionEntriesCompanion Function({
      required DateTime sessionDate,
      Value<String?> selectedChoice,
      required String entrySource,
      required bool isCompleted,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BedtimeSessionEntriesTableUpdateCompanionBuilder =
    BedtimeSessionEntriesCompanion Function({
      Value<DateTime> sessionDate,
      Value<String?> selectedChoice,
      Value<String> entrySource,
      Value<bool> isCompleted,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$BedtimeSessionEntriesTableFilterComposer
    extends Composer<_$RhythmDatabase, $BedtimeSessionEntriesTable> {
  $$BedtimeSessionEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedChoice => $composableBuilder(
    column: $table.selectedChoice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entrySource => $composableBuilder(
    column: $table.entrySource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BedtimeSessionEntriesTableOrderingComposer
    extends Composer<_$RhythmDatabase, $BedtimeSessionEntriesTable> {
  $$BedtimeSessionEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedChoice => $composableBuilder(
    column: $table.selectedChoice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entrySource => $composableBuilder(
    column: $table.entrySource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BedtimeSessionEntriesTableAnnotationComposer
    extends Composer<_$RhythmDatabase, $BedtimeSessionEntriesTable> {
  $$BedtimeSessionEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get selectedChoice => $composableBuilder(
    column: $table.selectedChoice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entrySource => $composableBuilder(
    column: $table.entrySource,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BedtimeSessionEntriesTableTableManager
    extends
        RootTableManager<
          _$RhythmDatabase,
          $BedtimeSessionEntriesTable,
          BedtimeSessionEntry,
          $$BedtimeSessionEntriesTableFilterComposer,
          $$BedtimeSessionEntriesTableOrderingComposer,
          $$BedtimeSessionEntriesTableAnnotationComposer,
          $$BedtimeSessionEntriesTableCreateCompanionBuilder,
          $$BedtimeSessionEntriesTableUpdateCompanionBuilder,
          (
            BedtimeSessionEntry,
            BaseReferences<
              _$RhythmDatabase,
              $BedtimeSessionEntriesTable,
              BedtimeSessionEntry
            >,
          ),
          BedtimeSessionEntry,
          PrefetchHooks Function()
        > {
  $$BedtimeSessionEntriesTableTableManager(
    _$RhythmDatabase db,
    $BedtimeSessionEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BedtimeSessionEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$BedtimeSessionEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BedtimeSessionEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<DateTime> sessionDate = const Value.absent(),
                Value<String?> selectedChoice = const Value.absent(),
                Value<String> entrySource = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BedtimeSessionEntriesCompanion(
                sessionDate: sessionDate,
                selectedChoice: selectedChoice,
                entrySource: entrySource,
                isCompleted: isCompleted,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime sessionDate,
                Value<String?> selectedChoice = const Value.absent(),
                required String entrySource,
                required bool isCompleted,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BedtimeSessionEntriesCompanion.insert(
                sessionDate: sessionDate,
                selectedChoice: selectedChoice,
                entrySource: entrySource,
                isCompleted: isCompleted,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BedtimeSessionEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$RhythmDatabase,
      $BedtimeSessionEntriesTable,
      BedtimeSessionEntry,
      $$BedtimeSessionEntriesTableFilterComposer,
      $$BedtimeSessionEntriesTableOrderingComposer,
      $$BedtimeSessionEntriesTableAnnotationComposer,
      $$BedtimeSessionEntriesTableCreateCompanionBuilder,
      $$BedtimeSessionEntriesTableUpdateCompanionBuilder,
      (
        BedtimeSessionEntry,
        BaseReferences<
          _$RhythmDatabase,
          $BedtimeSessionEntriesTable,
          BedtimeSessionEntry
        >,
      ),
      BedtimeSessionEntry,
      PrefetchHooks Function()
    >;

class $RhythmDatabaseManager {
  final _$RhythmDatabase _db;
  $RhythmDatabaseManager(this._db);
  $$GoalScheduleEntriesTableTableManager get goalScheduleEntries =>
      $$GoalScheduleEntriesTableTableManager(_db, _db.goalScheduleEntries);
  $$SleepRecordEntriesTableTableManager get sleepRecordEntries =>
      $$SleepRecordEntriesTableTableManager(_db, _db.sleepRecordEntries);
  $$BedtimeSessionEntriesTableTableManager get bedtimeSessionEntries =>
      $$BedtimeSessionEntriesTableTableManager(_db, _db.bedtimeSessionEntries);
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
