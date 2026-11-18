import 'package:hive_ce/hive.dart';
part 'show_type.g.dart';

@HiveType(typeId: 2)
enum ShowType {
  @HiveField(0)
  all,
  @HiveField(1)
  today,
  @HiveField(2)
  fromToday,
  @HiveField(3)
  singleDay,
}