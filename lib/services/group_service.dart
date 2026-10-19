import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/services/schedule_object_service.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/group_model.dart';
import 'package:tktts_schedule/ui_models/lessons_model.dart';
import 'package:tktts_schedule/ui_models/receipt_type.dart';
import 'package:tktts_schedule/ui_models/schedule_object_metadata.dart';

class GroupService implements ScheduleObjectService<Group, GroupModel> {
  final baseUrl = "https://rasp.tktts.ru/api";

  @override
  Future<ScheduleObjectMetadata<List<Group>>> getMany() async {
    ScheduleObjectMetadata<List<Group>> result;
    try{
      final response = await http.get(Uri.parse('$baseUrl/group'));
      if(response.statusCode == 200){
        final List<dynamic> jsonList = jsonDecode(response.body);
        result = ScheduleObjectMetadata(jsonList.map((json) => Group.fromJson(json)).toList(), ReceiptType.api);
        await updateMany(result.object);
      }
      else{
        throw Exception('Не удалось загрузить группы');
      }
    }
    on SocketException{
      result = ScheduleObjectMetadata(await SessionInfo.instance.scheduleService.dataBase.select(SessionInfo.instance.scheduleService.dataBase.groups).get(), ReceiptType.db);
    }
    on HandshakeException {
      result = ScheduleObjectMetadata(await SessionInfo.instance.scheduleService.dataBase.select(SessionInfo.instance.scheduleService.dataBase.groups).get(), ReceiptType.db);
    }
    return result;
  }

  @override
  Future<ScheduleObjectMetadata<GroupModel>> get({required int id, DateTime? from}) async {
    try{
      final response = await http.get(Uri.parse('$baseUrl/group/$id?timetable=true${from == null ? "" : "&fromDate=$from"}'));
      if(response.statusCode == 200){
        Map<String, dynamic> data = json.decode(response.body);
        final newModel = GroupModel.fromJson(data);
        await update(newModel);
        return ScheduleObjectMetadata(newModel, ReceiptType.api);
      }
      if(response.statusCode == 204){
        return ScheduleObjectMetadata(GroupModel(Group(id: id, name: ""), []), ReceiptType.mock);
      }
      else{
        throw Exception('Не удалось загрузить группу');
      }
    }
    on SocketException{
      return ScheduleObjectMetadata(await SessionInfo.instance.scheduleService.dataBase.getGroupModelV2(id), ReceiptType.db);
    }
    on HandshakeException {
      return ScheduleObjectMetadata(await SessionInfo.instance.scheduleService.dataBase.getGroupModelV2(id), ReceiptType.db);
    }
  }

  @override
  Future update(GroupModel newModel) async {
    GroupModel oldModel = await SessionInfo.instance.scheduleService.dataBase.getGroupModelV2(newModel.scheduleObject.id);
    List<LessonsModel> oldLessons = List.from(oldModel.lessons);
    List<LessonsModel> newLessons = List.from(newModel.lessons);
    LessonsModel oldLesson;
    for(int i = 0; i < oldLessons.length; i++){
      oldLesson = oldLessons[i];
      final collision = oldLesson.collision(newLessons);
      if(collision != -1){
        oldLessons.removeAt(i);
        i--;
        newLessons.removeAt(collision);
      }
    }
    // in oldLessons lessons to remove
    // in newLessons lessons to add
    if (oldLessons.isNotEmpty) {
      final idsToDelete = oldLessons.map((l) => l.couple.id).toList();
      await SessionInfo.instance.scheduleService.dataBase.deleteCouplesByIds(idsToDelete); 
    }

    if (newLessons.isNotEmpty) {
      final modelToSave = GroupModel(newModel.scheduleObject, newLessons);
      await modelToSave.save();
    }
  }

  @override
  Future updateMany(List<Group> auditories) async{
    final old = await SessionInfo.instance.scheduleService.dataBase.groups.all().get();
    List<Group> oldGroups = List.from(old);
    List<Group> newGroups = List.from(auditories);
    Group newGroup;
    for(int i = 0; i < newGroups.length; i++){
      newGroup = newGroups[i];
      final index = oldGroups.indexWhere((old) => old.name == newGroup.name);
      if(index != -1){
        oldGroups.removeAt(index);
        newGroups.removeAt(i--);
      }
    }
    if (oldGroups.isNotEmpty) {
      final idsToDelete = oldGroups.map((l) => l.id).toList();
      await SessionInfo.instance.scheduleService.dataBase.deleteGroupsByIds(idsToDelete); 
    }

    if (newGroups.isNotEmpty) {
      await SessionInfo.instance.scheduleService.dataBase.updateGroups(newGroups);
    }
  }
}