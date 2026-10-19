import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/screens/additional/search_component.dart';
import 'package:tktts_schedule/services/auditory_service.dart';
import 'package:tktts_schedule/services/calls_service.dart';
import 'package:tktts_schedule/services/couple_service.dart';
import 'package:tktts_schedule/services/group_service.dart';
import 'package:tktts_schedule/services/teacher_service.dart';
import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/storage_service.dart';
import 'package:tktts_schedule/ui_models/base_model.dart';
import 'package:tktts_schedule/ui_models/schedule_object_metadata.dart';
import 'package:tktts_schedule/ui_models/show_type.dart';
import 'package:tktts_schedule/session_info.dart';

class ScheduleService {
  final groupService = GroupService();
  final teacherService = TeacherService();
  final auditoryService = AuditoryService();
  final callService = CallService();
  final coupleService = CoupleService();
  late SearchComponent searchComponent;
  ScheduleObject? selectedObject;
  ScheduleObjectMetadata<BaseModel>? _currentModel;
  late List<ScheduleObject> objects;
  ValueNotifier<ScheduleObjectMetadata<BaseModel>?> currentModelNotifier = ValueNotifier(null);
  final GlobalKey<SearchComponentState> _searchKey = GlobalKey<SearchComponentState>();
  ShowType _showType = ShowType.all;
  DataBase dataBase = DataBase();


  ScheduleObjectMetadata<BaseModel>? get currentModel => _currentModel;
  set currentModel(ScheduleObjectMetadata<BaseModel>? value){
    _currentModel = value;
    currentModelNotifier.value = value;
    changeShow(_showType);
  }

  ShowType get showType => _showType;
  set showType(ShowType showType){
    _showType = showType;
    SessionInfo.instance.userInfo.showType = showType;
    StorageService.instance.saveUserInfo(SessionInfo.instance.userInfo);
    changeShow(_showType);
  }


  Future uploadSchedule() async {
    if(selectedObject == null){
      return;
    }
    if(selectedObject case Group group){
      currentModel = await groupService.get(id: group.id);
    }
    else if(selectedObject case Auditory auditory){
      currentModel = await auditoryService.get(id: auditory.id);
    }
    else if(selectedObject case Teacher teacher){
      currentModel = await teacherService.get(id: teacher.id);
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
    searchComponent = SearchComponent(key: _searchKey, objects: objects, onScheduleObjectSelected: onScheduleObjectSelected);
    return objects.isNotEmpty;
  }

  void changeModelToAuditory(int id) async {
    final obj = objects.whereType<Auditory>().firstWhereOrNull((obj) => obj.id == id);
    if(obj == null) return;
    currentModel = await auditoryService.get(id: id);
    _searchKey.currentState?.changeSelection(obj);
  }

  void changeModelToGroup(int id) async {
    final obj = objects.whereType<Group>().firstWhereOrNull((obj) => obj.id == id);
    if(obj == null) return;
    currentModel = await groupService.get(id: id);
    _searchKey.currentState?.changeSelection(obj);
  }

  void changeModelToTeacher(int id) async {
    final obj = objects.whereType<Teacher>().firstWhereOrNull((obj) => obj.id == id);
    if(obj == null) return;
    currentModel = await teacherService.get(id: id);
    _searchKey.currentState?.changeSelection(obj);
  }

  void changeShow(ShowType type){
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
    }
  }

  int _getTypeWeight(ScheduleObject obj) {
    if (obj is Group) return 1;
    if (obj is Teacher) return 2;
    if (obj is Auditory) return 3;
    return 4;
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