// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rhythm_database.dart';

// ignore_for_file: type=lint
class $GoalSchedulesTable extends GoalSchedules
    with TableInfo<$GoalSchedulesTable, GoalSchedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalSchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetBedtimeMinutesMeta =
      const VerificationMeta('targetBedtimeMinutes');
  @override
  late final GeneratedColumn<int> targetBedtimeMinutes = GeneratedColumn<int>(
    'target_bedtime_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetWakeMinutesMeta = const VerificationMeta(
    'targetWakeMinutes',
  );
  @override
  late final GeneratedColumn<int> targetWakeMinutes = GeneratedColumn<int>(
    'target_wake_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lateThresholdMinutesMeta =
      const VerificationMeta('lateThresholdMinutes');
  @override
  late final GeneratedColumn<int> lateThresholdMinutes = GeneratedColumn<int>(
    'late_threshold_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayStartMinutesMeta = const VerificationMeta(
    'dayStartMinutes',
  );
  @override
  late final GeneratedColumn<int> dayStartMinutes = GeneratedColumn<int>(
    'day_start_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    targetBedtimeMinutes,
    targetWakeMinutes,
    lateThresholdMinutes,
    dayStartMinutes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalSchedule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('target_bedtime_minutes')) {
      context.handle(
        _targetBedtimeMinutesMeta,
        targetBedtimeMinutes.isAcceptableOrUnknown(
          data['target_bedtime_minutes']!,
          _targetBedtimeMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetBedtimeMinutesMeta);
    }
    if (data.containsKey('target_wake_minutes')) {
      context.handle(
        _targetWakeMinutesMeta,
        targetWakeMinutes.isAcceptableOrUnknown(
          data['target_wake_minutes']!,
          _targetWakeMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetWakeMinutesMeta);
    }
    if (data.containsKey('late_threshold_minutes')) {
      context.handle(
        _lateThresholdMinutesMeta,
        lateThresholdMinutes.isAcceptableOrUnknown(
          data['late_threshold_minutes']!,
          _lateThresholdMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lateThresholdMinutesMeta);
    }
    if (data.containsKey('day_start_minutes')) {
      context.handle(
        _dayStartMinutesMeta,
        dayStartMinutes.isAcceptableOrUnknown(
          data['day_start_minutes']!,
          _dayStartMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dayStartMinutesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalSchedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalSchedule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      targetBedtimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_bedtime_minutes'],
      )!,
      targetWakeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_wake_minutes'],
      )!,
      lateThresholdMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}late_threshold_minutes'],
      )!,
      dayStartMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_start_minutes'],
      )!,
    );
  }

  @override
  $GoalSchedulesTable createAlias(String alias) {
    return $GoalSchedulesTable(attachedDatabase, alias);
  }
}

class GoalSchedule extends DataClass implements Insertable<GoalSchedule> {
  /// 目标记录唯一标识。
  final String id;

  /// 目标入睡时间，按 0 点起分钟数存储，避免时区转换时丢失业务语义。
  final int targetBedtimeMinutes;

  /// 目标起床时间。
  final int targetWakeMinutes;

  /// 熬夜阈值分钟数。
  final int lateThresholdMinutes;

