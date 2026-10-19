import 'package:drift/drift.dart';
import 'package:tktts_schedule/models/couples.dart';
import 'package:tktts_schedule/models/calls.dart';

class CoupleCalls extends Table {
  IntColumn get coupleId => integer().references(Couples, #id, onDelete: KeyAction.cascade)();
  IntColumn get lessonWeekday => integer()();
  IntColumn get lessonTime => integer()();
  @override
  Set<Column> get primaryKey => {coupleId, lessonWeekday, lessonTime};

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY (lesson_weekday, lesson_time) REFERENCES calls (weekday, time) ON DELETE CASCADE'
  ];
}