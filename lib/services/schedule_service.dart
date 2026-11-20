import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/screens/additional/search_component_v2.dart';
import 'package:tktts_schedule/services/auditory_service.dart';
import 'package:tktts_schedule/services/calls_service.dart';
import 'package:tktts_schedule/services/couple_service.dart';
import 'package:tktts_schedule/services/group_service.dart';
import 'package:tktts_schedule/services/schedule_object_service.dart';
import 'package:tktts_schedule/services/teacher_service.dart';
import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/storage_service.dart';
import 'package:tktts_schedule/ui_models/base_model.dart';
import 'package:tktts_schedule/ui_models/model_type.dart';
import 'package:tktts_schedule/ui_models/receipt_type.dart';
import 'package:tktts_schedule/ui_models/road_map.dart';
import 'package:tktts_schedule/ui_models/schedule_object_metadata.dart';
import 'package:tktts_schedule/ui_models/show_type.dart';
import 'package:tktts_schedule/session_info.dart';

class ScheduleService {
  final groupService = GroupService();
  final teacherService = TeacherService();
  final auditoryService = AuditoryService();
  final callService = CallService();
  final coupleService = CoupleService();
  ScheduleObject? selectedObject;
  ScheduleObjectMetadata<BaseModel>? _currentModel;
  late List<ScheduleObject> objects;
  ValueNotifier<ScheduleObjectMetadata<BaseModel>?> currentModelNotifier = ValueNotifier(null);
  final GlobalKey<SearchComponentV2State> _searchKey = GlobalKey<SearchComponentV2State>();
  ShowType _showType = ShowType.all;
  DataBase dataBase = DataBase();
  Future<void> Function(ScheduleObject? object, Future<void> Function()? action)? onChangeModel;

  ScheduleService(this.onChangeModel);

  ScheduleObjectMetadata<BaseModel>? get currentModel => _currentModel;
  set currentModel(ScheduleObjectMetadata<BaseModel>? value){
    _currentModel = value;
    currentModelNotifier.value = value;
    changeShow(type: _showType);
  }

  ShowType get showType => _showType;
  set showType(ShowType showType){
    _showType = showType;
    SessionInfo.instance.userInfo.showType = showType;
    StorageService.instance.saveUserInfo(SessionInfo.instance.userInfo);
    changeShow(type: _showType);
  }


  Future uploadSchedule({ScheduleObject? object}) async {
    if(object != null){
      selectedObject = object;
    }
    if(selectedObject == null){
      return;
    }
    if(selectedObject case Group group){
      changeModelToGroup(id: group.id);
    }
    else if(selectedObject case Auditory auditory){
      changeModelToAuditory(id: auditory.id);
    }
    else if(selectedObject case Teacher teacher){
      changeModelToTeacher(id: teacher.id);
    }
  }

  Future<bool> uploadScheduleSearch(ValueChanged<ScheduleObject?> onScheduleObjectSelected) async {
    final results = await Future.wait([
      groupService.getMany(),
      teacherService.getMany(),
      auditoryService.getMany(),
      callService.getMany(true),
    ]);

    final List<ScheduleObject> groups = (results[0] as ScheduleObjectMetadata<List<ScheduleObject>>).object;
    final List<ScheduleObject> teachers = (results[1] as ScheduleObjectMetadata<List<ScheduleObject>>).object;
    final List<ScheduleObject> auditories = (results[2] as ScheduleObjectMetadata<List<ScheduleObject>>).object;
    objects = [...groups, ...teachers, ...auditories];
    objects.sort(compareObjects);
    if(objects.isNotEmpty && SessionInfo.instance.userInfo.saveRoadMap){
      changeModel(SessionInfo.instance.userInfo.roadMap);
    }
    return objects.isNotEmpty;
  }

  Future changeModelToAuditory({required int id, bool changeSelection = true}) async {
    await baseChangeModel<Auditory>(id: id, changeSelection: changeSelection);
  }

  Future changeModelToGroup({required int id, bool changeSelection = true}) async {
    await baseChangeModel<Group>(id: id, changeSelection: changeSelection);
  }

  Future changeModelToTeacher({required int id, bool changeSelection = true}) async {
    await baseChangeModel<Teacher>(id: id, changeSelection: changeSelection);
  }

