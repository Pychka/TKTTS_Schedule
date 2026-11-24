import 'package:drift/drift.dart';
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/services/schedule_object_service.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/auditory_model.dart';
import 'package:tktts_schedule/ui_models/lessons_model.dart';

class AuditoryService extends ScheduleObjectService<Auditory, AuditoryModel> {
  @override
  String get baseUrl => "https://rasp.tktts.ru/api/auditory";

  @override
  String get entityName => 'аудиторию';

  @override
  AuditoryModel modelFromJson(Map<String, dynamic> json) => AuditoryModel.fromJson(json);

  @override
  Auditory fromJson(Map<String, dynamic> json) => Auditory.fromJson(json);

  @override
  AuditoryModel createEmpty(int id) =>
    AuditoryModel(Auditory(id: id, name: "", updatedAt: DateTime.now()), []);
    
  @override
  AuditoryModel create(Auditory obj, List<LessonsModel> lessons) =>
    AuditoryModel(obj, lessons);

  @override
  Future<AuditoryModel> getFromDb(int id) =>
    SessionInfo.instance.scheduleService.dataBase.getAuditoryV2(id);

  @override
  Future<List<Auditory>> getListFromDb() async =>
    await SessionInfo.instance.scheduleService.dataBase.auditories.all().get();

  @override
  int collision(LessonsModel oldLesson, List<LessonsModel> newLessons, Auditory object) =>
    oldLesson.collision(newLessons, auditoryId: object.id);
}