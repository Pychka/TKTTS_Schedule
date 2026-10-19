import 'package:drift/drift.dart';

class Calls extends Table {
  IntColumn get weekday => integer()();
  IntColumn get time => integer()();
  TextColumn get timeStart => text().withLength(min: 1, max: 500)();
  TextColumn get timeEnd => text().withLength(min: 1, max: 500)();
  @override
  Set<Column> get primaryKey => {weekday, time};
}