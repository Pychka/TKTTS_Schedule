import 'package:hive_ce/hive.dart';
import 'package:tktts_schedule/ui_models/model_type.dart';
part 'road_map.g.dart';

@HiveType(typeId: 4)
class RoadMap {
  @HiveField(0)
  int id;
  @HiveField(1)
  ModelType type;
  @HiveField(2)
  RoadMap? previous;

  RoadMap({
    required this.id,
    required this.type,
    this.previous
  });
}