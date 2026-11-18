import 'package:drift/drift.dart';
import 'package:tktts_schedule/models/schedule_object.dart';

@DataClassName('Auditory', implementing: [ScheduleObject])
class Auditories extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().withLength(min: 1, max: 500)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}