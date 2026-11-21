import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:flutter/rendering.dart';
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
        final groups = jsonList.map((rawJson) {
          final json = Map<String, dynamic>.from(rawJson as Map);
          if (json['updatedAt'] == null) {
            json['updatedAt'] = DateTime.now().toIso8601String();
          }
          return Group.fromJson(json);
        }).toList();

        result = ScheduleObjectMetadata(groups, ReceiptType.api);
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
        
        final db = SessionInfo.instance.scheduleService.dataBase;
        final all = await (db.select(db.couples)
              ..where((c) => c.groupId.equals(newModel.scheduleObject.id)))
            .get();
        final nullWeekday = all.where((c) => c.lessonWeekday == null).length;
        final nullTime = all.where((c) => c.lessonTime == null).length;
        debugPrint('DB: всего ${all.length}, nullWeekday=$nullWeekday, nullTime=$nullTime');
        debugPrint('API: ${newModel.lessons.length}');
        
        final changes = await update(newModel);
        return ScheduleObjectMetadata(newModel, ReceiptType.api, changes: (changes.$1, changes.$2));
      }
      if(response.statusCode == 204){
        return ScheduleObjectMetadata(GroupModel(Group(id: id, name: "",  updatedAt: DateTime.now()), []), ReceiptType.mock);
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
  Future<(List<LessonsModel> removed, List<LessonsModel> added, String name)> update(GroupModel newModel) async {
    GroupModel oldModel = await SessionInfo.instance.scheduleService.dataBase.getGroupModelV2(newModel.scheduleObject.id);
    List<LessonsModel> oldLessons = List.from(oldModel.lessons);
    List<LessonsModel> newLessons = List.from(newModel.lessons);
    debugPrint('before ${oldLessons.length} ${newLessons.length} ${newModel.scheduleObject.name}');
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
debugPrint('after ${oldLessons.length} ${newLessons.length} ${newModel.scheduleObject.name}');
for (final l in newLessons) {
  debugPrint('  НЕ СОВПАЛА ПАРА: date=${l.couple.date}, time=${l.call.time}, subj=${l.couple.subject}, subs=${l.subgroups.length}');
}
    return (oldLessons, newLessons, newModel.scheduleObject.name);
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