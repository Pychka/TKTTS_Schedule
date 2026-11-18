import 'package:hive_ce/hive_ce.dart';

@HiveType(typeId: 3)
enum ModelType {
  @HiveField(0)
  teacher,
  @HiveField(1)
  auditory,
  @HiveField(2)
  group,
}