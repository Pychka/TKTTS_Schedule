import 'package:drift/drift.dart';
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/services/schedule_object_service.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/lessons_model.dart';
import 'package:tktts_schedule/ui_models/teacher_model.dart';

class TeacherService extends ScheduleObjectService<Teacher, TeacherModel> {
  @override
  String get baseUrl => "https://rasp.tktts.ru/api/teacher";
  
  @override
  String get entityName => 'преподавателя';

  @override
  TeacherModel modelFromJson(Map<String, dynamic> json) => TeacherModel.fromJson(json);

  @override
  Teacher fromJson(Map<String, dynamic> json) => Teacher.fromJson(json);

  @override
  TeacherModel createEmpty(int id) =>
    TeacherModel(Teacher(id: id, name: "", updatedAt: DateTime.now()), []);

  @override
  TeacherModel create(Teacher obj, List<LessonsModel> lessons) =>
    TeacherModel(obj, lessons);

  @override
  Future<TeacherModel> getFromDb(int id) =>
    SessionInfo.instance.scheduleService.dataBase.getTeacherModelV2(id);

  @override
  Future<List<Teacher>> getListFromDb() async =>
    await SessionInfo.instance.scheduleService.dataBase.teachers.all().get();

  @override
  int collision(LessonsModel oldLesson, List<LessonsModel> newLessons, Teacher object) =>
    oldLesson.collision(newLessons, teacherId: object.id);
}