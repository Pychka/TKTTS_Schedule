import 'package:drift/drift.dart';
import 'package:tktts_schedule/models/groups.dart';

class Couples extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get subject => text().withLength(min: 1, max: 500)();
  IntColumn get subgroup => integer()();
  IntColumn get week => integer()();
  IntColumn get weekDay => integer()();
  IntColumn get groupId => integer().references(Groups, #id, onDelete: KeyAction.cascade).nullable()();
  DateTimeColumn get date => dateTime()();
  IntColumn get lessonWeekday => integer().nullable()();
  IntColumn get lessonTime => integer().nullable()();

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY (lesson_weekday, lesson_time) REFERENCES calls (weekday, time) ON DELETE CASCADE'
  ];
}