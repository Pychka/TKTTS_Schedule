import 'package:drift/drift.dart';
import 'package:tktts_schedule/models/auditories.dart';
import 'package:tktts_schedule/models/couples.dart';
import 'package:tktts_schedule/models/groups.dart';
import 'package:tktts_schedule/models/teachers.dart';

class CoupleSubgroups extends Table {
  IntColumn get coupleId => integer().references(Couples, #id, onDelete: KeyAction.cascade)();
  IntColumn get auditoryId => integer().references(Auditories, #id, onDelete: KeyAction.cascade)();
  IntColumn get teacherId => integer().references(Teachers, #id, onDelete: KeyAction.cascade)();
  IntColumn get groupId => integer().references(Groups, #id, onDelete: KeyAction.cascade)();
  IntColumn get number => integer()();
  @override
  Set<Column> get primaryKey => {coupleId, auditoryId, teacherId, groupId};
}