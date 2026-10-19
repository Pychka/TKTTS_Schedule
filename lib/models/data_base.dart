import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:tktts_schedule/models/groups.dart';
import 'package:tktts_schedule/models/teachers.dart';
import 'package:tktts_schedule/models/calls.dart';
import 'package:tktts_schedule/models/auditories.dart';
import 'package:tktts_schedule/models/couples.dart';
import 'package:tktts_schedule/models/couple_calls.dart';
import 'package:tktts_schedule/models/couple_subgroups.dart';
import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/ui_models/auditory_model.dart';
import 'package:tktts_schedule/ui_models/couple_subgroup_model.dart';
import 'package:tktts_schedule/ui_models/group_model.dart';
import 'package:tktts_schedule/ui_models/lessons_model.dart';
import 'package:tktts_schedule/ui_models/teacher_model.dart';
part 'data_base.g.dart'; 

@DriftDatabase(tables: [Groups, Teachers, Calls, Couples, CoupleSubgroups, Auditories, CoupleCalls])
class DataBase extends _$DataBase {
  DataBase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'schedule_database');
  }
  
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        for (final table in allTables) {
          await m.deleteTable(table.actualTableName);
        }
        await m.createAll();
      },
    );
  }

  Future updateTeachers(Iterable<Teacher> teachers) async {
    await batch((batch){
      batch.insertAll(
        this.teachers,
        teachers,
        mode: InsertMode.insertOrReplace
      );
    });
  }

  Future updateAuditories(Iterable<Auditory> auditories) async {
    await batch((batch){
      batch.insertAll(
        this.auditories,
        auditories,
        mode: InsertMode.insertOrReplace
      );
    });
  }

  Future updateGroups(Iterable<Group> groups) async {
    await batch((batch){
      batch.insertAll(
        this.groups,
        groups,
        mode: InsertMode.insertOrReplace
      );
    });
  }

  Future updateCouples(Iterable<Couple> couples) async {
    await batch((batch){
      batch.insertAll(
        this.couples,
        couples,
        mode: InsertMode.insertOrReplace
      );
    });
  }

  Future updateCoupleCall(Iterable<CoupleCall> coupleCalls) async {
    await batch((batch){
      batch.insertAll(
        this.coupleCalls,
        coupleCalls,
        mode: InsertMode.insertOrReplace
      );
    });
  }
  Future updateCalls(Iterable<Call> calls) async{
    await batch((batch){
      batch.insertAll(
        this.calls,
        calls,
        mode: InsertMode.insertOrIgnore
      );
    });
  }

  Future<TeacherModel> getTeacherModelV2(int id) async {
    final lessons = await getLessons(coupleSubgroups.teacherId.equals(id));
    final teacher = await (select(teachers)..where((g) => g.id.equals(id))..limit(1)).getSingleOrNull();
    return TeacherModel(teacher ?? Teacher(id: id, name: "Неизвестный преподаватель"), lessons);
  }

  Future<AuditoryModel> getAuditoryV2(int id) async {
    final lessons = await getLessons(coupleSubgroups.auditoryId.equals(id));
    final auditory = await (select(auditories)..where((g) => g.id.equals(id))..limit(1)).getSingleOrNull();
    return AuditoryModel(auditory ?? Auditory(id: id, name: "Неизвестная аудитория"), lessons);
  }

  Future<GroupModel> getGroupModelV2(int id) async {
    final lessons = await getLessons(coupleSubgroups.groupId.equals(id));
    final group = await (select(groups)..where((g) => g.id.equals(id))..limit(1)).getSingleOrNull();
    return GroupModel(group ?? Group(id: id, name: "Неизвестная группа"), lessons);
  }

  Future<List<LessonsModel>> getLessons(Expression<bool> expression) async {
    final query = select(coupleSubgroups).join([
      innerJoin(couples, couples.id.equalsExp(coupleSubgroups.coupleId)),
      innerJoin(groups, groups.id.equalsExp(coupleSubgroups.groupId)),
      innerJoin(teachers, teachers.id.equalsExp(coupleSubgroups.teacherId)),
      innerJoin(auditories, auditories.id.equalsExp(coupleSubgroups.auditoryId)),
      innerJoin(calls, calls.weekday.equalsExp(couples.lessonWeekday) & calls.time.equalsExp(couples.lessonTime)),
    ])..where(expression)
    ..orderBy([
      OrderingTerm(expression: couples.date, mode: OrderingMode.asc),
      OrderingTerm(expression: couples.lessonWeekday, mode: OrderingMode.asc),
      OrderingTerm(expression: couples.lessonTime, mode: OrderingMode.asc),
      OrderingTerm(expression: coupleSubgroups.number, mode: OrderingMode.asc)
    ]);
    final Iterable<TypedResult> rows = await query.get();
    if (rows.isEmpty) {
      return [];
    }
    final Map<int, LessonsModel> lessonsMap = {};
    for (var row in rows) {
      final coupleData = row.readTable(couples);
      final callData = row.readTable(calls);
      final teacherData = row.readTable(teachers);
      final auditoryData = row.readTable(auditories);
      final groupData = row.readTable(groups);
      final cSubgroup = row.readTable(coupleSubgroups); 

      if (!lessonsMap.containsKey(coupleData.id)) {
        lessonsMap[coupleData.id] = LessonsModel(
          coupleData,
          [CoupleSubgroupModel(coupleData, teacherData, auditoryData, groupData, cSubgroup.number)],
          callData
        );
      }
      else{
        final old = lessonsMap[coupleData.id];
        old!.subgroups.add(CoupleSubgroupModel(old.couple, teacherData, auditoryData, groupData, cSubgroup.number));
      }
    }

    return lessonsMap.values.toList();
  }

  Future updateCoupleSubgroups(Iterable<CoupleSubgroup> coupleSubgroups) async {
    await batch((batch){
      batch.insertAll(
        this.coupleSubgroups,
        coupleSubgroups,
        mode: InsertMode.insertOrReplace
      );
    });
  }

  Future deleteCouplesByIds(Iterable<int> idsToDelete) async {
    await (delete(couples)..where((t) => t.id.isIn(idsToDelete))).go();
  }

  Future deleteAuditoriesByIds(Iterable<int> idsToDelete) async {
    await (delete(auditories)..where((t) => t.id.isIn(idsToDelete))).go();
  }

  Future deleteGroupsByIds(Iterable<int> idsToDelete) async {
    await (delete(groups)..where((t) => t.id.isIn(idsToDelete))).go();
  }

  Future deleteTeachersByIds(Iterable<int> idsToDelete) async {
    await (delete(teachers)..where((t) => t.id.isIn(idsToDelete))).go();
  }

  Future deleteCallsByIds(Iterable<int> timesToDelete, Iterable<int> weekdaysToDelete) async {
    await (delete(calls)..where((t) => t.time.isIn(timesToDelete) & t.weekday.isIn(weekdaysToDelete))).go();
  }
}