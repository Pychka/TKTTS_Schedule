import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/storage_service.dart';
import 'package:tktts_schedule/ui_models/model_type.dart';
import 'package:tktts_schedule/ui_models/show_type.dart';
part 'user_info.g.dart';

@HiveType(typeId: 1)
class UserInfo {
  @HiveField(0)
  int coupleId = 1;
  @HiveField(1)
  int callId = 1;
  @HiveField(2)
  ShowType showType = ShowType.fromToday;
  @HiveField(3)
  Set<int> favoriteGroups = {};
  @HiveField(4)
  Set<int> favoriteTeachers = {};
  @HiveField(5)
  Set<int> favoriteAuditories = {};
  @HiveField(6)
  (int, ModelType)? trackedObject;

  void addFavorite(ScheduleObject obj){
    final set = _getSet(obj);
    if(!set.add(obj.id)){
      set.remove(obj.id);
    }
    StorageService.instance.saveUserInfo(this);
  }

  bool isFavorite(ScheduleObject obj) => _getSet(obj).contains(obj.id);

  Icon getFavoriteIcon(ScheduleObject obj){
    final any = isFavorite(obj);
    return Icon(
      any ? Icons.favorite_sharp
          : Icons.favorite_outline,
      color:
        any ? Color(0xEFff0284)
        : Colors.grey
      );
  }

  Set<int> _getSet(ScheduleObject obj){
    if(obj is Group) return favoriteGroups;
    if(obj is Teacher) return favoriteTeachers;
    if(obj is Auditory) return favoriteAuditories;
    return {};
  }
}