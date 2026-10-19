// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_base.dart';

// ignore_for_file: type=lint
class $GroupsTable extends Groups with TableInfo<$GroupsTable, Group> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 500,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<Group> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Group map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Group(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $GroupsTable createAlias(String alias) {
    return $GroupsTable(attachedDatabase, alias);
  }
}

class Group extends DataClass implements Insertable<Group>, ScheduleObject {
  final int id;
  final String name;
  const Group({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  GroupsCompanion toCompanion(bool nullToAbsent) {
    return GroupsCompanion(id: Value(id), name: Value(name));
  }

  factory Group.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Group(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Group copyWith({int? id, String? name}) =>
      Group(id: id ?? this.id, name: name ?? this.name);
  Group copyWithCompanion(GroupsCompanion data) {
    return Group(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Group(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Group && other.id == this.id && other.name == this.name);
}

class GroupsCompanion extends UpdateCompanion<Group> {
  final Value<int> id;
  final Value<String> name;
  const GroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  GroupsCompanion.insert({this.id = const Value.absent(), required String name})
    : name = Value(name);
  static Insertable<Group> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  GroupsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return GroupsCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $TeachersTable extends Teachers with TableInfo<$TeachersTable, Teacher> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeachersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 500,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teachers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Teacher> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Teacher map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Teacher(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $TeachersTable createAlias(String alias) {
    return $TeachersTable(attachedDatabase, alias);
  }
}

class Teacher extends DataClass implements Insertable<Teacher>, ScheduleObject {
  final int id;
  final String name;
  const Teacher({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  TeachersCompanion toCompanion(bool nullToAbsent) {
    return TeachersCompanion(id: Value(id), name: Value(name));
  }

  factory Teacher.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Teacher(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Teacher copyWith({int? id, String? name}) =>
      Teacher(id: id ?? this.id, name: name ?? this.name);
  Teacher copyWithCompanion(TeachersCompanion data) {
    return Teacher(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Teacher(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Teacher && other.id == this.id && other.name == this.name);
}

class TeachersCompanion extends UpdateCompanion<Teacher> {
  final Value<int> id;
  final Value<String> name;
  const TeachersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  TeachersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Teacher> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  TeachersCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return TeachersCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeachersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $CallsTable extends Calls with TableInfo<$CallsTable, Call> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CallsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _weekdayMeta = const VerificationMeta(
    'weekday',
  );
  @override
  late final GeneratedColumn<int> weekday = GeneratedColumn<int>(
    'weekday',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<int> time = GeneratedColumn<int>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeStartMeta = const VerificationMeta(
    'timeStart',
  );
  @override
  late final GeneratedColumn<String> timeStart = GeneratedColumn<String>(
    'time_start',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 500,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeEndMeta = const VerificationMeta(
    'timeEnd',
  );
  @override
  late final GeneratedColumn<String> timeEnd = GeneratedColumn<String>(
    'time_end',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 500,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [weekday, time, timeStart, timeEnd];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calls';
  @override
  VerificationContext validateIntegrity(
    Insertable<Call> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('weekday')) {
      context.handle(
        _weekdayMeta,
        weekday.isAcceptableOrUnknown(data['weekday']!, _weekdayMeta),
      );
    } else if (isInserting) {
      context.missing(_weekdayMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('time_start')) {
      context.handle(
        _timeStartMeta,
        timeStart.isAcceptableOrUnknown(data['time_start']!, _timeStartMeta),
      );
    } else if (isInserting) {
      context.missing(_timeStartMeta);
    }
    if (data.containsKey('time_end')) {
      context.handle(
        _timeEndMeta,
        timeEnd.isAcceptableOrUnknown(data['time_end']!, _timeEndMeta),
      );
    } else if (isInserting) {
      context.missing(_timeEndMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {weekday, time};
  @override
  Call map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Call(
      weekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekday'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time'],
      )!,
      timeStart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_start'],
      )!,
      timeEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_end'],
      )!,
    );
  }

  @override
  $CallsTable createAlias(String alias) {
    return $CallsTable(attachedDatabase, alias);
  }
}

class Call extends DataClass implements Insertable<Call> {
  final int weekday;
  final int time;
  final String timeStart;
  final String timeEnd;
  const Call({
    required this.weekday,
    required this.time,
    required this.timeStart,
    required this.timeEnd,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['weekday'] = Variable<int>(weekday);
    map['time'] = Variable<int>(time);
    map['time_start'] = Variable<String>(timeStart);
    map['time_end'] = Variable<String>(timeEnd);
    return map;
  }

  CallsCompanion toCompanion(bool nullToAbsent) {
    return CallsCompanion(
      weekday: Value(weekday),
      time: Value(time),
      timeStart: Value(timeStart),
      timeEnd: Value(timeEnd),
    );
  }

  factory Call.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Call(
      weekday: serializer.fromJson<int>(json['weekday']),
      time: serializer.fromJson<int>(json['time']),
      timeStart: serializer.fromJson<String>(json['timeStart']),
      timeEnd: serializer.fromJson<String>(json['timeEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'weekday': serializer.toJson<int>(weekday),
      'time': serializer.toJson<int>(time),
      'timeStart': serializer.toJson<String>(timeStart),
      'timeEnd': serializer.toJson<String>(timeEnd),
    };
  }

  Call copyWith({
    int? weekday,
    int? time,
    String? timeStart,
    String? timeEnd,
  }) => Call(
    weekday: weekday ?? this.weekday,
    time: time ?? this.time,
    timeStart: timeStart ?? this.timeStart,
    timeEnd: timeEnd ?? this.timeEnd,
  );
  Call copyWithCompanion(CallsCompanion data) {
    return Call(
      weekday: data.weekday.present ? data.weekday.value : this.weekday,
      time: data.time.present ? data.time.value : this.time,
      timeStart: data.timeStart.present ? data.timeStart.value : this.timeStart,
      timeEnd: data.timeEnd.present ? data.timeEnd.value : this.timeEnd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Call(')
          ..write('weekday: $weekday, ')
          ..write('time: $time, ')
          ..write('timeStart: $timeStart, ')
          ..write('timeEnd: $timeEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(weekday, time, timeStart, timeEnd);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Call &&
          other.weekday == this.weekday &&
          other.time == this.time &&
          other.timeStart == this.timeStart &&
          other.timeEnd == this.timeEnd);
}

class CallsCompanion extends UpdateCompanion<Call> {
  final Value<int> weekday;
  final Value<int> time;
  final Value<String> timeStart;
  final Value<String> timeEnd;
  final Value<int> rowid;
  const CallsCompanion({
    this.weekday = const Value.absent(),
    this.time = const Value.absent(),
    this.timeStart = const Value.absent(),
    this.timeEnd = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CallsCompanion.insert({
    required int weekday,
    required int time,
    required String timeStart,
    required String timeEnd,
    this.rowid = const Value.absent(),
  }) : weekday = Value(weekday),
       time = Value(time),
       timeStart = Value(timeStart),
       timeEnd = Value(timeEnd);
  static Insertable<Call> custom({
    Expression<int>? weekday,
    Expression<int>? time,
    Expression<String>? timeStart,
    Expression<String>? timeEnd,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (weekday != null) 'weekday': weekday,
      if (time != null) 'time': time,
      if (timeStart != null) 'time_start': timeStart,
      if (timeEnd != null) 'time_end': timeEnd,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CallsCompanion copyWith({
    Value<int>? weekday,
    Value<int>? time,
    Value<String>? timeStart,
    Value<String>? timeEnd,
    Value<int>? rowid,
  }) {
    return CallsCompanion(
      weekday: weekday ?? this.weekday,
      time: time ?? this.time,
      timeStart: timeStart ?? this.timeStart,
      timeEnd: timeEnd ?? this.timeEnd,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (weekday.present) {
      map['weekday'] = Variable<int>(weekday.value);
    }
    if (time.present) {
      map['time'] = Variable<int>(time.value);
    }
    if (timeStart.present) {
      map['time_start'] = Variable<String>(timeStart.value);
    }
    if (timeEnd.present) {
      map['time_end'] = Variable<String>(timeEnd.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CallsCompanion(')
          ..write('weekday: $weekday, ')
          ..write('time: $time, ')
          ..write('timeStart: $timeStart, ')
          ..write('timeEnd: $timeEnd, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CouplesTable extends Couples with TableInfo<$CouplesTable, Couple> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CouplesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 500,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subgroupMeta = const VerificationMeta(
    'subgroup',
  );
  @override
  late final GeneratedColumn<int> subgroup = GeneratedColumn<int>(
    'subgroup',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekMeta = const VerificationMeta('week');
  @override
  late final GeneratedColumn<int> week = GeneratedColumn<int>(
    'week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekDayMeta = const VerificationMeta(
    'weekDay',
  );
  @override
  late final GeneratedColumn<int> weekDay = GeneratedColumn<int>(
    'week_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES "groups" (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lessonWeekdayMeta = const VerificationMeta(
    'lessonWeekday',
  );
  @override
  late final GeneratedColumn<int> lessonWeekday = GeneratedColumn<int>(
    'lesson_weekday',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lessonTimeMeta = const VerificationMeta(
    'lessonTime',
  );
  @override
  late final GeneratedColumn<int> lessonTime = GeneratedColumn<int>(
    'lesson_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subject,
    subgroup,
    week,
    weekDay,
    groupId,
    date,
    lessonWeekday,
    lessonTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'couples';
  @override
  VerificationContext validateIntegrity(
    Insertable<Couple> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectMeta);
    }
    if (data.containsKey('subgroup')) {
      context.handle(
        _subgroupMeta,
        subgroup.isAcceptableOrUnknown(data['subgroup']!, _subgroupMeta),
      );
    } else if (isInserting) {
      context.missing(_subgroupMeta);
    }
    if (data.containsKey('week')) {
      context.handle(
        _weekMeta,
        week.isAcceptableOrUnknown(data['week']!, _weekMeta),
      );
    } else if (isInserting) {
      context.missing(_weekMeta);
    }
    if (data.containsKey('week_day')) {
      context.handle(
        _weekDayMeta,
        weekDay.isAcceptableOrUnknown(data['week_day']!, _weekDayMeta),
      );
    } else if (isInserting) {
      context.missing(_weekDayMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('lesson_weekday')) {
      context.handle(
        _lessonWeekdayMeta,
        lessonWeekday.isAcceptableOrUnknown(
          data['lesson_weekday']!,
          _lessonWeekdayMeta,
        ),
      );
    }
    if (data.containsKey('lesson_time')) {
      context.handle(
        _lessonTimeMeta,
        lessonTime.isAcceptableOrUnknown(data['lesson_time']!, _lessonTimeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Couple map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Couple(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      )!,
      subgroup: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subgroup'],
      )!,
      week: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week'],
      )!,
      weekDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_day'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      lessonWeekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lesson_weekday'],
      ),
      lessonTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lesson_time'],
      ),
    );
  }

  @override
  $CouplesTable createAlias(String alias) {
    return $CouplesTable(attachedDatabase, alias);
  }
}

class Couple extends DataClass implements Insertable<Couple> {
  final int id;
  final String subject;
  final int subgroup;
  final int week;
  final int weekDay;
  final int? groupId;
  final DateTime date;
  final int? lessonWeekday;
  final int? lessonTime;
  const Couple({
    required this.id,
    required this.subject,
    required this.subgroup,
    required this.week,
    required this.weekDay,
    this.groupId,
    required this.date,
    this.lessonWeekday,
    this.lessonTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subject'] = Variable<String>(subject);
    map['subgroup'] = Variable<int>(subgroup);
    map['week'] = Variable<int>(week);
    map['week_day'] = Variable<int>(weekDay);
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<int>(groupId);
    }
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || lessonWeekday != null) {
      map['lesson_weekday'] = Variable<int>(lessonWeekday);
    }
    if (!nullToAbsent || lessonTime != null) {
      map['lesson_time'] = Variable<int>(lessonTime);
    }
    return map;
  }

  CouplesCompanion toCompanion(bool nullToAbsent) {
    return CouplesCompanion(
      id: Value(id),
      subject: Value(subject),
      subgroup: Value(subgroup),
      week: Value(week),
      weekDay: Value(weekDay),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      date: Value(date),
      lessonWeekday: lessonWeekday == null && nullToAbsent
          ? const Value.absent()
          : Value(lessonWeekday),
      lessonTime: lessonTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lessonTime),
    );
  }

  factory Couple.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Couple(
      id: serializer.fromJson<int>(json['id']),
      subject: serializer.fromJson<String>(json['subject']),
      subgroup: serializer.fromJson<int>(json['subgroup']),
      week: serializer.fromJson<int>(json['week']),
      weekDay: serializer.fromJson<int>(json['weekDay']),
      groupId: serializer.fromJson<int?>(json['groupId']),
      date: serializer.fromJson<DateTime>(json['date']),
      lessonWeekday: serializer.fromJson<int?>(json['lessonWeekday']),
      lessonTime: serializer.fromJson<int?>(json['lessonTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subject': serializer.toJson<String>(subject),
      'subgroup': serializer.toJson<int>(subgroup),
      'week': serializer.toJson<int>(week),
      'weekDay': serializer.toJson<int>(weekDay),
      'groupId': serializer.toJson<int?>(groupId),
      'date': serializer.toJson<DateTime>(date),
      'lessonWeekday': serializer.toJson<int?>(lessonWeekday),
      'lessonTime': serializer.toJson<int?>(lessonTime),
    };
  }

  Couple copyWith({
    int? id,
    String? subject,
    int? subgroup,
    int? week,
    int? weekDay,
    Value<int?> groupId = const Value.absent(),
    DateTime? date,
    Value<int?> lessonWeekday = const Value.absent(),
    Value<int?> lessonTime = const Value.absent(),
  }) => Couple(
    id: id ?? this.id,
    subject: subject ?? this.subject,
    subgroup: subgroup ?? this.subgroup,
    week: week ?? this.week,
    weekDay: weekDay ?? this.weekDay,
    groupId: groupId.present ? groupId.value : this.groupId,
    date: date ?? this.date,
    lessonWeekday: lessonWeekday.present
        ? lessonWeekday.value
        : this.lessonWeekday,
    lessonTime: lessonTime.present ? lessonTime.value : this.lessonTime,
  );
  Couple copyWithCompanion(CouplesCompanion data) {
    return Couple(
      id: data.id.present ? data.id.value : this.id,
      subject: data.subject.present ? data.subject.value : this.subject,
      subgroup: data.subgroup.present ? data.subgroup.value : this.subgroup,
      week: data.week.present ? data.week.value : this.week,
      weekDay: data.weekDay.present ? data.weekDay.value : this.weekDay,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      date: data.date.present ? data.date.value : this.date,
      lessonWeekday: data.lessonWeekday.present
          ? data.lessonWeekday.value
          : this.lessonWeekday,
      lessonTime: data.lessonTime.present
          ? data.lessonTime.value
          : this.lessonTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Couple(')
          ..write('id: $id, ')
          ..write('subject: $subject, ')
          ..write('subgroup: $subgroup, ')
          ..write('week: $week, ')
          ..write('weekDay: $weekDay, ')
          ..write('groupId: $groupId, ')
          ..write('date: $date, ')
          ..write('lessonWeekday: $lessonWeekday, ')
          ..write('lessonTime: $lessonTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subject,
    subgroup,
    week,
    weekDay,
    groupId,
    date,
    lessonWeekday,
    lessonTime,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Couple &&
          other.id == this.id &&
          other.subject == this.subject &&
          other.subgroup == this.subgroup &&
          other.week == this.week &&
          other.weekDay == this.weekDay &&
          other.groupId == this.groupId &&
          other.date == this.date &&
          other.lessonWeekday == this.lessonWeekday &&
          other.lessonTime == this.lessonTime);
}

class CouplesCompanion extends UpdateCompanion<Couple> {
  final Value<int> id;
  final Value<String> subject;
  final Value<int> subgroup;
  final Value<int> week;
  final Value<int> weekDay;
  final Value<int?> groupId;
  final Value<DateTime> date;
  final Value<int?> lessonWeekday;
  final Value<int?> lessonTime;
  const CouplesCompanion({
    this.id = const Value.absent(),
    this.subject = const Value.absent(),
    this.subgroup = const Value.absent(),
    this.week = const Value.absent(),
    this.weekDay = const Value.absent(),
    this.groupId = const Value.absent(),
    this.date = const Value.absent(),
    this.lessonWeekday = const Value.absent(),
    this.lessonTime = const Value.absent(),
  });
  CouplesCompanion.insert({
    this.id = const Value.absent(),
    required String subject,
    required int subgroup,
    required int week,
    required int weekDay,
    this.groupId = const Value.absent(),
    required DateTime date,
    this.lessonWeekday = const Value.absent(),
    this.lessonTime = const Value.absent(),
  }) : subject = Value(subject),
       subgroup = Value(subgroup),
       week = Value(week),
       weekDay = Value(weekDay),
       date = Value(date);
  static Insertable<Couple> custom({
    Expression<int>? id,
    Expression<String>? subject,
    Expression<int>? subgroup,
    Expression<int>? week,
    Expression<int>? weekDay,
    Expression<int>? groupId,
    Expression<DateTime>? date,
    Expression<int>? lessonWeekday,
    Expression<int>? lessonTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subject != null) 'subject': subject,
      if (subgroup != null) 'subgroup': subgroup,
      if (week != null) 'week': week,
      if (weekDay != null) 'week_day': weekDay,
      if (groupId != null) 'group_id': groupId,
      if (date != null) 'date': date,
      if (lessonWeekday != null) 'lesson_weekday': lessonWeekday,
      if (lessonTime != null) 'lesson_time': lessonTime,
    });
  }

  CouplesCompanion copyWith({
    Value<int>? id,
    Value<String>? subject,
    Value<int>? subgroup,
    Value<int>? week,
    Value<int>? weekDay,
    Value<int?>? groupId,
    Value<DateTime>? date,
    Value<int?>? lessonWeekday,
    Value<int?>? lessonTime,
  }) {
    return CouplesCompanion(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      subgroup: subgroup ?? this.subgroup,
      week: week ?? this.week,
      weekDay: weekDay ?? this.weekDay,
      groupId: groupId ?? this.groupId,
      date: date ?? this.date,
      lessonWeekday: lessonWeekday ?? this.lessonWeekday,
      lessonTime: lessonTime ?? this.lessonTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (subgroup.present) {
      map['subgroup'] = Variable<int>(subgroup.value);
    }
    if (week.present) {
      map['week'] = Variable<int>(week.value);
    }
    if (weekDay.present) {
      map['week_day'] = Variable<int>(weekDay.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (lessonWeekday.present) {
      map['lesson_weekday'] = Variable<int>(lessonWeekday.value);
    }
    if (lessonTime.present) {
      map['lesson_time'] = Variable<int>(lessonTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CouplesCompanion(')
          ..write('id: $id, ')
          ..write('subject: $subject, ')
          ..write('subgroup: $subgroup, ')
          ..write('week: $week, ')
          ..write('weekDay: $weekDay, ')
          ..write('groupId: $groupId, ')
          ..write('date: $date, ')
          ..write('lessonWeekday: $lessonWeekday, ')
          ..write('lessonTime: $lessonTime')
          ..write(')'))
        .toString();
  }
}

class $AuditoriesTable extends Auditories
    with TableInfo<$AuditoriesTable, Auditory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 500,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'auditories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Auditory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Auditory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Auditory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $AuditoriesTable createAlias(String alias) {
    return $AuditoriesTable(attachedDatabase, alias);
  }
}

class Auditory extends DataClass
    implements Insertable<Auditory>, ScheduleObject {
  final int id;
  final String name;
  const Auditory({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  AuditoriesCompanion toCompanion(bool nullToAbsent) {
    return AuditoriesCompanion(id: Value(id), name: Value(name));
  }

  factory Auditory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Auditory(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Auditory copyWith({int? id, String? name}) =>
      Auditory(id: id ?? this.id, name: name ?? this.name);
  Auditory copyWithCompanion(AuditoriesCompanion data) {
    return Auditory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Auditory(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Auditory && other.id == this.id && other.name == this.name);
}

class AuditoriesCompanion extends UpdateCompanion<Auditory> {
  final Value<int> id;
  final Value<String> name;
  const AuditoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  AuditoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Auditory> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  AuditoriesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return AuditoriesCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $CoupleSubgroupsTable extends CoupleSubgroups
    with TableInfo<$CoupleSubgroupsTable, CoupleSubgroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoupleSubgroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _coupleIdMeta = const VerificationMeta(
    'coupleId',
  );
  @override
  late final GeneratedColumn<int> coupleId = GeneratedColumn<int>(
    'couple_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES couples (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _auditoryIdMeta = const VerificationMeta(
    'auditoryId',
  );
  @override
  late final GeneratedColumn<int> auditoryId = GeneratedColumn<int>(
    'auditory_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES auditories (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _teacherIdMeta = const VerificationMeta(
    'teacherId',
  );
  @override
  late final GeneratedColumn<int> teacherId = GeneratedColumn<int>(
    'teacher_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES teachers (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES "groups" (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    coupleId,
    auditoryId,
    teacherId,
    groupId,
    number,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'couple_subgroups';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoupleSubgroup> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('couple_id')) {
      context.handle(
        _coupleIdMeta,
        coupleId.isAcceptableOrUnknown(data['couple_id']!, _coupleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_coupleIdMeta);
    }
    if (data.containsKey('auditory_id')) {
      context.handle(
        _auditoryIdMeta,
        auditoryId.isAcceptableOrUnknown(data['auditory_id']!, _auditoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_auditoryIdMeta);
    }
    if (data.containsKey('teacher_id')) {
      context.handle(
        _teacherIdMeta,
        teacherId.isAcceptableOrUnknown(data['teacher_id']!, _teacherIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teacherIdMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    coupleId,
    auditoryId,
    teacherId,
    groupId,
  };
  @override
  CoupleSubgroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoupleSubgroup(
      coupleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}couple_id'],
      )!,
      auditoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}auditory_id'],
      )!,
      teacherId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}teacher_id'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number'],
      )!,
    );
  }

  @override
  $CoupleSubgroupsTable createAlias(String alias) {
    return $CoupleSubgroupsTable(attachedDatabase, alias);
  }
}

class CoupleSubgroup extends DataClass implements Insertable<CoupleSubgroup> {
  final int coupleId;
  final int auditoryId;
  final int teacherId;
  final int groupId;
  final int number;
  const CoupleSubgroup({
    required this.coupleId,
    required this.auditoryId,
    required this.teacherId,
    required this.groupId,
    required this.number,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['couple_id'] = Variable<int>(coupleId);
    map['auditory_id'] = Variable<int>(auditoryId);
    map['teacher_id'] = Variable<int>(teacherId);
    map['group_id'] = Variable<int>(groupId);
    map['number'] = Variable<int>(number);
    return map;
  }

  CoupleSubgroupsCompanion toCompanion(bool nullToAbsent) {
    return CoupleSubgroupsCompanion(
      coupleId: Value(coupleId),
      auditoryId: Value(auditoryId),
      teacherId: Value(teacherId),
      groupId: Value(groupId),
      number: Value(number),
    );
  }

  factory CoupleSubgroup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoupleSubgroup(
      coupleId: serializer.fromJson<int>(json['coupleId']),
      auditoryId: serializer.fromJson<int>(json['auditoryId']),
      teacherId: serializer.fromJson<int>(json['teacherId']),
      groupId: serializer.fromJson<int>(json['groupId']),
      number: serializer.fromJson<int>(json['number']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'coupleId': serializer.toJson<int>(coupleId),
      'auditoryId': serializer.toJson<int>(auditoryId),
      'teacherId': serializer.toJson<int>(teacherId),
      'groupId': serializer.toJson<int>(groupId),
      'number': serializer.toJson<int>(number),
    };
  }

  CoupleSubgroup copyWith({
    int? coupleId,
    int? auditoryId,
    int? teacherId,
    int? groupId,
    int? number,
  }) => CoupleSubgroup(
    coupleId: coupleId ?? this.coupleId,
    auditoryId: auditoryId ?? this.auditoryId,
    teacherId: teacherId ?? this.teacherId,
    groupId: groupId ?? this.groupId,
    number: number ?? this.number,
  );
  CoupleSubgroup copyWithCompanion(CoupleSubgroupsCompanion data) {
    return CoupleSubgroup(
      coupleId: data.coupleId.present ? data.coupleId.value : this.coupleId,
      auditoryId: data.auditoryId.present
          ? data.auditoryId.value
          : this.auditoryId,
      teacherId: data.teacherId.present ? data.teacherId.value : this.teacherId,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      number: data.number.present ? data.number.value : this.number,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoupleSubgroup(')
          ..write('coupleId: $coupleId, ')
          ..write('auditoryId: $auditoryId, ')
          ..write('teacherId: $teacherId, ')
          ..write('groupId: $groupId, ')
          ..write('number: $number')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(coupleId, auditoryId, teacherId, groupId, number);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoupleSubgroup &&
          other.coupleId == this.coupleId &&
          other.auditoryId == this.auditoryId &&
          other.teacherId == this.teacherId &&
          other.groupId == this.groupId &&
          other.number == this.number);
}

class CoupleSubgroupsCompanion extends UpdateCompanion<CoupleSubgroup> {
  final Value<int> coupleId;
  final Value<int> auditoryId;
  final Value<int> teacherId;
  final Value<int> groupId;
  final Value<int> number;
  final Value<int> rowid;
  const CoupleSubgroupsCompanion({
    this.coupleId = const Value.absent(),
    this.auditoryId = const Value.absent(),
    this.teacherId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.number = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoupleSubgroupsCompanion.insert({
    required int coupleId,
    required int auditoryId,
    required int teacherId,
    required int groupId,
    required int number,
    this.rowid = const Value.absent(),
  }) : coupleId = Value(coupleId),
       auditoryId = Value(auditoryId),
       teacherId = Value(teacherId),
       groupId = Value(groupId),
       number = Value(number);
  static Insertable<CoupleSubgroup> custom({
    Expression<int>? coupleId,
    Expression<int>? auditoryId,
    Expression<int>? teacherId,
    Expression<int>? groupId,
    Expression<int>? number,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (coupleId != null) 'couple_id': coupleId,
      if (auditoryId != null) 'auditory_id': auditoryId,
      if (teacherId != null) 'teacher_id': teacherId,
      if (groupId != null) 'group_id': groupId,
      if (number != null) 'number': number,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoupleSubgroupsCompanion copyWith({
    Value<int>? coupleId,
    Value<int>? auditoryId,
    Value<int>? teacherId,
    Value<int>? groupId,
    Value<int>? number,
    Value<int>? rowid,
  }) {
    return CoupleSubgroupsCompanion(
      coupleId: coupleId ?? this.coupleId,
      auditoryId: auditoryId ?? this.auditoryId,
      teacherId: teacherId ?? this.teacherId,
      groupId: groupId ?? this.groupId,
      number: number ?? this.number,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (coupleId.present) {
      map['couple_id'] = Variable<int>(coupleId.value);
    }
    if (auditoryId.present) {
      map['auditory_id'] = Variable<int>(auditoryId.value);
    }
    if (teacherId.present) {
      map['teacher_id'] = Variable<int>(teacherId.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoupleSubgroupsCompanion(')
          ..write('coupleId: $coupleId, ')
          ..write('auditoryId: $auditoryId, ')
          ..write('teacherId: $teacherId, ')
          ..write('groupId: $groupId, ')
          ..write('number: $number, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CoupleCallsTable extends CoupleCalls
    with TableInfo<$CoupleCallsTable, CoupleCall> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoupleCallsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _coupleIdMeta = const VerificationMeta(
    'coupleId',
  );
  @override
  late final GeneratedColumn<int> coupleId = GeneratedColumn<int>(
    'couple_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES couples (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _lessonWeekdayMeta = const VerificationMeta(
    'lessonWeekday',
  );
  @override
  late final GeneratedColumn<int> lessonWeekday = GeneratedColumn<int>(
    'lesson_weekday',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lessonTimeMeta = const VerificationMeta(
    'lessonTime',
  );
  @override
  late final GeneratedColumn<int> lessonTime = GeneratedColumn<int>(
    'lesson_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [coupleId, lessonWeekday, lessonTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'couple_calls';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoupleCall> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('couple_id')) {
      context.handle(
        _coupleIdMeta,
        coupleId.isAcceptableOrUnknown(data['couple_id']!, _coupleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_coupleIdMeta);
    }
    if (data.containsKey('lesson_weekday')) {
      context.handle(
        _lessonWeekdayMeta,
        lessonWeekday.isAcceptableOrUnknown(
          data['lesson_weekday']!,
          _lessonWeekdayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lessonWeekdayMeta);
    }
    if (data.containsKey('lesson_time')) {
      context.handle(
        _lessonTimeMeta,
        lessonTime.isAcceptableOrUnknown(data['lesson_time']!, _lessonTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {coupleId, lessonWeekday, lessonTime};
  @override
  CoupleCall map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoupleCall(
      coupleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}couple_id'],
      )!,
      lessonWeekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lesson_weekday'],
      )!,
      lessonTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lesson_time'],
      )!,
    );
  }

  @override
  $CoupleCallsTable createAlias(String alias) {
    return $CoupleCallsTable(attachedDatabase, alias);
  }
}

class CoupleCall extends DataClass implements Insertable<CoupleCall> {
  final int coupleId;
  final int lessonWeekday;
  final int lessonTime;
  const CoupleCall({
    required this.coupleId,
    required this.lessonWeekday,
    required this.lessonTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['couple_id'] = Variable<int>(coupleId);
    map['lesson_weekday'] = Variable<int>(lessonWeekday);
    map['lesson_time'] = Variable<int>(lessonTime);
    return map;
  }

  CoupleCallsCompanion toCompanion(bool nullToAbsent) {
    return CoupleCallsCompanion(
      coupleId: Value(coupleId),
      lessonWeekday: Value(lessonWeekday),
      lessonTime: Value(lessonTime),
    );
  }

  factory CoupleCall.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoupleCall(
      coupleId: serializer.fromJson<int>(json['coupleId']),
      lessonWeekday: serializer.fromJson<int>(json['lessonWeekday']),
      lessonTime: serializer.fromJson<int>(json['lessonTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'coupleId': serializer.toJson<int>(coupleId),
      'lessonWeekday': serializer.toJson<int>(lessonWeekday),
      'lessonTime': serializer.toJson<int>(lessonTime),
    };
  }

  CoupleCall copyWith({int? coupleId, int? lessonWeekday, int? lessonTime}) =>
      CoupleCall(
        coupleId: coupleId ?? this.coupleId,
        lessonWeekday: lessonWeekday ?? this.lessonWeekday,
        lessonTime: lessonTime ?? this.lessonTime,
      );
  CoupleCall copyWithCompanion(CoupleCallsCompanion data) {
    return CoupleCall(
      coupleId: data.coupleId.present ? data.coupleId.value : this.coupleId,
      lessonWeekday: data.lessonWeekday.present
          ? data.lessonWeekday.value
          : this.lessonWeekday,
      lessonTime: data.lessonTime.present
          ? data.lessonTime.value
          : this.lessonTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoupleCall(')
          ..write('coupleId: $coupleId, ')
          ..write('lessonWeekday: $lessonWeekday, ')
          ..write('lessonTime: $lessonTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(coupleId, lessonWeekday, lessonTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoupleCall &&
          other.coupleId == this.coupleId &&
          other.lessonWeekday == this.lessonWeekday &&
          other.lessonTime == this.lessonTime);
}

class CoupleCallsCompanion extends UpdateCompanion<CoupleCall> {
  final Value<int> coupleId;
  final Value<int> lessonWeekday;
  final Value<int> lessonTime;
  final Value<int> rowid;
  const CoupleCallsCompanion({
    this.coupleId = const Value.absent(),
    this.lessonWeekday = const Value.absent(),
    this.lessonTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoupleCallsCompanion.insert({
    required int coupleId,
    required int lessonWeekday,
    required int lessonTime,
    this.rowid = const Value.absent(),
  }) : coupleId = Value(coupleId),
       lessonWeekday = Value(lessonWeekday),
       lessonTime = Value(lessonTime);
  static Insertable<CoupleCall> custom({
    Expression<int>? coupleId,
    Expression<int>? lessonWeekday,
    Expression<int>? lessonTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (coupleId != null) 'couple_id': coupleId,
      if (lessonWeekday != null) 'lesson_weekday': lessonWeekday,
      if (lessonTime != null) 'lesson_time': lessonTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoupleCallsCompanion copyWith({
    Value<int>? coupleId,
    Value<int>? lessonWeekday,
    Value<int>? lessonTime,
    Value<int>? rowid,
  }) {
    return CoupleCallsCompanion(
      coupleId: coupleId ?? this.coupleId,
      lessonWeekday: lessonWeekday ?? this.lessonWeekday,
      lessonTime: lessonTime ?? this.lessonTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (coupleId.present) {
      map['couple_id'] = Variable<int>(coupleId.value);
    }
    if (lessonWeekday.present) {
      map['lesson_weekday'] = Variable<int>(lessonWeekday.value);
    }
    if (lessonTime.present) {
      map['lesson_time'] = Variable<int>(lessonTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoupleCallsCompanion(')
          ..write('coupleId: $coupleId, ')
          ..write('lessonWeekday: $lessonWeekday, ')
          ..write('lessonTime: $lessonTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$DataBase extends GeneratedDatabase {
  _$DataBase(QueryExecutor e) : super(e);
  $DataBaseManager get managers => $DataBaseManager(this);
  late final $GroupsTable groups = $GroupsTable(this);
  late final $TeachersTable teachers = $TeachersTable(this);
  late final $CallsTable calls = $CallsTable(this);
  late final $CouplesTable couples = $CouplesTable(this);
  late final $AuditoriesTable auditories = $AuditoriesTable(this);
  late final $CoupleSubgroupsTable coupleSubgroups = $CoupleSubgroupsTable(
    this,
  );
  late final $CoupleCallsTable coupleCalls = $CoupleCallsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    groups,
    teachers,
    calls,
    couples,
    auditories,
    coupleSubgroups,
    coupleCalls,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('couples', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'couples',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('couple_subgroups', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'auditories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('couple_subgroups', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'teachers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('couple_subgroups', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('couple_subgroups', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'couples',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('couple_calls', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$GroupsTableCreateCompanionBuilder = GroupsCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$GroupsTableUpdateCompanionBuilder = GroupsCompanion Function({
  Value<int> id,
  Value<String> name,
});

final class $$GroupsTableReferences
    extends BaseReferences<_$DataBase, $GroupsTable, Group> {
  $$GroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CouplesTable, List<Couple>> _couplesRefsTable(
    _$DataBase db,
  ) => MultiTypedResultKey.fromTable(
    db.couples,
    aliasName: 'groups__id__couples__group_id',
  );

  $$CouplesTableProcessedTableManager get couplesRefs {
    final manager = $$CouplesTableTableManager(
      $_db,
      $_db.couples,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_couplesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CoupleSubgroupsTable, List<CoupleSubgroup>>
  _coupleSubgroupsRefsTable(_$DataBase db) => MultiTypedResultKey.fromTable(
    db.coupleSubgroups,
    aliasName: 'groups__id__couple_subgroups__group_id',
  );

  $$CoupleSubgroupsTableProcessedTableManager get coupleSubgroupsRefs {
    final manager = $$CoupleSubgroupsTableTableManager(
      $_db,
      $_db.coupleSubgroups,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _coupleSubgroupsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GroupsTableFilterComposer extends Composer<_$DataBase, $GroupsTable> {
  $$GroupsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> couplesRefs(
    Expression<bool> Function($$CouplesTableFilterComposer f) f,
  ) {
    final $$CouplesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.couples,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CouplesTableFilterComposer(
            $db: $db,
            $table: $db.couples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> coupleSubgroupsRefs(
    Expression<bool> Function($$CoupleSubgroupsTableFilterComposer f) f,
  ) {
    final $$CoupleSubgroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coupleSubgroups,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoupleSubgroupsTableFilterComposer(
            $db: $db,
            $table: $db.coupleSubgroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GroupsTableOrderingComposer extends Composer<_$DataBase, $GroupsTable> {
  $$GroupsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GroupsTableAnnotationComposer
    extends Composer<_$DataBase, $GroupsTable> {
  $$GroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> couplesRefs<T extends Object>(
    Expression<T> Function($$CouplesTableAnnotationComposer a) f,
  ) {
    final $$CouplesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.couples,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CouplesTableAnnotationComposer(
            $db: $db,
            $table: $db.couples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> coupleSubgroupsRefs<T extends Object>(
    Expression<T> Function($$CoupleSubgroupsTableAnnotationComposer a) f,
  ) {
    final $$CoupleSubgroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coupleSubgroups,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoupleSubgroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.coupleSubgroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GroupsTableTableManager
    extends
        RootTableManager<
          _$DataBase,
          $GroupsTable,
          Group,
          $$GroupsTableFilterComposer,
          $$GroupsTableOrderingComposer,
          $$GroupsTableAnnotationComposer,
          $$GroupsTableCreateCompanionBuilder,
          $$GroupsTableUpdateCompanionBuilder,
          (Group, $$GroupsTableReferences),
          Group,
          PrefetchHooks Function({bool couplesRefs, bool coupleSubgroupsRefs})
        > {
  $$GroupsTableTableManager(_$DataBase db, $GroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) => GroupsCompanion(id: id, name: name),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) => GroupsCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GroupsTable, Group>(table),
                  $$GroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({couplesRefs = false, coupleSubgroupsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (couplesRefs) db.couples,
                    if (coupleSubgroupsRefs) db.coupleSubgroups,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (couplesRefs)
                        await $_getPrefetchedData<Group, $GroupsTable, Couple>(
                          currentTable: table,
                          referencedTable: $$GroupsTableReferences
                              ._couplesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GroupsTableReferences(
                                db,
                                table,
                                p0,
                              ).couplesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.groupId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (coupleSubgroupsRefs)
                        await $_getPrefetchedData<
                          Group,
                          $GroupsTable,
                          CoupleSubgroup
                        >(
                          currentTable: table,
                          referencedTable: $$GroupsTableReferences
                              ._coupleSubgroupsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GroupsTableReferences(
                                db,
                                table,
                                p0,
                              ).coupleSubgroupsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.groupId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$DataBase,
      $GroupsTable,
      Group,
      $$GroupsTableFilterComposer,
      $$GroupsTableOrderingComposer,
      $$GroupsTableAnnotationComposer,
      $$GroupsTableCreateCompanionBuilder,
      $$GroupsTableUpdateCompanionBuilder,
      (Group, $$GroupsTableReferences),
      Group,
      PrefetchHooks Function({bool couplesRefs, bool coupleSubgroupsRefs})
    >;
typedef $$TeachersTableCreateCompanionBuilder = TeachersCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$TeachersTableUpdateCompanionBuilder = TeachersCompanion Function({
  Value<int> id,
  Value<String> name,
});

final class $$TeachersTableReferences
    extends BaseReferences<_$DataBase, $TeachersTable, Teacher> {
  $$TeachersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CoupleSubgroupsTable, List<CoupleSubgroup>>
  _coupleSubgroupsRefsTable(_$DataBase db) => MultiTypedResultKey.fromTable(
    db.coupleSubgroups,
    aliasName: 'teachers__id__couple_subgroups__teacher_id',
  );

  $$CoupleSubgroupsTableProcessedTableManager get coupleSubgroupsRefs {
    final manager = $$CoupleSubgroupsTableTableManager(
      $_db,
      $_db.coupleSubgroups,
    ).filter((f) => f.teacherId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _coupleSubgroupsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TeachersTableFilterComposer
    extends Composer<_$DataBase, $TeachersTable> {
  $$TeachersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> coupleSubgroupsRefs(
    Expression<bool> Function($$CoupleSubgroupsTableFilterComposer f) f,
  ) {
    final $$CoupleSubgroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coupleSubgroups,
      getReferencedColumn: (t) => t.teacherId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoupleSubgroupsTableFilterComposer(
            $db: $db,
            $table: $db.coupleSubgroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeachersTableOrderingComposer
    extends Composer<_$DataBase, $TeachersTable> {
  $$TeachersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeachersTableAnnotationComposer
    extends Composer<_$DataBase, $TeachersTable> {
  $$TeachersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> coupleSubgroupsRefs<T extends Object>(
    Expression<T> Function($$CoupleSubgroupsTableAnnotationComposer a) f,
  ) {
    final $$CoupleSubgroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coupleSubgroups,
      getReferencedColumn: (t) => t.teacherId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoupleSubgroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.coupleSubgroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeachersTableTableManager
    extends
        RootTableManager<
          _$DataBase,
          $TeachersTable,
          Teacher,
          $$TeachersTableFilterComposer,
          $$TeachersTableOrderingComposer,
          $$TeachersTableAnnotationComposer,
          $$TeachersTableCreateCompanionBuilder,
          $$TeachersTableUpdateCompanionBuilder,
          (Teacher, $$TeachersTableReferences),
          Teacher,
          PrefetchHooks Function({bool coupleSubgroupsRefs})
        > {
  $$TeachersTableTableManager(_$DataBase db, $TeachersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeachersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeachersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeachersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) => TeachersCompanion(id: id, name: name),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) => TeachersCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TeachersTable, Teacher>(table),
                  $$TeachersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({coupleSubgroupsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (coupleSubgroupsRefs) db.coupleSubgroups,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (coupleSubgroupsRefs)
                    await $_getPrefetchedData<
                      Teacher,
                      $TeachersTable,
                      CoupleSubgroup
                    >(
                      currentTable: table,
                      referencedTable: $$TeachersTableReferences
                          ._coupleSubgroupsRefsTable(db),
                      managerFromTypedResult: (p0) => $$TeachersTableReferences(
                        db,
                        table,
                        p0,
                      ).coupleSubgroupsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.teacherId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TeachersTableProcessedTableManager =
    ProcessedTableManager<
      _$DataBase,
      $TeachersTable,
      Teacher,
      $$TeachersTableFilterComposer,
      $$TeachersTableOrderingComposer,
      $$TeachersTableAnnotationComposer,
      $$TeachersTableCreateCompanionBuilder,
      $$TeachersTableUpdateCompanionBuilder,
      (Teacher, $$TeachersTableReferences),
      Teacher,
      PrefetchHooks Function({bool coupleSubgroupsRefs})
    >;
typedef $$CallsTableCreateCompanionBuilder = CallsCompanion Function({
  required int weekday,
  required int time,
  required String timeStart,
  required String timeEnd,
  Value<int> rowid,
});
typedef $$CallsTableUpdateCompanionBuilder = CallsCompanion Function({
  Value<int> weekday,
  Value<int> time,
  Value<String> timeStart,
  Value<String> timeEnd,
  Value<int> rowid,
});

class $$CallsTableFilterComposer extends Composer<_$DataBase, $CallsTable> {
  $$CallsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeStart => $composableBuilder(
    column: $table.timeStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeEnd => $composableBuilder(
    column: $table.timeEnd,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CallsTableOrderingComposer extends Composer<_$DataBase, $CallsTable> {
  $$CallsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeStart => $composableBuilder(
    column: $table.timeStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeEnd => $composableBuilder(
    column: $table.timeEnd,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CallsTableAnnotationComposer extends Composer<_$DataBase, $CallsTable> {
  $$CallsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get weekday =>
      $composableBuilder(column: $table.weekday, builder: (column) => column);

  GeneratedColumn<int> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get timeStart =>
      $composableBuilder(column: $table.timeStart, builder: (column) => column);

  GeneratedColumn<String> get timeEnd =>
      $composableBuilder(column: $table.timeEnd, builder: (column) => column);
}

class $$CallsTableTableManager
    extends
        RootTableManager<
          _$DataBase,
          $CallsTable,
          Call,
          $$CallsTableFilterComposer,
          $$CallsTableOrderingComposer,
          $$CallsTableAnnotationComposer,
          $$CallsTableCreateCompanionBuilder,
          $$CallsTableUpdateCompanionBuilder,
          (Call, BaseReferences<_$DataBase, $CallsTable, Call>),
          Call,
          PrefetchHooks Function()
        > {
  $$CallsTableTableManager(_$DataBase db, $CallsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CallsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CallsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CallsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> weekday = const Value.absent(),
                Value<int> time = const Value.absent(),
                Value<String> timeStart = const Value.absent(),
                Value<String> timeEnd = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CallsCompanion(
                weekday: weekday,
                time: time,
                timeStart: timeStart,
                timeEnd: timeEnd,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int weekday,
                required int time,
                required String timeStart,
                required String timeEnd,
                Value<int> rowid = const Value.absent(),
              }) => CallsCompanion.insert(
                weekday: weekday,
                time: time,
                timeStart: timeStart,
                timeEnd: timeEnd,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CallsTable, Call>(table),
                  BaseReferences<_$DataBase, $CallsTable, Call>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CallsTableProcessedTableManager =
    ProcessedTableManager<
      _$DataBase,
      $CallsTable,
      Call,
      $$CallsTableFilterComposer,
      $$CallsTableOrderingComposer,
      $$CallsTableAnnotationComposer,
      $$CallsTableCreateCompanionBuilder,
      $$CallsTableUpdateCompanionBuilder,
      (Call, BaseReferences<_$DataBase, $CallsTable, Call>),
      Call,
      PrefetchHooks Function()
    >;
typedef $$CouplesTableCreateCompanionBuilder = CouplesCompanion Function({
  Value<int> id,
  required String subject,
  required int subgroup,
  required int week,
  required int weekDay,
  Value<int?> groupId,
  required DateTime date,
  Value<int?> lessonWeekday,
  Value<int?> lessonTime,
});
typedef $$CouplesTableUpdateCompanionBuilder = CouplesCompanion Function({
  Value<int> id,
  Value<String> subject,
  Value<int> subgroup,
  Value<int> week,
  Value<int> weekDay,
  Value<int?> groupId,
  Value<DateTime> date,
  Value<int?> lessonWeekday,
  Value<int?> lessonTime,
});

final class $$CouplesTableReferences
    extends BaseReferences<_$DataBase, $CouplesTable, Couple> {
  $$CouplesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GroupsTable _groupIdTable(_$DataBase db) =>
      db.groups.createAlias('couples__group_id__groups__id');

  $$GroupsTableProcessedTableManager? get groupId {
    final $_column = $_itemColumn<int>('group_id');
    if ($_column == null) return null;
    final manager = $$GroupsTableTableManager(
      $_db,
      $_db.groups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CoupleSubgroupsTable, List<CoupleSubgroup>>
  _coupleSubgroupsRefsTable(_$DataBase db) => MultiTypedResultKey.fromTable(
    db.coupleSubgroups,
    aliasName: 'couples__id__couple_subgroups__couple_id',
  );

  $$CoupleSubgroupsTableProcessedTableManager get coupleSubgroupsRefs {
    final manager = $$CoupleSubgroupsTableTableManager(
      $_db,
      $_db.coupleSubgroups,
    ).filter((f) => f.coupleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _coupleSubgroupsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CoupleCallsTable, List<CoupleCall>>
  _coupleCallsRefsTable(_$DataBase db) => MultiTypedResultKey.fromTable(
    db.coupleCalls,
    aliasName: 'couples__id__couple_calls__couple_id',
  );

  $$CoupleCallsTableProcessedTableManager get coupleCallsRefs {
    final manager = $$CoupleCallsTableTableManager(
      $_db,
      $_db.coupleCalls,
    ).filter((f) => f.coupleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_coupleCallsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CouplesTableFilterComposer extends Composer<_$DataBase, $CouplesTable> {
  $$CouplesTableFilterComposer({
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

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subgroup => $composableBuilder(
    column: $table.subgroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get week => $composableBuilder(
    column: $table.week,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekDay => $composableBuilder(
    column: $table.weekDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lessonWeekday => $composableBuilder(
    column: $table.lessonWeekday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lessonTime => $composableBuilder(
    column: $table.lessonTime,
    builder: (column) => ColumnFilters(column),
  );

  $$GroupsTableFilterComposer get groupId {
    final $$GroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableFilterComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> coupleSubgroupsRefs(
    Expression<bool> Function($$CoupleSubgroupsTableFilterComposer f) f,
  ) {
    final $$CoupleSubgroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coupleSubgroups,
      getReferencedColumn: (t) => t.coupleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoupleSubgroupsTableFilterComposer(
            $db: $db,
            $table: $db.coupleSubgroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> coupleCallsRefs(
    Expression<bool> Function($$CoupleCallsTableFilterComposer f) f,
  ) {
    final $$CoupleCallsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coupleCalls,
      getReferencedColumn: (t) => t.coupleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoupleCallsTableFilterComposer(
            $db: $db,
            $table: $db.coupleCalls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CouplesTableOrderingComposer
    extends Composer<_$DataBase, $CouplesTable> {
  $$CouplesTableOrderingComposer({
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

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subgroup => $composableBuilder(
    column: $table.subgroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get week => $composableBuilder(
    column: $table.week,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekDay => $composableBuilder(
    column: $table.weekDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lessonWeekday => $composableBuilder(
    column: $table.lessonWeekday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lessonTime => $composableBuilder(
    column: $table.lessonTime,
    builder: (column) => ColumnOrderings(column),
  );

  $$GroupsTableOrderingComposer get groupId {
    final $$GroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableOrderingComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CouplesTableAnnotationComposer
    extends Composer<_$DataBase, $CouplesTable> {
  $$CouplesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<int> get subgroup =>
      $composableBuilder(column: $table.subgroup, builder: (column) => column);

  GeneratedColumn<int> get week =>
      $composableBuilder(column: $table.week, builder: (column) => column);

  GeneratedColumn<int> get weekDay =>
      $composableBuilder(column: $table.weekDay, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get lessonWeekday => $composableBuilder(
    column: $table.lessonWeekday,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lessonTime => $composableBuilder(
    column: $table.lessonTime,
    builder: (column) => column,
  );

  $$GroupsTableAnnotationComposer get groupId {
    final $$GroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> coupleSubgroupsRefs<T extends Object>(
    Expression<T> Function($$CoupleSubgroupsTableAnnotationComposer a) f,
  ) {
    final $$CoupleSubgroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coupleSubgroups,
      getReferencedColumn: (t) => t.coupleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoupleSubgroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.coupleSubgroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> coupleCallsRefs<T extends Object>(
    Expression<T> Function($$CoupleCallsTableAnnotationComposer a) f,
  ) {
    final $$CoupleCallsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coupleCalls,
      getReferencedColumn: (t) => t.coupleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoupleCallsTableAnnotationComposer(
            $db: $db,
            $table: $db.coupleCalls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CouplesTableTableManager
    extends
        RootTableManager<
          _$DataBase,
          $CouplesTable,
          Couple,
          $$CouplesTableFilterComposer,
          $$CouplesTableOrderingComposer,
          $$CouplesTableAnnotationComposer,
          $$CouplesTableCreateCompanionBuilder,
          $$CouplesTableUpdateCompanionBuilder,
          (Couple, $$CouplesTableReferences),
          Couple,
          PrefetchHooks Function({
            bool groupId,
            bool coupleSubgroupsRefs,
            bool coupleCallsRefs,
          })
        > {
  $$CouplesTableTableManager(_$DataBase db, $CouplesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CouplesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CouplesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CouplesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> subject = const Value.absent(),
                Value<int> subgroup = const Value.absent(),
                Value<int> week = const Value.absent(),
                Value<int> weekDay = const Value.absent(),
                Value<int?> groupId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int?> lessonWeekday = const Value.absent(),
                Value<int?> lessonTime = const Value.absent(),
              }) => CouplesCompanion(
                id: id,
                subject: subject,
                subgroup: subgroup,
                week: week,
                weekDay: weekDay,
                groupId: groupId,
                date: date,
                lessonWeekday: lessonWeekday,
                lessonTime: lessonTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String subject,
                required int subgroup,
                required int week,
                required int weekDay,
                Value<int?> groupId = const Value.absent(),
                required DateTime date,
                Value<int?> lessonWeekday = const Value.absent(),
                Value<int?> lessonTime = const Value.absent(),
              }) => CouplesCompanion.insert(
                id: id,
                subject: subject,
                subgroup: subgroup,
                week: week,
                weekDay: weekDay,
                groupId: groupId,
                date: date,
                lessonWeekday: lessonWeekday,
                lessonTime: lessonTime,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CouplesTable, Couple>(table),
                  $$CouplesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                groupId = false,
                coupleSubgroupsRefs = false,
                coupleCallsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (coupleSubgroupsRefs) db.coupleSubgroups,
                    if (coupleCallsRefs) db.coupleCalls,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (groupId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.groupId,
                            referencedTable: $$CouplesTableReferences
                                ._groupIdTable(db),
                            referencedColumn: $$CouplesTableReferences
                                ._groupIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (coupleSubgroupsRefs)
                        await $_getPrefetchedData<
                          Couple,
                          $CouplesTable,
                          CoupleSubgroup
                        >(
                          currentTable: table,
                          referencedTable: $$CouplesTableReferences
                              ._coupleSubgroupsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CouplesTableReferences(
                                db,
                                table,
                                p0,
                              ).coupleSubgroupsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.coupleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (coupleCallsRefs)
                        await $_getPrefetchedData<
                          Couple,
                          $CouplesTable,
                          CoupleCall
                        >(
                          currentTable: table,
                          referencedTable: $$CouplesTableReferences
                              ._coupleCallsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CouplesTableReferences(
                                db,
                                table,
                                p0,
                              ).coupleCallsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.coupleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CouplesTableProcessedTableManager =
    ProcessedTableManager<
      _$DataBase,
      $CouplesTable,
      Couple,
      $$CouplesTableFilterComposer,
      $$CouplesTableOrderingComposer,
      $$CouplesTableAnnotationComposer,
      $$CouplesTableCreateCompanionBuilder,
      $$CouplesTableUpdateCompanionBuilder,
      (Couple, $$CouplesTableReferences),
      Couple,
      PrefetchHooks Function({
        bool groupId,
        bool coupleSubgroupsRefs,
        bool coupleCallsRefs,
      })
    >;
typedef $$AuditoriesTableCreateCompanionBuilder = AuditoriesCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$AuditoriesTableUpdateCompanionBuilder = AuditoriesCompanion Function({
  Value<int> id,
  Value<String> name,
});

final class $$AuditoriesTableReferences
    extends BaseReferences<_$DataBase, $AuditoriesTable, Auditory> {
  $$AuditoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CoupleSubgroupsTable, List<CoupleSubgroup>>
  _coupleSubgroupsRefsTable(_$DataBase db) => MultiTypedResultKey.fromTable(
    db.coupleSubgroups,
    aliasName: 'auditories__id__couple_subgroups__auditory_id',
  );

  $$CoupleSubgroupsTableProcessedTableManager get coupleSubgroupsRefs {
    final manager = $$CoupleSubgroupsTableTableManager(
      $_db,
      $_db.coupleSubgroups,
    ).filter((f) => f.auditoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _coupleSubgroupsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AuditoriesTableFilterComposer
    extends Composer<_$DataBase, $AuditoriesTable> {
  $$AuditoriesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> coupleSubgroupsRefs(
    Expression<bool> Function($$CoupleSubgroupsTableFilterComposer f) f,
  ) {
    final $$CoupleSubgroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coupleSubgroups,
      getReferencedColumn: (t) => t.auditoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoupleSubgroupsTableFilterComposer(
            $db: $db,
            $table: $db.coupleSubgroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AuditoriesTableOrderingComposer
    extends Composer<_$DataBase, $AuditoriesTable> {
  $$AuditoriesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditoriesTableAnnotationComposer
    extends Composer<_$DataBase, $AuditoriesTable> {
  $$AuditoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> coupleSubgroupsRefs<T extends Object>(
    Expression<T> Function($$CoupleSubgroupsTableAnnotationComposer a) f,
  ) {
    final $$CoupleSubgroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coupleSubgroups,
      getReferencedColumn: (t) => t.auditoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoupleSubgroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.coupleSubgroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AuditoriesTableTableManager
    extends
        RootTableManager<
          _$DataBase,
          $AuditoriesTable,
          Auditory,
          $$AuditoriesTableFilterComposer,
          $$AuditoriesTableOrderingComposer,
          $$AuditoriesTableAnnotationComposer,
          $$AuditoriesTableCreateCompanionBuilder,
          $$AuditoriesTableUpdateCompanionBuilder,
          (Auditory, $$AuditoriesTableReferences),
          Auditory,
          PrefetchHooks Function({bool coupleSubgroupsRefs})
        > {
  $$AuditoriesTableTableManager(_$DataBase db, $AuditoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) => AuditoriesCompanion(id: id, name: name),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) => AuditoriesCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AuditoriesTable, Auditory>(table),
                  $$AuditoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({coupleSubgroupsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (coupleSubgroupsRefs) db.coupleSubgroups,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (coupleSubgroupsRefs)
                    await $_getPrefetchedData<
                      Auditory,
                      $AuditoriesTable,
                      CoupleSubgroup
                    >(
                      currentTable: table,
                      referencedTable: $$AuditoriesTableReferences
                          ._coupleSubgroupsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AuditoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).coupleSubgroupsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.auditoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AuditoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$DataBase,
      $AuditoriesTable,
      Auditory,
      $$AuditoriesTableFilterComposer,
      $$AuditoriesTableOrderingComposer,
      $$AuditoriesTableAnnotationComposer,
      $$AuditoriesTableCreateCompanionBuilder,
      $$AuditoriesTableUpdateCompanionBuilder,
      (Auditory, $$AuditoriesTableReferences),
      Auditory,
      PrefetchHooks Function({bool coupleSubgroupsRefs})
    >;
typedef $$CoupleSubgroupsTableCreateCompanionBuilder =
    CoupleSubgroupsCompanion Function({
      required int coupleId,
      required int auditoryId,
      required int teacherId,
      required int groupId,
      required int number,
      Value<int> rowid,
    });
typedef $$CoupleSubgroupsTableUpdateCompanionBuilder =
    CoupleSubgroupsCompanion Function({
      Value<int> coupleId,
      Value<int> auditoryId,
      Value<int> teacherId,
      Value<int> groupId,
      Value<int> number,
      Value<int> rowid,
    });

final class $$CoupleSubgroupsTableReferences
    extends BaseReferences<_$DataBase, $CoupleSubgroupsTable, CoupleSubgroup> {
  $$CoupleSubgroupsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CouplesTable _coupleIdTable(_$DataBase db) =>
      db.couples.createAlias('couple_subgroups__couple_id__couples__id');

  $$CouplesTableProcessedTableManager get coupleId {
    final $_column = $_itemColumn<int>('couple_id')!;

    final manager = $$CouplesTableTableManager(
      $_db,
      $_db.couples,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coupleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AuditoriesTable _auditoryIdTable(_$DataBase db) => db.auditories
      .createAlias('couple_subgroups__auditory_id__auditories__id');

  $$AuditoriesTableProcessedTableManager get auditoryId {
    final $_column = $_itemColumn<int>('auditory_id')!;

    final manager = $$AuditoriesTableTableManager(
      $_db,
      $_db.auditories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_auditoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TeachersTable _teacherIdTable(_$DataBase db) =>
      db.teachers.createAlias('couple_subgroups__teacher_id__teachers__id');

  $$TeachersTableProcessedTableManager get teacherId {
    final $_column = $_itemColumn<int>('teacher_id')!;

    final manager = $$TeachersTableTableManager(
      $_db,
      $_db.teachers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teacherIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GroupsTable _groupIdTable(_$DataBase db) =>
      db.groups.createAlias('couple_subgroups__group_id__groups__id');

  $$GroupsTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<int>('group_id')!;

    final manager = $$GroupsTableTableManager(
      $_db,
      $_db.groups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CoupleSubgroupsTableFilterComposer
    extends Composer<_$DataBase, $CoupleSubgroupsTable> {
  $$CoupleSubgroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  $$CouplesTableFilterComposer get coupleId {
    final $$CouplesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coupleId,
      referencedTable: $db.couples,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CouplesTableFilterComposer(
            $db: $db,
            $table: $db.couples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AuditoriesTableFilterComposer get auditoryId {
    final $$AuditoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.auditoryId,
      referencedTable: $db.auditories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuditoriesTableFilterComposer(
            $db: $db,
            $table: $db.auditories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeachersTableFilterComposer get teacherId {
    final $$TeachersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teacherId,
      referencedTable: $db.teachers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeachersTableFilterComposer(
            $db: $db,
            $table: $db.teachers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GroupsTableFilterComposer get groupId {
    final $$GroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableFilterComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoupleSubgroupsTableOrderingComposer
    extends Composer<_$DataBase, $CoupleSubgroupsTable> {
  $$CoupleSubgroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  $$CouplesTableOrderingComposer get coupleId {
    final $$CouplesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coupleId,
      referencedTable: $db.couples,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CouplesTableOrderingComposer(
            $db: $db,
            $table: $db.couples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AuditoriesTableOrderingComposer get auditoryId {
    final $$AuditoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.auditoryId,
      referencedTable: $db.auditories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuditoriesTableOrderingComposer(
            $db: $db,
            $table: $db.auditories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeachersTableOrderingComposer get teacherId {
    final $$TeachersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teacherId,
      referencedTable: $db.teachers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeachersTableOrderingComposer(
            $db: $db,
            $table: $db.teachers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GroupsTableOrderingComposer get groupId {
    final $$GroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableOrderingComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoupleSubgroupsTableAnnotationComposer
    extends Composer<_$DataBase, $CoupleSubgroupsTable> {
  $$CoupleSubgroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  $$CouplesTableAnnotationComposer get coupleId {
    final $$CouplesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coupleId,
      referencedTable: $db.couples,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CouplesTableAnnotationComposer(
            $db: $db,
            $table: $db.couples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AuditoriesTableAnnotationComposer get auditoryId {
    final $$AuditoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.auditoryId,
      referencedTable: $db.auditories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuditoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.auditories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeachersTableAnnotationComposer get teacherId {
    final $$TeachersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teacherId,
      referencedTable: $db.teachers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeachersTableAnnotationComposer(
            $db: $db,
            $table: $db.teachers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GroupsTableAnnotationComposer get groupId {
    final $$GroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoupleSubgroupsTableTableManager
    extends
        RootTableManager<
          _$DataBase,
          $CoupleSubgroupsTable,
          CoupleSubgroup,
          $$CoupleSubgroupsTableFilterComposer,
          $$CoupleSubgroupsTableOrderingComposer,
          $$CoupleSubgroupsTableAnnotationComposer,
          $$CoupleSubgroupsTableCreateCompanionBuilder,
          $$CoupleSubgroupsTableUpdateCompanionBuilder,
          (CoupleSubgroup, $$CoupleSubgroupsTableReferences),
          CoupleSubgroup,
          PrefetchHooks Function({
            bool coupleId,
            bool auditoryId,
            bool teacherId,
            bool groupId,
          })
        > {
  $$CoupleSubgroupsTableTableManager(_$DataBase db, $CoupleSubgroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoupleSubgroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoupleSubgroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoupleSubgroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> coupleId = const Value.absent(),
                Value<int> auditoryId = const Value.absent(),
                Value<int> teacherId = const Value.absent(),
                Value<int> groupId = const Value.absent(),
                Value<int> number = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoupleSubgroupsCompanion(
                coupleId: coupleId,
                auditoryId: auditoryId,
                teacherId: teacherId,
                groupId: groupId,
                number: number,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int coupleId,
                required int auditoryId,
                required int teacherId,
                required int groupId,
                required int number,
                Value<int> rowid = const Value.absent(),
              }) => CoupleSubgroupsCompanion.insert(
                coupleId: coupleId,
                auditoryId: auditoryId,
                teacherId: teacherId,
                groupId: groupId,
                number: number,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CoupleSubgroupsTable, CoupleSubgroup>(table),
                  $$CoupleSubgroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                coupleId = false,
                auditoryId = false,
                teacherId = false,
                groupId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (coupleId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.coupleId,
                            referencedTable: $$CoupleSubgroupsTableReferences
                                ._coupleIdTable(db),
                            referencedColumn: $$CoupleSubgroupsTableReferences
                                ._coupleIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (auditoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.auditoryId,
                            referencedTable: $$CoupleSubgroupsTableReferences
                                ._auditoryIdTable(db),
                            referencedColumn: $$CoupleSubgroupsTableReferences
                                ._auditoryIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (teacherId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.teacherId,
                            referencedTable: $$CoupleSubgroupsTableReferences
                                ._teacherIdTable(db),
                            referencedColumn: $$CoupleSubgroupsTableReferences
                                ._teacherIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (groupId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.groupId,
                            referencedTable: $$CoupleSubgroupsTableReferences
                                ._groupIdTable(db),
                            referencedColumn: $$CoupleSubgroupsTableReferences
                                ._groupIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$CoupleSubgroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$DataBase,
      $CoupleSubgroupsTable,
      CoupleSubgroup,
      $$CoupleSubgroupsTableFilterComposer,
      $$CoupleSubgroupsTableOrderingComposer,
      $$CoupleSubgroupsTableAnnotationComposer,
      $$CoupleSubgroupsTableCreateCompanionBuilder,
      $$CoupleSubgroupsTableUpdateCompanionBuilder,
      (CoupleSubgroup, $$CoupleSubgroupsTableReferences),
      CoupleSubgroup,
      PrefetchHooks Function({
        bool coupleId,
        bool auditoryId,
        bool teacherId,
        bool groupId,
      })
    >;
typedef $$CoupleCallsTableCreateCompanionBuilder =
    CoupleCallsCompanion Function({
      required int coupleId,
      required int lessonWeekday,
      required int lessonTime,
      Value<int> rowid,
    });
typedef $$CoupleCallsTableUpdateCompanionBuilder =
    CoupleCallsCompanion Function({
      Value<int> coupleId,
      Value<int> lessonWeekday,
      Value<int> lessonTime,
      Value<int> rowid,
    });

final class $$CoupleCallsTableReferences
    extends BaseReferences<_$DataBase, $CoupleCallsTable, CoupleCall> {
  $$CoupleCallsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CouplesTable _coupleIdTable(_$DataBase db) =>
      db.couples.createAlias('couple_calls__couple_id__couples__id');

  $$CouplesTableProcessedTableManager get coupleId {
    final $_column = $_itemColumn<int>('couple_id')!;

    final manager = $$CouplesTableTableManager(
      $_db,
      $_db.couples,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coupleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CoupleCallsTableFilterComposer
    extends Composer<_$DataBase, $CoupleCallsTable> {
  $$CoupleCallsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get lessonWeekday => $composableBuilder(
    column: $table.lessonWeekday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lessonTime => $composableBuilder(
    column: $table.lessonTime,
    builder: (column) => ColumnFilters(column),
  );

  $$CouplesTableFilterComposer get coupleId {
    final $$CouplesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coupleId,
      referencedTable: $db.couples,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CouplesTableFilterComposer(
            $db: $db,
            $table: $db.couples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoupleCallsTableOrderingComposer
    extends Composer<_$DataBase, $CoupleCallsTable> {
  $$CoupleCallsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get lessonWeekday => $composableBuilder(
    column: $table.lessonWeekday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lessonTime => $composableBuilder(
    column: $table.lessonTime,
    builder: (column) => ColumnOrderings(column),
  );

  $$CouplesTableOrderingComposer get coupleId {
    final $$CouplesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coupleId,
      referencedTable: $db.couples,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CouplesTableOrderingComposer(
            $db: $db,
            $table: $db.couples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoupleCallsTableAnnotationComposer
    extends Composer<_$DataBase, $CoupleCallsTable> {
  $$CoupleCallsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get lessonWeekday => $composableBuilder(
    column: $table.lessonWeekday,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lessonTime => $composableBuilder(
    column: $table.lessonTime,
    builder: (column) => column,
  );

  $$CouplesTableAnnotationComposer get coupleId {
    final $$CouplesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coupleId,
      referencedTable: $db.couples,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CouplesTableAnnotationComposer(
            $db: $db,
            $table: $db.couples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoupleCallsTableTableManager
    extends
        RootTableManager<
          _$DataBase,
          $CoupleCallsTable,
          CoupleCall,
          $$CoupleCallsTableFilterComposer,
          $$CoupleCallsTableOrderingComposer,
          $$CoupleCallsTableAnnotationComposer,
          $$CoupleCallsTableCreateCompanionBuilder,
          $$CoupleCallsTableUpdateCompanionBuilder,
          (CoupleCall, $$CoupleCallsTableReferences),
          CoupleCall,
          PrefetchHooks Function({bool coupleId})
        > {
  $$CoupleCallsTableTableManager(_$DataBase db, $CoupleCallsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoupleCallsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoupleCallsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoupleCallsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> coupleId = const Value.absent(),
                Value<int> lessonWeekday = const Value.absent(),
                Value<int> lessonTime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoupleCallsCompanion(
                coupleId: coupleId,
                lessonWeekday: lessonWeekday,
                lessonTime: lessonTime,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int coupleId,
                required int lessonWeekday,
                required int lessonTime,
                Value<int> rowid = const Value.absent(),
              }) => CoupleCallsCompanion.insert(
                coupleId: coupleId,
                lessonWeekday: lessonWeekday,
                lessonTime: lessonTime,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CoupleCallsTable, CoupleCall>(table),
                  $$CoupleCallsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({coupleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (coupleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.coupleId,
                        referencedTable: $$CoupleCallsTableReferences
                            ._coupleIdTable(db),
                        referencedColumn: $$CoupleCallsTableReferences
                            ._coupleIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CoupleCallsTableProcessedTableManager =
    ProcessedTableManager<
      _$DataBase,
      $CoupleCallsTable,
      CoupleCall,
      $$CoupleCallsTableFilterComposer,
      $$CoupleCallsTableOrderingComposer,
      $$CoupleCallsTableAnnotationComposer,
      $$CoupleCallsTableCreateCompanionBuilder,
      $$CoupleCallsTableUpdateCompanionBuilder,
      (CoupleCall, $$CoupleCallsTableReferences),
      CoupleCall,
      PrefetchHooks Function({bool coupleId})
    >;

class $DataBaseManager {
  final _$DataBase _db;
  $DataBaseManager(this._db);
  $$GroupsTableTableManager get groups =>
      $$GroupsTableTableManager(_db, _db.groups);
  $$TeachersTableTableManager get teachers =>
      $$TeachersTableTableManager(_db, _db.teachers);
  $$CallsTableTableManager get calls =>
      $$CallsTableTableManager(_db, _db.calls);
  $$CouplesTableTableManager get couples =>
      $$CouplesTableTableManager(_db, _db.couples);
  $$AuditoriesTableTableManager get auditories =>
      $$AuditoriesTableTableManager(_db, _db.auditories);
  $$CoupleSubgroupsTableTableManager get coupleSubgroups =>
      $$CoupleSubgroupsTableTableManager(_db, _db.coupleSubgroups);
  $$CoupleCallsTableTableManager get coupleCalls =>
      $$CoupleCallsTableTableManager(_db, _db.coupleCalls);
}
