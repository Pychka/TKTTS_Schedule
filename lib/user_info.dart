import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/storage_service.dart';
import 'package:tktts_schedule/ui_models/model_type.dart';
import 'package:tktts_schedule/ui_models/road_map.dart';
import 'package:tktts_schedule/ui_models/show_type.dart';
import 'package:tktts_schedule/ui_models/tracked_object.dart';
part 'user_info.g.dart';

@HiveType(typeId: 1)
class UserInfo {
  @HiveField(0)
  int coupleId = 1;
  // 1 has busy
  @HiveField(2)
  ShowType showType = ShowType.fromToday;
  @HiveField(3)
  Set<int> favoriteGroups = {};
  @HiveField(4)
  Set<int> favoriteTeachers = {};
  @HiveField(5)
  Set<int> favoriteAuditories = {};
  @HiveField(6)
  TrackedObject? trackedObject;
  @HiveField(7, defaultValue: true)
  bool saveRoadMap = true;
  @HiveField(8)
  RoadMap? roadMap;
  @HiveField(9)
  DateTime? lastSync;
  @HiveField(10, defaultValue: 60)
  int syncIntervalMinutes = 60;

  Future<bool> back() async {
    if(roadMap == null) return false;

    roadMap = roadMap!.previous;
    await StorageService.instance.saveUserInfo(this);
    return true;
  }

  set saveRoadMapValue(bool value){
    saveRoadMap = value;
    if(!value){
      roadMap = null;
    }
  }

  Future changeSelection(ScheduleObject obj, { DateTime? selectedDate }) async {
    if(!saveRoadMap){
      return;
    }

    roadMap = RoadMap(
      id: obj.id,
      type: switch(obj){
        Group _ => ModelType.group,
        Teacher _ => ModelType.teacher,
        Auditory _ => ModelType.auditory,
        _ => throw Exception("Unsupported type")
      },
      previous: roadMap,
      showType: showType,
      selectedDate: selectedDate
    );
    await StorageService.instance.saveUserInfo(this);
  }

  Future startTrack(ScheduleObject? obj) async {
    if(obj == null){
      trackedObject = null;
    }
    else{
      trackedObject = TrackedObject(
        id: obj.id, 
        type: switch(obj){
          Group _ => ModelType.group,
          Teacher _ => ModelType.teacher,
          Auditory _ => ModelType.auditory,
          _ => throw Exception("Unsupported type")
        }
      );
    }
    await StorageService.instance.saveUserInfo(this);
  }

  Future addFavorite(ScheduleObject obj) async {
    final set = _getSet(obj);
    if(!set.add(obj.id)){
      set.remove(obj.id);
    }
    await StorageService.instance.saveUserInfo(this);
  }

  bool isFavorite(ScheduleObject obj) => _getSet(obj).contains(obj.id);

  Set<int> _getSet(ScheduleObject obj){
    if(obj is Group) return favoriteGroups;
    if(obj is Teacher) return favoriteTeachers;
    if(obj is Auditory) return favoriteAuditories;
    return {};
  }
}