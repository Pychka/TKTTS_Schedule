import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/base_model.dart';
import 'package:tktts_schedule/ui_models/couple_subgroup_model.dart';
import 'package:tktts_schedule/ui_models/lessons_model.dart';
import 'package:drift/drift.dart' as drift;

class TeacherModel extends BaseModel<Teacher> {

  TeacherModel(
    super.scheduleObject,
    super.lessons
  );
  
  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    final teacherJson = Map<String, dynamic>.from(json)..remove('lessons');
    if (!teacherJson.containsKey('updatedAt') || teacherJson['updatedAt'] == null) {
      teacherJson['updatedAt'] = DateTime.now().toIso8601String(); 
    }
    final Teacher parsedTeacher = Teacher.fromJson(teacherJson);
    final List<dynamic> rawLessons = json['lessons'] as List<dynamic>? ?? [];
    List<dynamic> rawData;
    final List<LessonsModel> parse = [];
    for(final rawLesson in rawLessons){
      final lessonJson = Map<String, dynamic>.from(rawLesson as Map);
      if (!lessonJson.containsKey('id') || lessonJson['id'] == null) {
        lessonJson['id'] = SessionInfo.instance.userInfo.coupleId++; 
      }
      final groupJson = Map<String, dynamic>.from(lessonJson['group'] as Map);
      groupJson['updatedAt'] ??= DateTime.now().toIso8601String();

      final Group parsedGroup = Group.fromJson(groupJson);
      rawData = lessonJson['teachers'] as List<dynamic>? ?? [];
      final nowIso = DateTime.now().toIso8601String();

      rawData = lessonJson['auditories'] as List<dynamic>? ?? [];
      List<Auditory> auditories = rawData.map((rawAuditory) {
        final auditoryJson = Map<String, dynamic>.from(rawAuditory as Map);
        auditoryJson['updatedAt'] ??= nowIso;
        return Auditory.fromJson(auditoryJson);
      }).toList();
      final callData = lessonJson['call'];
      if (!lessonJson.containsKey('groupId') || lessonJson['groupId'] == null) {
        lessonJson['groupId'] = parsedGroup.id;
      }
      Couple couple = Couple.fromJson(lessonJson);
      if (!callData.containsKey('weekday') || callData['weekday'] == null) {
        callData['weekday'] = couple.weekDay;
      }
      
      final call = Call.fromJson(callData);
      couple = couple.copyWith(
        lessonTime:    drift.Value<int?>(call.time),
        lessonWeekday: drift.Value<int?>(call.weekday),
      );
      final lesson = LessonsModel(
        couple,
        [CoupleSubgroupModel(couple, parsedTeacher, auditories.first, parsedGroup, couple.subgroup)],
        call
      );
      LessonsModel? old = parse.firstWhereOrNull((oldLesson) => 
        oldLesson.couple.date == lesson.couple.date
        && oldLesson.call.time == lesson.call.time
        && oldLesson.couple.subject == lesson.couple.subject
      );
      if(old == null){
        parse.add(lesson);
      }
      else{
        old.subgroups.add(CoupleSubgroupModel(old.couple, parsedTeacher, auditories.first, parsedGroup, old.couple.subgroup + 1));
        old.couple = old.couple.copyWith(subgroup: old.couple.subgroup + 1);
      }
    }
    

    return TeacherModel(
      parsedTeacher,
      parse,
    );
  }

  @override
  Widget getFooter(LessonsModel lesson, bool isCurrent) {
    final scaler = TextScaler.linear(1);
    final hasSubgroups = lesson.subgroups.length > 1 || lesson.couple.subgroup > 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if(hasSubgroups)
          Text(
            "Подгруппы:",
            textScaler: scaler,
            style: TextStyle(
              fontSize: 16,
              color: isCurrent ? Colors.white70 : Colors.grey
            ),
          ),
        for(final subgroup in lesson.subgroups)
          Row(
            children: [
              if(hasSubgroups)
                Text(
                  "${subgroup.number}:",
                  textScaler: scaler,
                  style: TextStyle(
                    fontSize: 15,
                    color: isCurrent ? Colors.white70 : Colors.black87
                  ),
                ),
              Expanded(
                child: getObjectFooterButton(subgroup.group, Icons.group_rounded, isCurrent, SessionInfo.instance.scheduleService.changeModelToGroup),
              ),
              getObjectFooterButton(subgroup.auditorie, Icons.door_back_door_rounded, isCurrent, SessionInfo.instance.scheduleService.changeModelToAuditory),
          ],
        )
      ],
    );
  }
}