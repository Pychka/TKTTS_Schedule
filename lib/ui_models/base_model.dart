import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/lessons_model.dart';

class BaseModel<T extends ScheduleObject> extends ChangeNotifier {
  T _scheduleObject;
  T get scheduleObject => _scheduleObject;

  set scheduleObject(T value) {
    if (_scheduleObject == value) return;
    _scheduleObject = value;
    notifyListeners(); 
  }
  List<LessonsModel> lessons;
  List<LessonsModel> lessonsToShow;
  BaseModel(
    this._scheduleObject,
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

  Map<DateTime, List<LessonsModel>> get groupedRawLessons => groupBy(lessons, (lesson) => lesson.couple.date );

  Widget getFooter(LessonsModel lesson, bool isCurrent){
    return Text('Заглушка');
  }

  TextButton getObjectFooterButton(ScheduleObject object, IconData icon, bool isCurrent, Future<dynamic> Function({required int id, bool changeSelection}) changeModel, {MainAxisAlignment align = MainAxisAlignment.start}){
    final buttonStyle = TextButton.styleFrom(
      alignment: Alignment.centerLeft, 
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
    final scaler = TextScaler.linear(1);
    return TextButton(
      onPressed: () {
        changeModel(id: object.id);
      },
      style: buttonStyle,
      child: Row(
        mainAxisAlignment: align,
        mainAxisSize: MainAxisSize.min,
        spacing: 5,
        children: [
          Icon(
            icon,
            color: isCurrent ? Colors.white : Colors.black87
          ),
          Flexible(
            child: Text(
              object.name,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              textScaler: scaler,
              maxLines: 2, 
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: isCurrent ? const Color.fromARGB(255, 223, 221, 221) : Colors.black87
              ),
            ),
          ),
        ],
      )
    );
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