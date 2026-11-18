import 'package:hive_ce/hive.dart';
import 'package:tktts_schedule/ui_models/model_type.dart';
part 'tracked_object.g.dart';

@HiveType(typeId: 5)
class TrackedObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  ModelType type;

  TrackedObject({required this.id, required this.type});
}