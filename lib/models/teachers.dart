import 'package:drift/drift.dart';
import 'package:tktts_schedule/models/schedule_object.dart';

@DataClassName('Teacher', implementing: [ScheduleObject])
class Teachers extends Table {
  IntColumn get id => integer()();

  TextColumn get name => text().withLength(min: 1, max: 500)();
  @override
  Set<Column> get primaryKey => {id};
}