  /// 一天起始时间分钟数。
  final int dayStartMinutes;
  const GoalSchedule({
    required this.id,
    required this.targetBedtimeMinutes,
    required this.targetWakeMinutes,
    required this.lateThresholdMinutes,
    required this.dayStartMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['target_bedtime_minutes'] = Variable<int>(targetBedtimeMinutes);
    map['target_wake_minutes'] = Variable<int>(targetWakeMinutes);
    map['late_threshold_minutes'] = Variable<int>(lateThresholdMinutes);
    map['day_start_minutes'] = Variable<int>(dayStartMinutes);
    return map;
  }

  GoalSchedulesCompanion toCompanion(bool nullToAbsent) {
    return GoalSchedulesCompanion(
      id: Value(id),
      targetBedtimeMinutes: Value(targetBedtimeMinutes),
      targetWakeMinutes: Value(targetWakeMinutes),
      lateThresholdMinutes: Value(lateThresholdMinutes),
      dayStartMinutes: Value(dayStartMinutes),
    );
  }

  factory GoalSchedule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalSchedule(
      id: serializer.fromJson<String>(json['id']),
      targetBedtimeMinutes: serializer.fromJson<int>(
        json['targetBedtimeMinutes'],
      ),
      targetWakeMinutes: serializer.fromJson<int>(json['targetWakeMinutes']),
      lateThresholdMinutes: serializer.fromJson<int>(
        json['lateThresholdMinutes'],
      ),
      dayStartMinutes: serializer.fromJson<int>(json['dayStartMinutes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'targetBedtimeMinutes': serializer.toJson<int>(targetBedtimeMinutes),
      'targetWakeMinutes': serializer.toJson<int>(targetWakeMinutes),
      'lateThresholdMinutes': serializer.toJson<int>(lateThresholdMinutes),
      'dayStartMinutes': serializer.toJson<int>(dayStartMinutes),
    };
  }

  GoalSchedule copyWith({
    String? id,
    int? targetBedtimeMinutes,
    int? targetWakeMinutes,
    int? lateThresholdMinutes,
    int? dayStartMinutes,
  }) => GoalSchedule(
    id: id ?? this.id,
    targetBedtimeMinutes: targetBedtimeMinutes ?? this.targetBedtimeMinutes,
    targetWakeMinutes: targetWakeMinutes ?? this.targetWakeMinutes,
    lateThresholdMinutes: lateThresholdMinutes ?? this.lateThresholdMinutes,
    dayStartMinutes: dayStartMinutes ?? this.dayStartMinutes,
  );
  GoalSchedule copyWithCompanion(GoalSchedulesCompanion data) {
    return GoalSchedule(
      id: data.id.present ? data.id.value : this.id,
      targetBedtimeMinutes: data.targetBedtimeMinutes.present
          ? data.targetBedtimeMinutes.value
          : this.targetBedtimeMinutes,
      targetWakeMinutes: data.targetWakeMinutes.present
          ? data.targetWakeMinutes.value
          : this.targetWakeMinutes,
      lateThresholdMinutes: data.lateThresholdMinutes.present
          ? data.lateThresholdMinutes.value
          : this.lateThresholdMinutes,
      dayStartMinutes: data.dayStartMinutes.present
          ? data.dayStartMinutes.value
          : this.dayStartMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalSchedule(')
          ..write('id: $id, ')
          ..write('targetBedtimeMinutes: $targetBedtimeMinutes, ')
          ..write('targetWakeMinutes: $targetWakeMinutes, ')
          ..write('lateThresholdMinutes: $lateThresholdMinutes, ')
          ..write('dayStartMinutes: $dayStartMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    targetBedtimeMinutes,
    targetWakeMinutes,
    lateThresholdMinutes,
    dayStartMinutes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalSchedule &&
          other.id == this.id &&
          other.targetBedtimeMinutes == this.targetBedtimeMinutes &&
          other.targetWakeMinutes == this.targetWakeMinutes &&
          other.lateThresholdMinutes == this.lateThresholdMinutes &&
          other.dayStartMinutes == this.dayStartMinutes);
}

class GoalSchedulesCompanion extends UpdateCompanion<GoalSchedule> {
  final Value<String> id;
  final Value<int> targetBedtimeMinutes;
  final Value<int> targetWakeMinutes;
  final Value<int> lateThresholdMinutes;
  final Value<int> dayStartMinutes;
  final Value<int> rowid;
  const GoalSchedulesCompanion({
    this.id = const Value.absent(),
    this.targetBedtimeMinutes = const Value.absent(),
    this.targetWakeMinutes = const Value.absent(),
    this.lateThresholdMinutes = const Value.absent(),
    this.dayStartMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalSchedulesCompanion.insert({
    required String id,
    required int targetBedtimeMinutes,
    required int targetWakeMinutes,
    required int lateThresholdMinutes,
    required int dayStartMinutes,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       targetBedtimeMinutes = Value(targetBedtimeMinutes),
       targetWakeMinutes = Value(targetWakeMinutes),
       lateThresholdMinutes = Value(lateThresholdMinutes),
       dayStartMinutes = Value(dayStartMinutes);
  static Insertable<GoalSchedule> custom({
    Expression<String>? id,
    Expression<int>? targetBedtimeMinutes,
    Expression<int>? targetWakeMinutes,
    Expression<int>? lateThresholdMinutes,
    Expression<int>? dayStartMinutes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetBedtimeMinutes != null)
        'target_bedtime_minutes': targetBedtimeMinutes,
      if (targetWakeMinutes != null) 'target_wake_minutes': targetWakeMinutes,
      if (lateThresholdMinutes != null)
        'late_threshold_minutes': lateThresholdMinutes,
      if (dayStartMinutes != null) 'day_start_minutes': dayStartMinutes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalSchedulesCompanion copyWith({
    Value<String>? id,
    Value<int>? targetBedtimeMinutes,
    Value<int>? targetWakeMinutes,
    Value<int>? lateThresholdMinutes,
    Value<int>? dayStartMinutes,
    Value<int>? rowid,
  }) {
    return GoalSchedulesCompanion(
      id: id ?? this.id,
      targetBedtimeMinutes: targetBedtimeMinutes ?? this.targetBedtimeMinutes,
      targetWakeMinutes: targetWakeMinutes ?? this.targetWakeMinutes,
      lateThresholdMinutes: lateThresholdMinutes ?? this.lateThresholdMinutes,
      dayStartMinutes: dayStartMinutes ?? this.dayStartMinutes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (targetBedtimeMinutes.present) {
      map['target_bedtime_minutes'] = Variable<int>(targetBedtimeMinutes.value);
    }
    if (targetWakeMinutes.present) {
      map['target_wake_minutes'] = Variable<int>(targetWakeMinutes.value);
    }
    if (lateThresholdMinutes.present) {
      map['late_threshold_minutes'] = Variable<int>(lateThresholdMinutes.value);
    }
    if (dayStartMinutes.present) {
      map['day_start_minutes'] = Variable<int>(dayStartMinutes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('targetBedtimeMinutes: $targetBedtimeMinutes, ')
          ..write('targetWakeMinutes: $targetWakeMinutes, ')
          ..write('lateThresholdMinutes: $lateThresholdMinutes, ')
          ..write('dayStartMinutes: $dayStartMinutes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SleepRecordsTable extends SleepRecords
    with TableInfo<$SleepRecordsTable, SleepRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordDateMeta = const VerificationMeta(
    'recordDate',
  );
  @override
  late final GeneratedColumn<DateTime> recordDate = GeneratedColumn<DateTime>(
    'record_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fellAsleepAtMeta = const VerificationMeta(
    'fellAsleepAt',
  );
  @override
  late final GeneratedColumn<DateTime> fellAsleepAt = GeneratedColumn<DateTime>(
    'fell_asleep_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wokeUpAtMeta = const VerificationMeta(
    'wokeUpAt',
  );
  @override
  late final GeneratedColumn<DateTime> wokeUpAt = GeneratedColumn<DateTime>(
    'woke_up_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isUserEditedMeta = const VerificationMeta(
    'isUserEdited',
  );
  @override
  late final GeneratedColumn<bool> isUserEdited = GeneratedColumn<bool>(
    'is_user_edited',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_user_edited" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recordDate,
    fellAsleepAt,
    wokeUpAt,
    source,
    confidence,
    timezone,
    isUserEdited,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('record_date')) {
      context.handle(
        _recordDateMeta,
        recordDate.isAcceptableOrUnknown(data['record_date']!, _recordDateMeta),
      );
    } else if (isInserting) {
      context.missing(_recordDateMeta);
    }
    if (data.containsKey('fell_asleep_at')) {
      context.handle(
        _fellAsleepAtMeta,
        fellAsleepAt.isAcceptableOrUnknown(
          data['fell_asleep_at']!,
          _fellAsleepAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fellAsleepAtMeta);
    }
    if (data.containsKey('woke_up_at')) {
      context.handle(
        _wokeUpAtMeta,
        wokeUpAt.isAcceptableOrUnknown(data['woke_up_at']!, _wokeUpAtMeta),
      );
    } else if (isInserting) {
      context.missing(_wokeUpAtMeta);
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
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    } else if (isInserting) {
      context.missing(_timezoneMeta);
    }
    if (data.containsKey('is_user_edited')) {
      context.handle(
        _isUserEditedMeta,
        isUserEdited.isAcceptableOrUnknown(
          data['is_user_edited']!,
          _isUserEditedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      recordDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}record_date'],
      )!,
      fellAsleepAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fell_asleep_at'],
      )!,
      wokeUpAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}woke_up_at'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}confidence'],
      )!,
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      )!,
      isUserEdited: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_user_edited'],
      )!,
    );
  }

  @override
  $SleepRecordsTable createAlias(String alias) {
    return $SleepRecordsTable(attachedDatabase, alias);
  }
}

class SleepRecord extends DataClass implements Insertable<SleepRecord> {
  /// 睡眠记录唯一标识。
  final String id;

  /// 归属日期，统一保存为 UTC 0 点方便范围查询。
  final DateTime recordDate;

  /// 实际入睡时间。
  final DateTime fellAsleepAt;

  /// 实际起床时间。
  final DateTime wokeUpAt;

  /// 数据来源枚举名。
  final String source;

  /// 数据可信度枚举名。
  final String confidence;

  /// 记录时区。
  final String timezone;

  /// 是否已被用户手动修正。
  final bool isUserEdited;
  const SleepRecord({
    required this.id,
    required this.recordDate,
    required this.fellAsleepAt,
    required this.wokeUpAt,
    required this.source,
    required this.confidence,
    required this.timezone,
    required this.isUserEdited,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['record_date'] = Variable<DateTime>(recordDate);
    map['fell_asleep_at'] = Variable<DateTime>(fellAsleepAt);
    map['woke_up_at'] = Variable<DateTime>(wokeUpAt);
    map['source'] = Variable<String>(source);
    map['confidence'] = Variable<String>(confidence);
    map['timezone'] = Variable<String>(timezone);
    map['is_user_edited'] = Variable<bool>(isUserEdited);
    return map;
  }

  SleepRecordsCompanion toCompanion(bool nullToAbsent) {
    return SleepRecordsCompanion(
      id: Value(id),
      recordDate: Value(recordDate),
      fellAsleepAt: Value(fellAsleepAt),
      wokeUpAt: Value(wokeUpAt),
      source: Value(source),
      confidence: Value(confidence),
      timezone: Value(timezone),
      isUserEdited: Value(isUserEdited),
    );
  }

  factory SleepRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepRecord(
      id: serializer.fromJson<String>(json['id']),
      recordDate: serializer.fromJson<DateTime>(json['recordDate']),
      fellAsleepAt: serializer.fromJson<DateTime>(json['fellAsleepAt']),
      wokeUpAt: serializer.fromJson<DateTime>(json['wokeUpAt']),
      source: serializer.fromJson<String>(json['source']),
      confidence: serializer.fromJson<String>(json['confidence']),
      timezone: serializer.fromJson<String>(json['timezone']),
      isUserEdited: serializer.fromJson<bool>(json['isUserEdited']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recordDate': serializer.toJson<DateTime>(recordDate),
      'fellAsleepAt': serializer.toJson<DateTime>(fellAsleepAt),
      'wokeUpAt': serializer.toJson<DateTime>(wokeUpAt),
      'source': serializer.toJson<String>(source),
      'confidence': serializer.toJson<String>(confidence),
      'timezone': serializer.toJson<String>(timezone),
      'isUserEdited': serializer.toJson<bool>(isUserEdited),
    };
  }

  SleepRecord copyWith({
    String? id,
    DateTime? recordDate,
    DateTime? fellAsleepAt,
    DateTime? wokeUpAt,
    String? source,
    String? confidence,
    String? timezone,
    bool? isUserEdited,
  }) => SleepRecord(
    id: id ?? this.id,
    recordDate: recordDate ?? this.recordDate,
    fellAsleepAt: fellAsleepAt ?? this.fellAsleepAt,
    wokeUpAt: wokeUpAt ?? this.wokeUpAt,
    source: source ?? this.source,
    confidence: confidence ?? this.confidence,
    timezone: timezone ?? this.timezone,
    isUserEdited: isUserEdited ?? this.isUserEdited,
  );
  SleepRecord copyWithCompanion(SleepRecordsCompanion data) {
    return SleepRecord(
      id: data.id.present ? data.id.value : this.id,
      recordDate: data.recordDate.present
          ? data.recordDate.value
          : this.recordDate,
      fellAsleepAt: data.fellAsleepAt.present
          ? data.fellAsleepAt.value
          : this.fellAsleepAt,
      wokeUpAt: data.wokeUpAt.present ? data.wokeUpAt.value : this.wokeUpAt,
      source: data.source.present ? data.source.value : this.source,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      isUserEdited: data.isUserEdited.present
          ? data.isUserEdited.value
          : this.isUserEdited,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepRecord(')
          ..write('id: $id, ')
          ..write('recordDate: $recordDate, ')
          ..write('fellAsleepAt: $fellAsleepAt, ')
          ..write('wokeUpAt: $wokeUpAt, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('timezone: $timezone, ')
          ..write('isUserEdited: $isUserEdited')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recordDate,
    fellAsleepAt,
    wokeUpAt,
    source,
    confidence,
    timezone,
    isUserEdited,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepRecord &&
          other.id == this.id &&
          other.recordDate == this.recordDate &&
          other.fellAsleepAt == this.fellAsleepAt &&
          other.wokeUpAt == this.wokeUpAt &&
          other.source == this.source &&
          other.confidence == this.confidence &&
          other.timezone == this.timezone &&
          other.isUserEdited == this.isUserEdited);
}

class SleepRecordsCompanion extends UpdateCompanion<SleepRecord> {
  final Value<String> id;
  final Value<DateTime> recordDate;
  final Value<DateTime> fellAsleepAt;
  final Value<DateTime> wokeUpAt;
  final Value<String> source;
  final Value<String> confidence;
  final Value<String> timezone;
  final Value<bool> isUserEdited;
  final Value<int> rowid;
  const SleepRecordsCompanion({
    this.id = const Value.absent(),
    this.recordDate = const Value.absent(),
    this.fellAsleepAt = const Value.absent(),
    this.wokeUpAt = const Value.absent(),
    this.source = const Value.absent(),
    this.confidence = const Value.absent(),
    this.timezone = const Value.absent(),
    this.isUserEdited = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepRecordsCompanion.insert({
    required String id,
    required DateTime recordDate,
    required DateTime fellAsleepAt,
    required DateTime wokeUpAt,
    required String source,
    required String confidence,
    required String timezone,
    this.isUserEdited = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       recordDate = Value(recordDate),
       fellAsleepAt = Value(fellAsleepAt),
       wokeUpAt = Value(wokeUpAt),
       source = Value(source),
       confidence = Value(confidence),
       timezone = Value(timezone);
  static Insertable<SleepRecord> custom({
    Expression<String>? id,
    Expression<DateTime>? recordDate,
    Expression<DateTime>? fellAsleepAt,
    Expression<DateTime>? wokeUpAt,
    Expression<String>? source,
    Expression<String>? confidence,
    Expression<String>? timezone,
    Expression<bool>? isUserEdited,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordDate != null) 'record_date': recordDate,
      if (fellAsleepAt != null) 'fell_asleep_at': fellAsleepAt,
      if (wokeUpAt != null) 'woke_up_at': wokeUpAt,
      if (source != null) 'source': source,
      if (confidence != null) 'confidence': confidence,
      if (timezone != null) 'timezone': timezone,
      if (isUserEdited != null) 'is_user_edited': isUserEdited,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepRecordsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? recordDate,
    Value<DateTime>? fellAsleepAt,
    Value<DateTime>? wokeUpAt,
    Value<String>? source,
    Value<String>? confidence,
    Value<String>? timezone,
    Value<bool>? isUserEdited,
    Value<int>? rowid,
  }) {
    return SleepRecordsCompanion(
      id: id ?? this.id,
      recordDate: recordDate ?? this.recordDate,
      fellAsleepAt: fellAsleepAt ?? this.fellAsleepAt,
      wokeUpAt: wokeUpAt ?? this.wokeUpAt,
      source: source ?? this.source,
      confidence: confidence ?? this.confidence,
      timezone: timezone ?? this.timezone,
      isUserEdited: isUserEdited ?? this.isUserEdited,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recordDate.present) {
      map['record_date'] = Variable<DateTime>(recordDate.value);
    }
    if (fellAsleepAt.present) {
      map['fell_asleep_at'] = Variable<DateTime>(fellAsleepAt.value);
    }
    if (wokeUpAt.present) {
      map['woke_up_at'] = Variable<DateTime>(wokeUpAt.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<String>(confidence.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (isUserEdited.present) {
      map['is_user_edited'] = Variable<bool>(isUserEdited.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepRecordsCompanion(')
          ..write('id: $id, ')
          ..write('recordDate: $recordDate, ')
          ..write('fellAsleepAt: $fellAsleepAt, ')
          ..write('wokeUpAt: $wokeUpAt, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('timezone: $timezone, ')
          ..write('isUserEdited: $isUserEdited, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BedtimeSessionsTable extends BedtimeSessions
    with TableInfo<$BedtimeSessionsTable, BedtimeSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BedtimeSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entryPointMeta = const VerificationMeta(
    'entryPoint',
  );
  @override
  late final GeneratedColumn<String> entryPoint = GeneratedColumn<String>(
    'entry_point',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minutesToTargetMeta = const VerificationMeta(
    'minutesToTarget',
  );
  @override
  late final GeneratedColumn<int> minutesToTarget = GeneratedColumn<int>(
    'minutes_to_target',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    completedAt,
    entryPoint,
    minutesToTarget,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bedtime_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<BedtimeSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('entry_point')) {
      context.handle(
        _entryPointMeta,
        entryPoint.isAcceptableOrUnknown(data['entry_point']!, _entryPointMeta),
      );
    } else if (isInserting) {
      context.missing(_entryPointMeta);
    }
    if (data.containsKey('minutes_to_target')) {
      context.handle(
        _minutesToTargetMeta,
        minutesToTarget.isAcceptableOrUnknown(
          data['minutes_to_target']!,
          _minutesToTargetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_minutesToTargetMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BedtimeSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BedtimeSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      entryPoint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_point'],
      )!,
      minutesToTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minutes_to_target'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $BedtimeSessionsTable createAlias(String alias) {
    return $BedtimeSessionsTable(attachedDatabase, alias);
  }
}

class BedtimeSession extends DataClass implements Insertable<BedtimeSession> {
  /// 会话唯一标识。
  final String id;

  /// 会话开始时间。
  final DateTime startedAt;

  /// 会话完成时间。
  final DateTime? completedAt;

  /// 进入来源。
  final String entryPoint;

  /// 距离目标入睡时间的分钟差。
  final int minutesToTarget;

  /// 睡前状态。
  final String status;
  const BedtimeSession({
    required this.id,
    required this.startedAt,
    this.completedAt,
    required this.entryPoint,
    required this.minutesToTarget,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['entry_point'] = Variable<String>(entryPoint);
    map['minutes_to_target'] = Variable<int>(minutesToTarget);
    map['status'] = Variable<String>(status);
    return map;
  }

  BedtimeSessionsCompanion toCompanion(bool nullToAbsent) {
    return BedtimeSessionsCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      entryPoint: Value(entryPoint),
      minutesToTarget: Value(minutesToTarget),
      status: Value(status),
    );
  }

  factory BedtimeSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BedtimeSession(
      id: serializer.fromJson<String>(json['id']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      entryPoint: serializer.fromJson<String>(json['entryPoint']),
      minutesToTarget: serializer.fromJson<int>(json['minutesToTarget']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'entryPoint': serializer.toJson<String>(entryPoint),
      'minutesToTarget': serializer.toJson<int>(minutesToTarget),
      'status': serializer.toJson<String>(status),
    };
  }

  BedtimeSession copyWith({
    String? id,
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    String? entryPoint,
    int? minutesToTarget,
    String? status,
  }) => BedtimeSession(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    entryPoint: entryPoint ?? this.entryPoint,
    minutesToTarget: minutesToTarget ?? this.minutesToTarget,
    status: status ?? this.status,
  );
  BedtimeSession copyWithCompanion(BedtimeSessionsCompanion data) {
    return BedtimeSession(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      entryPoint: data.entryPoint.present
          ? data.entryPoint.value
          : this.entryPoint,
      minutesToTarget: data.minutesToTarget.present
          ? data.minutesToTarget.value
          : this.minutesToTarget,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BedtimeSession(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('entryPoint: $entryPoint, ')
          ..write('minutesToTarget: $minutesToTarget, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startedAt,
    completedAt,
    entryPoint,
    minutesToTarget,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BedtimeSession &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.entryPoint == this.entryPoint &&
          other.minutesToTarget == this.minutesToTarget &&
          other.status == this.status);
}

class BedtimeSessionsCompanion extends UpdateCompanion<BedtimeSession> {
  final Value<String> id;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<String> entryPoint;
  final Value<int> minutesToTarget;
  final Value<String> status;
  final Value<int> rowid;
  const BedtimeSessionsCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.entryPoint = const Value.absent(),
    this.minutesToTarget = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BedtimeSessionsCompanion.insert({
    required String id,
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    required String entryPoint,
    required int minutesToTarget,
    required String status,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       startedAt = Value(startedAt),
       entryPoint = Value(entryPoint),
       minutesToTarget = Value(minutesToTarget),
       status = Value(status);
  static Insertable<BedtimeSession> custom({
    Expression<String>? id,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? entryPoint,
    Expression<int>? minutesToTarget,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (entryPoint != null) 'entry_point': entryPoint,
      if (minutesToTarget != null) 'minutes_to_target': minutesToTarget,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BedtimeSessionsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<String>? entryPoint,
    Value<int>? minutesToTarget,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return BedtimeSessionsCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      entryPoint: entryPoint ?? this.entryPoint,
      minutesToTarget: minutesToTarget ?? this.minutesToTarget,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (entryPoint.present) {
      map['entry_point'] = Variable<String>(entryPoint.value);
    }
    if (minutesToTarget.present) {
      map['minutes_to_target'] = Variable<int>(minutesToTarget.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BedtimeSessionsCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('entryPoint: $entryPoint, ')
          ..write('minutesToTarget: $minutesToTarget, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$RhythmDatabase extends GeneratedDatabase {
  _$RhythmDatabase(QueryExecutor e) : super(e);
  $RhythmDatabaseManager get managers => $RhythmDatabaseManager(this);
  late final $GoalSchedulesTable goalSchedules = $GoalSchedulesTable(this);
  late final $SleepRecordsTable sleepRecords = $SleepRecordsTable(this);
  late final $BedtimeSessionsTable bedtimeSessions = $BedtimeSessionsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    goalSchedules,
    sleepRecords,
    bedtimeSessions,
  ];
}

typedef $$GoalSchedulesTableCreateCompanionBuilder =
    GoalSchedulesCompanion Function({
      required String id,
      required int targetBedtimeMinutes,
      required int targetWakeMinutes,
      required int lateThresholdMinutes,
      required int dayStartMinutes,
      Value<int> rowid,
    });
typedef $$GoalSchedulesTableUpdateCompanionBuilder =
    GoalSchedulesCompanion Function({
      Value<String> id,
      Value<int> targetBedtimeMinutes,
      Value<int> targetWakeMinutes,
      Value<int> lateThresholdMinutes,
      Value<int> dayStartMinutes,
      Value<int> rowid,
    });

class $$GoalSchedulesTableFilterComposer
    extends Composer<_$RhythmDatabase, $GoalSchedulesTable> {
  $$GoalSchedulesTableFilterComposer({
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

  ColumnFilters<int> get targetBedtimeMinutes => $composableBuilder(
    column: $table.targetBedtimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetWakeMinutes => $composableBuilder(
    column: $table.targetWakeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lateThresholdMinutes => $composableBuilder(
    column: $table.lateThresholdMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayStartMinutes => $composableBuilder(
    column: $table.dayStartMinutes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GoalSchedulesTableOrderingComposer
    extends Composer<_$RhythmDatabase, $GoalSchedulesTable> {
  $$GoalSchedulesTableOrderingComposer({
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

  ColumnOrderings<int> get targetBedtimeMinutes => $composableBuilder(
    column: $table.targetBedtimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetWakeMinutes => $composableBuilder(
    column: $table.targetWakeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lateThresholdMinutes => $composableBuilder(
    column: $table.lateThresholdMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayStartMinutes => $composableBuilder(
    column: $table.dayStartMinutes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalSchedulesTableAnnotationComposer
    extends Composer<_$RhythmDatabase, $GoalSchedulesTable> {
  $$GoalSchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get targetBedtimeMinutes => $composableBuilder(
    column: $table.targetBedtimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetWakeMinutes => $composableBuilder(
    column: $table.targetWakeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lateThresholdMinutes => $composableBuilder(
    column: $table.lateThresholdMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dayStartMinutes => $composableBuilder(
    column: $table.dayStartMinutes,
    builder: (column) => column,
  );
}

class $$GoalSchedulesTableTableManager
    extends
        RootTableManager<
          _$RhythmDatabase,
          $GoalSchedulesTable,
          GoalSchedule,
          $$GoalSchedulesTableFilterComposer,
          $$GoalSchedulesTableOrderingComposer,
          $$GoalSchedulesTableAnnotationComposer,
          $$GoalSchedulesTableCreateCompanionBuilder,
          $$GoalSchedulesTableUpdateCompanionBuilder,
          (
            GoalSchedule,
            BaseReferences<_$RhythmDatabase, $GoalSchedulesTable, GoalSchedule>,
          ),
          GoalSchedule,
          PrefetchHooks Function()
        > {
  $$GoalSchedulesTableTableManager(
    _$RhythmDatabase db,
    $GoalSchedulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalSchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalSchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalSchedulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> targetBedtimeMinutes = const Value.absent(),
                Value<int> targetWakeMinutes = const Value.absent(),
                Value<int> lateThresholdMinutes = const Value.absent(),
                Value<int> dayStartMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalSchedulesCompanion(
                id: id,
                targetBedtimeMinutes: targetBedtimeMinutes,
                targetWakeMinutes: targetWakeMinutes,
                lateThresholdMinutes: lateThresholdMinutes,
                dayStartMinutes: dayStartMinutes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int targetBedtimeMinutes,
                required int targetWakeMinutes,
                required int lateThresholdMinutes,
                required int dayStartMinutes,
                Value<int> rowid = const Value.absent(),
              }) => GoalSchedulesCompanion.insert(
                id: id,
                targetBedtimeMinutes: targetBedtimeMinutes,
                targetWakeMinutes: targetWakeMinutes,
                lateThresholdMinutes: lateThresholdMinutes,
                dayStartMinutes: dayStartMinutes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoalSchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$RhythmDatabase,
      $GoalSchedulesTable,
      GoalSchedule,
      $$GoalSchedulesTableFilterComposer,
      $$GoalSchedulesTableOrderingComposer,
      $$GoalSchedulesTableAnnotationComposer,
      $$GoalSchedulesTableCreateCompanionBuilder,
      $$GoalSchedulesTableUpdateCompanionBuilder,
      (
        GoalSchedule,
        BaseReferences<_$RhythmDatabase, $GoalSchedulesTable, GoalSchedule>,
      ),
      GoalSchedule,
      PrefetchHooks Function()
    >;
typedef $$SleepRecordsTableCreateCompanionBuilder =
    SleepRecordsCompanion Function({
      required String id,
      required DateTime recordDate,
      required DateTime fellAsleepAt,
      required DateTime wokeUpAt,
      required String source,
      required String confidence,
      required String timezone,
      Value<bool> isUserEdited,
      Value<int> rowid,
    });
typedef $$SleepRecordsTableUpdateCompanionBuilder =
    SleepRecordsCompanion Function({
      Value<String> id,
      Value<DateTime> recordDate,
      Value<DateTime> fellAsleepAt,
      Value<DateTime> wokeUpAt,
      Value<String> source,
      Value<String> confidence,
      Value<String> timezone,
      Value<bool> isUserEdited,
      Value<int> rowid,
    });

class $$SleepRecordsTableFilterComposer
    extends Composer<_$RhythmDatabase, $SleepRecordsTable> {
  $$SleepRecordsTableFilterComposer({
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

  ColumnFilters<DateTime> get recordDate => $composableBuilder(
    column: $table.recordDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fellAsleepAt => $composableBuilder(
    column: $table.fellAsleepAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get wokeUpAt => $composableBuilder(
    column: $table.wokeUpAt,
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

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUserEdited => $composableBuilder(
    column: $table.isUserEdited,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SleepRecordsTableOrderingComposer
    extends Composer<_$RhythmDatabase, $SleepRecordsTable> {
  $$SleepRecordsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get recordDate => $composableBuilder(
    column: $table.recordDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fellAsleepAt => $composableBuilder(
    column: $table.fellAsleepAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get wokeUpAt => $composableBuilder(
    column: $table.wokeUpAt,
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

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUserEdited => $composableBuilder(
    column: $table.isUserEdited,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SleepRecordsTableAnnotationComposer
    extends Composer<_$RhythmDatabase, $SleepRecordsTable> {
  $$SleepRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get recordDate => $composableBuilder(
    column: $table.recordDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fellAsleepAt => $composableBuilder(
    column: $table.fellAsleepAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get wokeUpAt =>
      $composableBuilder(column: $table.wokeUpAt, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<bool> get isUserEdited => $composableBuilder(
    column: $table.isUserEdited,
    builder: (column) => column,
  );
}

class $$SleepRecordsTableTableManager
    extends
        RootTableManager<
          _$RhythmDatabase,
          $SleepRecordsTable,
          SleepRecord,
          $$SleepRecordsTableFilterComposer,
          $$SleepRecordsTableOrderingComposer,
          $$SleepRecordsTableAnnotationComposer,
          $$SleepRecordsTableCreateCompanionBuilder,
          $$SleepRecordsTableUpdateCompanionBuilder,
          (
            SleepRecord,
            BaseReferences<_$RhythmDatabase, $SleepRecordsTable, SleepRecord>,
          ),
          SleepRecord,
          PrefetchHooks Function()
        > {
  $$SleepRecordsTableTableManager(_$RhythmDatabase db, $SleepRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> recordDate = const Value.absent(),
                Value<DateTime> fellAsleepAt = const Value.absent(),
                Value<DateTime> wokeUpAt = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> confidence = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<bool> isUserEdited = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SleepRecordsCompanion(
                id: id,
                recordDate: recordDate,
                fellAsleepAt: fellAsleepAt,
                wokeUpAt: wokeUpAt,
                source: source,
                confidence: confidence,
                timezone: timezone,
                isUserEdited: isUserEdited,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime recordDate,
                required DateTime fellAsleepAt,
                required DateTime wokeUpAt,
                required String source,
                required String confidence,
                required String timezone,
                Value<bool> isUserEdited = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SleepRecordsCompanion.insert(
                id: id,
                recordDate: recordDate,
                fellAsleepAt: fellAsleepAt,
                wokeUpAt: wokeUpAt,
                source: source,
                confidence: confidence,
                timezone: timezone,
                isUserEdited: isUserEdited,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SleepRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$RhythmDatabase,
      $SleepRecordsTable,
      SleepRecord,
      $$SleepRecordsTableFilterComposer,
      $$SleepRecordsTableOrderingComposer,
      $$SleepRecordsTableAnnotationComposer,
      $$SleepRecordsTableCreateCompanionBuilder,
      $$SleepRecordsTableUpdateCompanionBuilder,
      (
        SleepRecord,
        BaseReferences<_$RhythmDatabase, $SleepRecordsTable, SleepRecord>,
      ),
      SleepRecord,
      PrefetchHooks Function()
    >;
typedef $$BedtimeSessionsTableCreateCompanionBuilder =
    BedtimeSessionsCompanion Function({
      required String id,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
      required String entryPoint,
      required int minutesToTarget,
      required String status,
      Value<int> rowid,
    });
typedef $$BedtimeSessionsTableUpdateCompanionBuilder =
    BedtimeSessionsCompanion Function({
      Value<String> id,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<String> entryPoint,
      Value<int> minutesToTarget,
      Value<String> status,
      Value<int> rowid,
    });

class $$BedtimeSessionsTableFilterComposer
    extends Composer<_$RhythmDatabase, $BedtimeSessionsTable> {
  $$BedtimeSessionsTableFilterComposer({
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

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entryPoint => $composableBuilder(
    column: $table.entryPoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minutesToTarget => $composableBuilder(
    column: $table.minutesToTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BedtimeSessionsTableOrderingComposer
    extends Composer<_$RhythmDatabase, $BedtimeSessionsTable> {
  $$BedtimeSessionsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entryPoint => $composableBuilder(
    column: $table.entryPoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minutesToTarget => $composableBuilder(
    column: $table.minutesToTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BedtimeSessionsTableAnnotationComposer
    extends Composer<_$RhythmDatabase, $BedtimeSessionsTable> {
  $$BedtimeSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entryPoint => $composableBuilder(
    column: $table.entryPoint,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minutesToTarget => $composableBuilder(
    column: $table.minutesToTarget,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$BedtimeSessionsTableTableManager
    extends
        RootTableManager<
          _$RhythmDatabase,
          $BedtimeSessionsTable,
          BedtimeSession,
          $$BedtimeSessionsTableFilterComposer,
          $$BedtimeSessionsTableOrderingComposer,
          $$BedtimeSessionsTableAnnotationComposer,
          $$BedtimeSessionsTableCreateCompanionBuilder,
          $$BedtimeSessionsTableUpdateCompanionBuilder,
          (
            BedtimeSession,
            BaseReferences<
              _$RhythmDatabase,
              $BedtimeSessionsTable,
              BedtimeSession
            >,
          ),
          BedtimeSession,
          PrefetchHooks Function()
        > {
  $$BedtimeSessionsTableTableManager(
    _$RhythmDatabase db,
    $BedtimeSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BedtimeSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BedtimeSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BedtimeSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String> entryPoint = const Value.absent(),
                Value<int> minutesToTarget = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BedtimeSessionsCompanion(
                id: id,
                startedAt: startedAt,
                completedAt: completedAt,
                entryPoint: entryPoint,
                minutesToTarget: minutesToTarget,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                required String entryPoint,
                required int minutesToTarget,
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => BedtimeSessionsCompanion.insert(
                id: id,
                startedAt: startedAt,
                completedAt: completedAt,
                entryPoint: entryPoint,
                minutesToTarget: minutesToTarget,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BedtimeSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$RhythmDatabase,
      $BedtimeSessionsTable,
      BedtimeSession,
      $$BedtimeSessionsTableFilterComposer,
      $$BedtimeSessionsTableOrderingComposer,
      $$BedtimeSessionsTableAnnotationComposer,
      $$BedtimeSessionsTableCreateCompanionBuilder,
      $$BedtimeSessionsTableUpdateCompanionBuilder,
      (
        BedtimeSession,
        BaseReferences<_$RhythmDatabase, $BedtimeSessionsTable, BedtimeSession>,
      ),
      BedtimeSession,
      PrefetchHooks Function()
    >;

class $RhythmDatabaseManager {
  final _$RhythmDatabase _db;
  $RhythmDatabaseManager(this._db);
  $$GoalSchedulesTableTableManager get goalSchedules =>
      $$GoalSchedulesTableTableManager(_db, _db.goalSchedules);
  $$SleepRecordsTableTableManager get sleepRecords =>
      $$SleepRecordsTableTableManager(_db, _db.sleepRecords);
  $$BedtimeSessionsTableTableManager get bedtimeSessions =>
      $$BedtimeSessionsTableTableManager(_db, _db.bedtimeSessions);
}
