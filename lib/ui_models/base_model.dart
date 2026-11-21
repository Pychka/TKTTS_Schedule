import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/lessons_model.dart';

class BaseModel<T extends ScheduleObject> extends ChangeNotifier {
  T scheduleObject;
  List<LessonsModel> lessons;
  List<LessonsModel> lessonsToShow;
  BaseModel(
    this.scheduleObject,
    this.lessons
  ) : lessonsToShow = lessons;

  void clearLessons(){
    lessons.clear();
    notifyListeners();
  }

  void setLessons(List<LessonsModel> lessons){
    this.lessons = lessons;
    notifyListeners();
  }

  void setLessonsToShow(List<LessonsModel> lessons){
    lessonsToShow = lessons;
    notifyListeners();
  }

  Map<DateTime, List<LessonsModel>> get groupedLessons => groupBy(lessonsToShow, (lesson) => lesson.couple.date );

  Widget getFooter(LessonsModel lesson){
    return Text('Заглушка');
  }

  Future save() async{
    Set<Auditory> auditories = {};
    Set<Teacher> teachers = {};
    Set<Group> groups = {};
    for(final lesson in lessons){
      for(final subgroup in lesson.subgroups){
        auditories.add(subgroup.auditorie);
        teachers.add(subgroup.teacher);
        groups.add(subgroup.group);
      }
    }
    await SessionInfo.instance.scheduleService.dataBase.transaction(() async {
      await SessionInfo.instance.scheduleService.dataBase.updateAuditories(auditories);
      await SessionInfo.instance.scheduleService.dataBase.updateTeachers(teachers);
      await SessionInfo.instance.scheduleService.dataBase.updateGroups(groups);
      await SessionInfo.instance.scheduleService.dataBase.updateCalls(lessons.map((e) => e.call));
      await SessionInfo.instance.scheduleService.dataBase.updateCouples(lessons.map((e) => e.couple));
      await SessionInfo.instance.scheduleService.dataBase.updateCoupleCall(
        lessons.map((l) => 
          CoupleCall(coupleId: l.couple.id, lessonTime: l.call.time, lessonWeekday: l.call.weekday)
        )
      );
      await SessionInfo.instance.scheduleService.dataBase.updateCoupleSubgroups(
        lessons.expand((l) => 
          l.subgroups.map((s) =>
            CoupleSubgroup(coupleId: s.couple.id, auditoryId: s.auditorie.id, teacherId: s.teacher.id, groupId: s.group.id, number: s.number)
          )
        )
      );
    });
  }
}