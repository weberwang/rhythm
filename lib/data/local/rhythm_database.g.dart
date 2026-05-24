// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rhythm_database.dart';

// ignore_for_file: type=lint
class $SleepRecordsTable extends SleepRecords
    with TableInfo<$SleepRecordsTable, SleepRecordEntry> {
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
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SleepRecordSource, String>
  source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<SleepRecordSource>($SleepRecordsTable.$convertersource);
  @override
  late final GeneratedColumnWithTypeConverter<SleepRecordConfidence, String>
  confidence =
      GeneratedColumn<String>(
        'confidence',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SleepRecordConfidence>(
        $SleepRecordsTable.$converterconfidence,
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
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_user_edited" IN (0, 1))',
    ),
  );
  static const VerificationMeta _sourceRecordIdMeta = const VerificationMeta(
    'sourceRecordId',
  );
  @override
  late final GeneratedColumn<String> sourceRecordId = GeneratedColumn<String>(
    'source_record_id',
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
    id,
    recordDate,
    fellAsleepAt,
    wokeUpAt,
    durationMinutes,
    source,
    confidence,
    timezone,
    isUserEdited,
    sourceRecordId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_records';
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
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
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
    } else if (isInserting) {
      context.missing(_isUserEditedMeta);
    }
    if (data.containsKey('source_record_id')) {
      context.handle(
        _sourceRecordIdMeta,
        sourceRecordId.isAcceptableOrUnknown(
          data['source_record_id']!,
          _sourceRecordIdMeta,
        ),
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepRecordEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepRecordEntry(
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
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      source: $SleepRecordsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      confidence: $SleepRecordsTable.$converterconfidence.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}confidence'],
        )!,
      ),
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      )!,
      isUserEdited: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_user_edited'],
      )!,
      sourceRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_record_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SleepRecordsTable createAlias(String alias) {
    return $SleepRecordsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SleepRecordSource, String, String>
  $convertersource = const EnumNameConverter<SleepRecordSource>(
    SleepRecordSource.values,
  );
  static JsonTypeConverter2<SleepRecordConfidence, String, String>
  $converterconfidence = const EnumNameConverter<SleepRecordConfidence>(
    SleepRecordConfidence.values,
  );
}