  Future baseChangeModel<T extends ScheduleObject>({required int id, bool changeSelection = true}) async {
    if(onChangeModel == null) return;
    final obj = objects.whereType<T>().firstWhereOrNull((obj) => obj.id == id);
    await onChangeModel!(obj, () async {
      if(obj == null) return;
      currentModel = await getService<T>().get(id: id);
      if(changeSelection){
        _searchKey.currentState?.changeSelection(obj);
        SessionInfo.instance.userInfo.changeSelection(obj);
      }
    });
  }

  Future changeModel(RoadMap? roadMap) async {
    if(roadMap == null){
      currentModel = null;
      if(onChangeModel != null){
        await onChangeModel!(null, null);
      }
      return;
    }
    switch(roadMap.type){
      case ModelType.auditory:
        await changeModelToAuditory(id: roadMap.id, changeSelection: false);
      break;
      case ModelType.teacher:
        await changeModelToTeacher(id: roadMap.id, changeSelection: false);
      break;
      case ModelType.group:
        await changeModelToGroup(id: roadMap.id, changeSelection: false);
      break;
    }
  }

  void changeShow({required ShowType type, DateTime? date}){
    if(_currentModel == null){
      return;
    }
    final model = _currentModel!.object;
    switch(type){
      case ShowType.all:
        model.setLessonsToShow(model.lessons);
      break;
      case ShowType.today:
        model.setLessonsToShow(model.lessons.where((element) => dateEquals(element.couple.date, DateTime.now())).toList());
      break;
      case ShowType.fromToday:
        model.setLessonsToShow(model.lessons.where((element) => dateGreaterOrEquals(element.couple.date, DateTime.now())).toList());
      break;
      case ShowType.singleDay:
        if(date == null) return;
        model.setLessonsToShow(model.lessons.where((element) => dateGreaterOrEquals(element.couple.date, date)).toList());
      break;
    }
  }

  Future updateFavorites({SessionInfo? sessionInfo}) async{
    final session = sessionInfo ?? SessionInfo.instance;

    if (session.userInfo.favoriteGroups.isNotEmpty) {
      await _updateByIds(session.userInfo.favoriteGroups, groupService);
    }
    if (session.userInfo.favoriteAuditories.isNotEmpty) {
      await _updateByIds(session.userInfo.favoriteAuditories, auditoryService);
    }
    if (session.userInfo.favoriteTeachers.isNotEmpty) {
      await _updateByIds(session.userInfo.favoriteTeachers, teacherService);
    }
  }

  Future<void> _updateByIds(Iterable<int> ids, ScheduleObjectService service) async {
    for (final id in ids) {
      final model = await service.get(id: id);
      if (model.receiptType == ReceiptType.api) {
        await service.update(model.object);
      }
    }
  }

  int _getTypeWeight(ScheduleObject obj) {
    if (obj is Group) return 1;
    if (obj is Teacher) return 2;
    if (obj is Auditory) return 3;
    return 4;
  }

  ScheduleObjectService getService<T extends ScheduleObject>(){
    return switch(T){
      const (Group) => groupService as ScheduleObjectService,
      const (Teacher) => teacherService as ScheduleObjectService,
      const (Auditory) => auditoryService as ScheduleObjectService,
      _ => throw Exception("Unsupported model type")
    };
  }

  bool _isFavorite(ScheduleObject obj) =>
    SessionInfo.instance.userInfo.isFavorite(obj);

  int compareObjects(ScheduleObject a, ScheduleObject b) {
    final aFav = _isFavorite(a);
    final bFav = _isFavorite(b);
    if (aFav != bFav) {
      return aFav ? -1 : 1;
    }
    
    final aType = _getTypeWeight(a);
    final bType = _getTypeWeight(b);
    if (aType != bType) {
      return aType.compareTo(bType);
    }

    return a.name.toLowerCase().compareTo(b.name.toLowerCase());
  }
  
  static bool dateEquals(DateTime a, DateTime b) =>
    a.day == b.day && a.month == b.month && a.year == b.year;
  
  bool dateGreaterOrEquals(DateTime a, DateTime b) =>
    a.year > b.year || a.year == b.year && ((a.day >= b.day && a.month == b.month) || (a.month > b.month));
}