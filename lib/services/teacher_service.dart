import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/services/schedule_object_service.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/lessons_model.dart';
import 'package:tktts_schedule/ui_models/receipt_type.dart';
import 'package:tktts_schedule/ui_models/schedule_object_metadata.dart';
import 'package:tktts_schedule/ui_models/teacher_model.dart';

class TeacherService implements ScheduleObjectService<Teacher, TeacherModel> {
  final baseUrl = "https://rasp.tktts.ru/api";

  @override
  Future<ScheduleObjectMetadata<List<Teacher>>> getMany() async {
    ScheduleObjectMetadata<List<Teacher>> result;
    try{
      final response = await http.get(Uri.parse('$baseUrl/teacher'));
      if(response.statusCode == 200){
        final List<dynamic> jsonList = jsonDecode(response.body);
        final teachers = jsonList.map((rawJson) {
          final json = Map<String, dynamic>.from(rawJson as Map);
          if (json['updatedAt'] == null) {
            json['updatedAt'] = DateTime.now().toIso8601String();
          }
          return Teacher.fromJson(json);
        }).toList();

        result = ScheduleObjectMetadata(teachers, ReceiptType.api);
        await updateMany(result.object);
      }
      else{
        throw Exception('Не удалось загрузить группы');
      }
    }
    on SocketException{
      result = ScheduleObjectMetadata(await SessionInfo.instance.scheduleService.dataBase.teachers.all().get(), ReceiptType.db);
    }
    on HandshakeException {
      result = ScheduleObjectMetadata(await SessionInfo.instance.scheduleService.dataBase.teachers.all().get(), ReceiptType.db);
    }
    return result;
  }

  @override
  Future<ScheduleObjectMetadata<TeacherModel>> get({required int id, DateTime? from}) async {
    try{
      final response = await http.get(Uri.parse('$baseUrl/teacher/$id?timetable=true${from == null ? "" : "&fromDate=$from"}'));
      if(response.statusCode == 200){
        Map<String, dynamic> data = json.decode(response.body);
        final newModel = TeacherModel.fromJson(data);
        await update(newModel);
        return ScheduleObjectMetadata(newModel, ReceiptType.api);
      }
      if(response.statusCode == 204){
        return ScheduleObjectMetadata(TeacherModel(Teacher(id: id, name: "",  updatedAt: DateTime.now()), []), ReceiptType.mock);
      }
      else{
        throw Exception('Не удалось загрузить преподавателя');
      }
    }
    on SocketException{
      return ScheduleObjectMetadata(await SessionInfo.instance.scheduleService.dataBase.getTeacherModelV2(id), ReceiptType.db);
    }
    on HandshakeException {
      return ScheduleObjectMetadata(await SessionInfo.instance.scheduleService.dataBase.getTeacherModelV2(id), ReceiptType.db);
    }
  }

  @override
  Future update(TeacherModel newModel) async {
    TeacherModel oldModel = await SessionInfo.instance.scheduleService.dataBase.getTeacherModelV2(newModel.scheduleObject.id);
    List<LessonsModel> oldLessons = List.from(oldModel.lessons);
    List<LessonsModel> newLessons = List.from(newModel.lessons);
    LessonsModel oldLesson;
    for(int i = 0; i < oldLessons.length; i++){
      oldLesson = oldLessons[i];
      final collision = oldLesson.collision(newLessons);
      if(collision != -1){
        oldLessons.removeAt(i--);
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
      final modelToSave = TeacherModel(newModel.scheduleObject, newLessons);
      await modelToSave.save();
    }
  }

  @override
  Future updateMany(List<Teacher> auditories) async{
    final old = await SessionInfo.instance.scheduleService.dataBase.teachers.all().get();
    List<Teacher> oldTeachers = List.from(old);
    List<Teacher> newTeachers = List.from(auditories);
    Teacher newTeacher;
    for(int i = 0; i < newTeachers.length; i++){
      newTeacher = newTeachers[i];
      final index = oldTeachers.indexWhere((old) => old.name == newTeacher.name);
      if(index != -1){
        oldTeachers.removeAt(index);
        newTeachers.removeAt(i--);
      }
    }
    if (oldTeachers.isNotEmpty) {
      final idsToDelete = oldTeachers.map((l) => l.id).toList();
      await SessionInfo.instance.scheduleService.dataBase.deleteTeachersByIds(idsToDelete); 
    }

    if (newTeachers.isNotEmpty) {
      await SessionInfo.instance.scheduleService.dataBase.updateTeachers(newTeachers);
    }
  }
}