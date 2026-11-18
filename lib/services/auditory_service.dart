import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/services/schedule_object_service.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/auditory_model.dart';
import 'package:tktts_schedule/ui_models/lessons_model.dart';
import 'package:tktts_schedule/ui_models/receipt_type.dart';
import 'package:tktts_schedule/ui_models/schedule_object_metadata.dart';

class AuditoryService implements ScheduleObjectService<Auditory, AuditoryModel> {
  final baseUrl = "https://rasp.tktts.ru/api";

  @override
  Future<ScheduleObjectMetadata<List<Auditory>>> getMany() async {
    ScheduleObjectMetadata<List<Auditory>> result;
    try{
      final response = await http.get(Uri.parse('$baseUrl/auditory'));
      if(response.statusCode == 200){
        final List<dynamic> jsonList = jsonDecode(response.body);
        final auditories = jsonList.map((rawJson) {
          final json = Map<String, dynamic>.from(rawJson as Map);
          if (json['updatedAt'] == null) {
            json['updatedAt'] = DateTime.now().toIso8601String();
          }
          return Auditory.fromJson(json);
        }).toList();

        result = ScheduleObjectMetadata(auditories, ReceiptType.api);
      }
      else{
        throw Exception('Не удалось загрузить группы');
      }
    }
    on SocketException{
      result = ScheduleObjectMetadata(await SessionInfo.instance.scheduleService.dataBase.auditories.all().get(), ReceiptType.db);
    }
    on HandshakeException {
      result = ScheduleObjectMetadata(await SessionInfo.instance.scheduleService.dataBase.auditories.all().get(), ReceiptType.db);
    }
    return result;
  }

  @override
  Future<ScheduleObjectMetadata<AuditoryModel>> get({required int id, DateTime? from}) async {
    try{
      final response = await http.get(Uri.parse('$baseUrl/auditory/$id?timetable=true${from == null ? "" : "&fromDate=$from"}'));
      if(response.statusCode == 200){
        Map<String, dynamic> data = json.decode(response.body);
        return ScheduleObjectMetadata(AuditoryModel.fromJson(data), ReceiptType.api);
      }
      if(response.statusCode == 204){
        return ScheduleObjectMetadata(AuditoryModel(Auditory(id: id, name: "",  updatedAt: DateTime.now()), []), ReceiptType.mock);
      }
      else{
        throw Exception('Не удалось загрузить аудиторию');
      }
    }
    on SocketException{
      return ScheduleObjectMetadata(await SessionInfo.instance.scheduleService.dataBase.getAuditoryV2(id), ReceiptType.db);
    }
    on HandshakeException {
      return ScheduleObjectMetadata(await SessionInfo.instance.scheduleService.dataBase.getAuditoryV2(id), ReceiptType.db);
    }
  }

  @override
  Future update(AuditoryModel newModel) async {
    AuditoryModel oldModel = await SessionInfo.instance.scheduleService.dataBase.getAuditoryV2(newModel.scheduleObject.id);
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
      final modelToSave = AuditoryModel(newModel.scheduleObject, newLessons);
      await modelToSave.save();
    }
  }

  @override
  Future updateMany(List<Auditory> auditories) async{
    final old = await SessionInfo.instance.scheduleService.dataBase.auditories.all().get();
    List<Auditory> oldAuditories = List.from(old);
    List<Auditory> newAuditories = List.from(auditories);
    Auditory newAuditory;
    for(int i = 0; i < newAuditories.length; i++){
      newAuditory = newAuditories[i];
      final index = oldAuditories.indexWhere((old) => old.name == newAuditory.name);
      if(index != -1){
        oldAuditories.removeAt(index);
        newAuditories.removeAt(i--);
      }
    }
    if (oldAuditories.isNotEmpty) {
      final idsToDelete = oldAuditories.map((l) => l.id).toList();
      await SessionInfo.instance.scheduleService.dataBase.deleteAuditoriesByIds(idsToDelete); 
    }

    if (newAuditories.isNotEmpty) {
      await SessionInfo.instance.scheduleService.dataBase.updateAuditories(newAuditories);
    }
  }
}