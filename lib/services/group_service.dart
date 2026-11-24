import 'package:drift/drift.dart';
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/services/schedule_object_service.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/group_model.dart';
import 'package:tktts_schedule/ui_models/lessons_model.dart';

class GroupService extends ScheduleObjectService<Group, GroupModel> {
  @override
  String get baseUrl => "https://rasp.tktts.ru/api/group";
  
  @override
  String get entityName => 'группу';

  @override
  GroupModel modelFromJson(Map<String, dynamic> json) => GroupModel.fromJson(json);

  @override
  Group fromJson(Map<String, dynamic> json) => Group.fromJson(json);

  @override
  GroupModel createEmpty(int id) =>
    GroupModel(Group(id: id, name: "", updatedAt: DateTime.now()), []);

  @override
  GroupModel create(Group obj, List<LessonsModel> lessons) =>
    GroupModel(obj, lessons);

  @override
  Future<GroupModel> getFromDb(int id) =>
    SessionInfo.instance.scheduleService.dataBase.getGroupModelV2(id);

  @override
  Future<List<Group>> getListFromDb() async =>
    await SessionInfo.instance.scheduleService.dataBase.groups.all().get();

  @override
  int collision(LessonsModel oldLesson, List<LessonsModel> newLessons, Group object) =>
    oldLesson.collision(newLessons);
}