class SleepRecordEntry extends DataClass
    implements Insertable<SleepRecordEntry> {
  /// 记录主键，统一使用业务侧生成的稳定 id。
  final String id;

  /// 业务归属日，按项目定义的一天起始时间归档。
  final DateTime recordDate;

  /// 实际入睡时间。
  final DateTime fellAsleepAt;

  /// 实际起床时间。
  final DateTime wokeUpAt;

  /// 睡眠时长，单位为分钟。
  final int durationMinutes;

  /// 记录来源枚举。
  final SleepRecordSource source;

  /// 记录可信度枚举。
  final SleepRecordConfidence confidence;

  /// 记录发生时所在时区。
  final String timezone;

  /// 是否属于用户编辑结果。
  final bool isUserEdited;

  /// 若当前记录修正了原始系统记录，则保留被修正记录主键。
  final String? sourceRecordId;

  /// 创建时间。
  final DateTime createdAt;

  /// 更新时间。
  final DateTime updatedAt;
  const SleepRecordEntry({
    required this.id,
    required this.recordDate,
    required this.fellAsleepAt,
    required this.wokeUpAt,
    required this.durationMinutes,
    required this.source,
    required this.confidence,
    required this.timezone,
    required this.isUserEdited,
    this.sourceRecordId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['record_date'] = Variable<DateTime>(recordDate);
    map['fell_asleep_at'] = Variable<DateTime>(fellAsleepAt);
    map['woke_up_at'] = Variable<DateTime>(wokeUpAt);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    {
      map['source'] = Variable<String>(
        $SleepRecordsTable.$convertersource.toSql(source),
      );
    }
    {
      map['confidence'] = Variable<String>(
        $SleepRecordsTable.$converterconfidence.toSql(confidence),
      );
    }
    map['timezone'] = Variable<String>(timezone);
    map['is_user_edited'] = Variable<bool>(isUserEdited);
    if (!nullToAbsent || sourceRecordId != null) {
      map['source_record_id'] = Variable<String>(sourceRecordId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SleepRecordsCompanion toCompanion(bool nullToAbsent) {
    return SleepRecordsCompanion(
      id: Value(id),
      recordDate: Value(recordDate),
      fellAsleepAt: Value(fellAsleepAt),
      wokeUpAt: Value(wokeUpAt),
      durationMinutes: Value(durationMinutes),
      source: Value(source),
      confidence: Value(confidence),
      timezone: Value(timezone),
      isUserEdited: Value(isUserEdited),
      sourceRecordId: sourceRecordId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRecordId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SleepRecordEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepRecordEntry(
      id: serializer.fromJson<String>(json['id']),
      recordDate: serializer.fromJson<DateTime>(json['recordDate']),
      fellAsleepAt: serializer.fromJson<DateTime>(json['fellAsleepAt']),
      wokeUpAt: serializer.fromJson<DateTime>(json['wokeUpAt']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      source: $SleepRecordsTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      confidence: $SleepRecordsTable.$converterconfidence.fromJson(
        serializer.fromJson<String>(json['confidence']),
      ),
      timezone: serializer.fromJson<String>(json['timezone']),
      isUserEdited: serializer.fromJson<bool>(json['isUserEdited']),
      sourceRecordId: serializer.fromJson<String?>(json['sourceRecordId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
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
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'source': serializer.toJson<String>(
        $SleepRecordsTable.$convertersource.toJson(source),
      ),
      'confidence': serializer.toJson<String>(
        $SleepRecordsTable.$converterconfidence.toJson(confidence),
      ),
      'timezone': serializer.toJson<String>(timezone),
      'isUserEdited': serializer.toJson<bool>(isUserEdited),
      'sourceRecordId': serializer.toJson<String?>(sourceRecordId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SleepRecordEntry copyWith({
    String? id,
    DateTime? recordDate,
    DateTime? fellAsleepAt,
    DateTime? wokeUpAt,
    int? durationMinutes,
    SleepRecordSource? source,
    SleepRecordConfidence? confidence,
    String? timezone,
    bool? isUserEdited,
    Value<String?> sourceRecordId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SleepRecordEntry(
    id: id ?? this.id,
    recordDate: recordDate ?? this.recordDate,
    fellAsleepAt: fellAsleepAt ?? this.fellAsleepAt,
    wokeUpAt: wokeUpAt ?? this.wokeUpAt,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    source: source ?? this.source,
    confidence: confidence ?? this.confidence,
    timezone: timezone ?? this.timezone,
    isUserEdited: isUserEdited ?? this.isUserEdited,
    sourceRecordId: sourceRecordId.present
        ? sourceRecordId.value
        : this.sourceRecordId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SleepRecordEntry copyWithCompanion(SleepRecordsCompanion data) {
    return SleepRecordEntry(
      id: data.id.present ? data.id.value : this.id,
      recordDate: data.recordDate.present
          ? data.recordDate.value
          : this.recordDate,
      fellAsleepAt: data.fellAsleepAt.present
          ? data.fellAsleepAt.value
          : this.fellAsleepAt,
      wokeUpAt: data.wokeUpAt.present ? data.wokeUpAt.value : this.wokeUpAt,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      source: data.source.present ? data.source.value : this.source,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      isUserEdited: data.isUserEdited.present
          ? data.isUserEdited.value
          : this.isUserEdited,
      sourceRecordId: data.sourceRecordId.present
          ? data.sourceRecordId.value
          : this.sourceRecordId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepRecordEntry(')
          ..write('id: $id, ')
          ..write('recordDate: $recordDate, ')
          ..write('fellAsleepAt: $fellAsleepAt, ')
          ..write('wokeUpAt: $wokeUpAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('timezone: $timezone, ')
          ..write('isUserEdited: $isUserEdited, ')
          ..write('sourceRecordId: $sourceRecordId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recordDate,
    fellAsleepAt,
    wokeUpAt,
    durationMinutes,
    source,
    confidence,
    timezone,
    isUserEdited,
    sourceRecordId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepRecordEntry &&
          other.id == this.id &&
          other.recordDate == this.recordDate &&
          other.fellAsleepAt == this.fellAsleepAt &&
          other.wokeUpAt == this.wokeUpAt &&
          other.durationMinutes == this.durationMinutes &&
          other.source == this.source &&
          other.confidence == this.confidence &&
          other.timezone == this.timezone &&
          other.isUserEdited == this.isUserEdited &&
          other.sourceRecordId == this.sourceRecordId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SleepRecordsCompanion extends UpdateCompanion<SleepRecordEntry> {
  final Value<String> id;
  final Value<DateTime> recordDate;
  final Value<DateTime> fellAsleepAt;
  final Value<DateTime> wokeUpAt;
  final Value<int> durationMinutes;
  final Value<SleepRecordSource> source;
  final Value<SleepRecordConfidence> confidence;
  final Value<String> timezone;
  final Value<bool> isUserEdited;
  final Value<String?> sourceRecordId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SleepRecordsCompanion({
    this.id = const Value.absent(),
    this.recordDate = const Value.absent(),
    this.fellAsleepAt = const Value.absent(),
    this.wokeUpAt = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.source = const Value.absent(),
    this.confidence = const Value.absent(),
    this.timezone = const Value.absent(),
    this.isUserEdited = const Value.absent(),
    this.sourceRecordId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepRecordsCompanion.insert({
    required String id,
    required DateTime recordDate,
    required DateTime fellAsleepAt,
    required DateTime wokeUpAt,
    required int durationMinutes,
    required SleepRecordSource source,
    required SleepRecordConfidence confidence,
    required String timezone,
    required bool isUserEdited,
    this.sourceRecordId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       recordDate = Value(recordDate),
       fellAsleepAt = Value(fellAsleepAt),
       wokeUpAt = Value(wokeUpAt),
       durationMinutes = Value(durationMinutes),
       source = Value(source),
       confidence = Value(confidence),
       timezone = Value(timezone),
       isUserEdited = Value(isUserEdited),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SleepRecordEntry> custom({
    Expression<String>? id,
    Expression<DateTime>? recordDate,
    Expression<DateTime>? fellAsleepAt,
    Expression<DateTime>? wokeUpAt,
    Expression<int>? durationMinutes,
    Expression<String>? source,
    Expression<String>? confidence,
    Expression<String>? timezone,
    Expression<bool>? isUserEdited,
    Expression<String>? sourceRecordId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordDate != null) 'record_date': recordDate,
      if (fellAsleepAt != null) 'fell_asleep_at': fellAsleepAt,
      if (wokeUpAt != null) 'woke_up_at': wokeUpAt,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (source != null) 'source': source,
      if (confidence != null) 'confidence': confidence,
      if (timezone != null) 'timezone': timezone,
      if (isUserEdited != null) 'is_user_edited': isUserEdited,
      if (sourceRecordId != null) 'source_record_id': sourceRecordId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepRecordsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? recordDate,
    Value<DateTime>? fellAsleepAt,
    Value<DateTime>? wokeUpAt,
    Value<int>? durationMinutes,
    Value<SleepRecordSource>? source,
    Value<SleepRecordConfidence>? confidence,
    Value<String>? timezone,
    Value<bool>? isUserEdited,
    Value<String?>? sourceRecordId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SleepRecordsCompanion(
      id: id ?? this.id,
      recordDate: recordDate ?? this.recordDate,
      fellAsleepAt: fellAsleepAt ?? this.fellAsleepAt,
      wokeUpAt: wokeUpAt ?? this.wokeUpAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      source: source ?? this.source,
      confidence: confidence ?? this.confidence,
      timezone: timezone ?? this.timezone,
      isUserEdited: isUserEdited ?? this.isUserEdited,
      sourceRecordId: sourceRecordId ?? this.sourceRecordId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $SleepRecordsTable.$convertersource.toSql(source.value),
      );
    }
    if (confidence.present) {
      map['confidence'] = Variable<String>(
        $SleepRecordsTable.$converterconfidence.toSql(confidence.value),
      );
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (isUserEdited.present) {
      map['is_user_edited'] = Variable<bool>(isUserEdited.value);
    }
    if (sourceRecordId.present) {
      map['source_record_id'] = Variable<String>(sourceRecordId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
    return (StringBuffer('SleepRecordsCompanion(')
          ..write('id: $id, ')
          ..write('recordDate: $recordDate, ')
          ..write('fellAsleepAt: $fellAsleepAt, ')
          ..write('wokeUpAt: $wokeUpAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('timezone: $timezone, ')
          ..write('isUserEdited: $isUserEdited, ')
          ..write('sourceRecordId: $sourceRecordId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SleepDelayTagsTable extends SleepDelayTags
    with TableInfo<$SleepDelayTagsTable, SleepDelayTagEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepDelayTagsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tagsJsonMeta = const VerificationMeta(
    'tagsJson',
  );
  @override
  late final GeneratedColumn<String> tagsJson = GeneratedColumn<String>(
    'tags_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  List<GeneratedColumn> get $columns => [recordDate, tagsJson, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_delay_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepDelayTagEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('record_date')) {
      context.handle(
        _recordDateMeta,
        recordDate.isAcceptableOrUnknown(data['record_date']!, _recordDateMeta),
      );
    } else if (isInserting) {
      context.missing(_recordDateMeta);
    }
    if (data.containsKey('tags_json')) {
      context.handle(
        _tagsJsonMeta,
        tagsJson.isAcceptableOrUnknown(data['tags_json']!, _tagsJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_tagsJsonMeta);
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
  Set<GeneratedColumn> get $primaryKey => {recordDate};
  @override
  SleepDelayTagEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepDelayTagEntry(
      recordDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}record_date'],
      )!,
      tagsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SleepDelayTagsTable createAlias(String alias) {
    return $SleepDelayTagsTable(attachedDatabase, alias);
  }
}

class SleepDelayTagEntry extends DataClass
    implements Insertable<SleepDelayTagEntry> {
  /// 业务归属日，作为晚睡标签主键。
  final DateTime recordDate;

  /// 该日期下最终保存的标签 JSON 数组。
  final String tagsJson;

  /// 更新时间，便于后续同步或冲突判断。
  final DateTime updatedAt;
  const SleepDelayTagEntry({
    required this.recordDate,
    required this.tagsJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['record_date'] = Variable<DateTime>(recordDate);
    map['tags_json'] = Variable<String>(tagsJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SleepDelayTagsCompanion toCompanion(bool nullToAbsent) {
    return SleepDelayTagsCompanion(
      recordDate: Value(recordDate),
      tagsJson: Value(tagsJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory SleepDelayTagEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepDelayTagEntry(
      recordDate: serializer.fromJson<DateTime>(json['recordDate']),
      tagsJson: serializer.fromJson<String>(json['tagsJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'recordDate': serializer.toJson<DateTime>(recordDate),
      'tagsJson': serializer.toJson<String>(tagsJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SleepDelayTagEntry copyWith({
    DateTime? recordDate,
    String? tagsJson,
    DateTime? updatedAt,
  }) => SleepDelayTagEntry(
    recordDate: recordDate ?? this.recordDate,
    tagsJson: tagsJson ?? this.tagsJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SleepDelayTagEntry copyWithCompanion(SleepDelayTagsCompanion data) {
    return SleepDelayTagEntry(
      recordDate: data.recordDate.present
          ? data.recordDate.value
          : this.recordDate,
      tagsJson: data.tagsJson.present ? data.tagsJson.value : this.tagsJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepDelayTagEntry(')
          ..write('recordDate: $recordDate, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(recordDate, tagsJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepDelayTagEntry &&
          other.recordDate == this.recordDate &&
          other.tagsJson == this.tagsJson &&
          other.updatedAt == this.updatedAt);
}

class SleepDelayTagsCompanion extends UpdateCompanion<SleepDelayTagEntry> {
  final Value<DateTime> recordDate;
  final Value<String> tagsJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SleepDelayTagsCompanion({
    this.recordDate = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepDelayTagsCompanion.insert({
    required DateTime recordDate,
    required String tagsJson,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : recordDate = Value(recordDate),
       tagsJson = Value(tagsJson),
       updatedAt = Value(updatedAt);
  static Insertable<SleepDelayTagEntry> custom({
    Expression<DateTime>? recordDate,
    Expression<String>? tagsJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (recordDate != null) 'record_date': recordDate,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepDelayTagsCompanion copyWith({
    Value<DateTime>? recordDate,
    Value<String>? tagsJson,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SleepDelayTagsCompanion(
      recordDate: recordDate ?? this.recordDate,
      tagsJson: tagsJson ?? this.tagsJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (recordDate.present) {
      map['record_date'] = Variable<DateTime>(recordDate.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
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
    return (StringBuffer('SleepDelayTagsCompanion(')
          ..write('recordDate: $recordDate, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$RhythmDatabase extends GeneratedDatabase {
  _$RhythmDatabase(QueryExecutor e) : super(e);
  $RhythmDatabaseManager get managers => $RhythmDatabaseManager(this);
  late final $SleepRecordsTable sleepRecords = $SleepRecordsTable(this);
  late final $SleepDelayTagsTable sleepDelayTags = $SleepDelayTagsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sleepRecords,
    sleepDelayTags,
  ];
}

typedef $$SleepRecordsTableCreateCompanionBuilder =
    SleepRecordsCompanion Function({
      required String id,
      required DateTime recordDate,
      required DateTime fellAsleepAt,
      required DateTime wokeUpAt,
      required int durationMinutes,
      required SleepRecordSource source,
      required SleepRecordConfidence confidence,
      required String timezone,
      required bool isUserEdited,
      Value<String?> sourceRecordId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SleepRecordsTableUpdateCompanionBuilder =
    SleepRecordsCompanion Function({
      Value<String> id,
      Value<DateTime> recordDate,
      Value<DateTime> fellAsleepAt,
      Value<DateTime> wokeUpAt,
      Value<int> durationMinutes,
      Value<SleepRecordSource> source,
      Value<SleepRecordConfidence> confidence,
      Value<String> timezone,
      Value<bool> isUserEdited,
      Value<String?> sourceRecordId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
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

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SleepRecordSource, SleepRecordSource, String>
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    SleepRecordConfidence,
    SleepRecordConfidence,
    String
  >
  get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUserEdited => $composableBuilder(
    column: $table.isUserEdited,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRecordId => $composableBuilder(
    column: $table.sourceRecordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
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

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
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

  ColumnOrderings<String> get sourceRecordId => $composableBuilder(
    column: $table.sourceRecordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
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

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SleepRecordSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SleepRecordConfidence, String>
  get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<bool> get isUserEdited => $composableBuilder(
    column: $table.isUserEdited,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRecordId => $composableBuilder(
    column: $table.sourceRecordId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SleepRecordsTableTableManager
    extends
        RootTableManager<
          _$RhythmDatabase,
          $SleepRecordsTable,
          SleepRecordEntry,
          $$SleepRecordsTableFilterComposer,
          $$SleepRecordsTableOrderingComposer,
          $$SleepRecordsTableAnnotationComposer,
          $$SleepRecordsTableCreateCompanionBuilder,
          $$SleepRecordsTableUpdateCompanionBuilder,
          (
            SleepRecordEntry,
            BaseReferences<
              _$RhythmDatabase,
              $SleepRecordsTable,
              SleepRecordEntry
            >,
          ),
          SleepRecordEntry,
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
                Value<int> durationMinutes = const Value.absent(),
                Value<SleepRecordSource> source = const Value.absent(),
                Value<SleepRecordConfidence> confidence = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<bool> isUserEdited = const Value.absent(),
                Value<String?> sourceRecordId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SleepRecordsCompanion(
                id: id,
                recordDate: recordDate,
                fellAsleepAt: fellAsleepAt,
                wokeUpAt: wokeUpAt,
                durationMinutes: durationMinutes,
                source: source,
                confidence: confidence,
                timezone: timezone,
                isUserEdited: isUserEdited,
                sourceRecordId: sourceRecordId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime recordDate,
                required DateTime fellAsleepAt,
                required DateTime wokeUpAt,
                required int durationMinutes,
                required SleepRecordSource source,
                required SleepRecordConfidence confidence,
                required String timezone,
                required bool isUserEdited,
                Value<String?> sourceRecordId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SleepRecordsCompanion.insert(
                id: id,
                recordDate: recordDate,
                fellAsleepAt: fellAsleepAt,
                wokeUpAt: wokeUpAt,
                durationMinutes: durationMinutes,
                source: source,
                confidence: confidence,
                timezone: timezone,
                isUserEdited: isUserEdited,
                sourceRecordId: sourceRecordId,
                createdAt: createdAt,
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

typedef $$SleepRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$RhythmDatabase,
      $SleepRecordsTable,
      SleepRecordEntry,
      $$SleepRecordsTableFilterComposer,
      $$SleepRecordsTableOrderingComposer,
      $$SleepRecordsTableAnnotationComposer,
      $$SleepRecordsTableCreateCompanionBuilder,
      $$SleepRecordsTableUpdateCompanionBuilder,
      (
        SleepRecordEntry,
        BaseReferences<_$RhythmDatabase, $SleepRecordsTable, SleepRecordEntry>,
      ),
      SleepRecordEntry,
      PrefetchHooks Function()
    >;
typedef $$SleepDelayTagsTableCreateCompanionBuilder =
    SleepDelayTagsCompanion Function({
      required DateTime recordDate,
      required String tagsJson,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SleepDelayTagsTableUpdateCompanionBuilder =
    SleepDelayTagsCompanion Function({
      Value<DateTime> recordDate,
      Value<String> tagsJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SleepDelayTagsTableFilterComposer
    extends Composer<_$RhythmDatabase, $SleepDelayTagsTable> {
  $$SleepDelayTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get recordDate => $composableBuilder(
    column: $table.recordDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagsJson => $composableBuilder(
    column: $table.tagsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SleepDelayTagsTableOrderingComposer
    extends Composer<_$RhythmDatabase, $SleepDelayTagsTable> {
  $$SleepDelayTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get recordDate => $composableBuilder(
    column: $table.recordDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagsJson => $composableBuilder(
    column: $table.tagsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SleepDelayTagsTableAnnotationComposer
    extends Composer<_$RhythmDatabase, $SleepDelayTagsTable> {
  $$SleepDelayTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get recordDate => $composableBuilder(
    column: $table.recordDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagsJson =>
      $composableBuilder(column: $table.tagsJson, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SleepDelayTagsTableTableManager
    extends
        RootTableManager<
          _$RhythmDatabase,
          $SleepDelayTagsTable,
          SleepDelayTagEntry,
          $$SleepDelayTagsTableFilterComposer,
          $$SleepDelayTagsTableOrderingComposer,
          $$SleepDelayTagsTableAnnotationComposer,
          $$SleepDelayTagsTableCreateCompanionBuilder,
          $$SleepDelayTagsTableUpdateCompanionBuilder,
          (
            SleepDelayTagEntry,
            BaseReferences<
              _$RhythmDatabase,
              $SleepDelayTagsTable,
              SleepDelayTagEntry
            >,
          ),
          SleepDelayTagEntry,
          PrefetchHooks Function()
        > {
  $$SleepDelayTagsTableTableManager(
    _$RhythmDatabase db,
    $SleepDelayTagsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepDelayTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepDelayTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepDelayTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> recordDate = const Value.absent(),
                Value<String> tagsJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SleepDelayTagsCompanion(
                recordDate: recordDate,
                tagsJson: tagsJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime recordDate,
                required String tagsJson,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SleepDelayTagsCompanion.insert(
                recordDate: recordDate,
                tagsJson: tagsJson,
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

typedef $$SleepDelayTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$RhythmDatabase,
      $SleepDelayTagsTable,
      SleepDelayTagEntry,
      $$SleepDelayTagsTableFilterComposer,
      $$SleepDelayTagsTableOrderingComposer,
      $$SleepDelayTagsTableAnnotationComposer,
      $$SleepDelayTagsTableCreateCompanionBuilder,
      $$SleepDelayTagsTableUpdateCompanionBuilder,
      (
        SleepDelayTagEntry,
        BaseReferences<
          _$RhythmDatabase,
          $SleepDelayTagsTable,
          SleepDelayTagEntry
        >,
      ),
      SleepDelayTagEntry,
      PrefetchHooks Function()
    >;

class $RhythmDatabaseManager {
  final _$RhythmDatabase _db;
  $RhythmDatabaseManager(this._db);
  $$SleepRecordsTableTableManager get sleepRecords =>
      $$SleepRecordsTableTableManager(_db, _db.sleepRecords);
  $$SleepDelayTagsTableTableManager get sleepDelayTags =>
      $$SleepDelayTagsTableTableManager(_db, _db.sleepDelayTags);
}
