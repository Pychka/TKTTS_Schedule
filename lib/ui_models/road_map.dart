import 'package:hive_ce/hive.dart';
import 'package:tktts_schedule/ui_models/model_type.dart';
import 'package:tktts_schedule/ui_models/show_type.dart';
part 'road_map.g.dart';

@HiveType(typeId: 4)
class RoadMap {
  @HiveField(0)
  int id;
  @HiveField(1)
  ModelType type;
  @HiveField(2)
  RoadMap? previous;
  @HiveField(3, defaultValue: ShowType.today)
  ShowType showType;
  @HiveField(4)
  DateTime? selectedDate;


  RoadMap({
    required this.id,
    required this.type,
    required this.showType,
    this.previous,
    this.selectedDate
  });
}