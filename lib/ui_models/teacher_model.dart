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
      if(couple.lessonTime == null){
        couple = couple.copyWith(lessonTime: drift.Value<int?>(call.time), lessonWeekday: drift.Value<int?>(call.weekday));
      }
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
  Widget getFooter(LessonsModel lesson) {
    final buttonStyle = TextButton.styleFrom(
      alignment: Alignment.centerLeft, 
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
    final scaler = TextScaler.linear(1);
    return Wrap(
      spacing: 6.0,
      runSpacing: 4.0,
      children: [
        for(final subgroup in lesson.subgroups)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              if(lesson.subgroups.length > 1 || lesson.couple.subgroup > 0)
                Text(
                  "Подгруппа ${subgroup.number}",
                  textScaler: scaler,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey
                  ),
                ),

              Wrap(
                spacing: 5,
                runSpacing: 5,
                alignment: WrapAlignment.start,
                children: [
                  TextButton(onPressed: () {
                      SessionInfo.instance.scheduleService.changeModelToGroup(id: subgroup.group.id);
                    },
                    style: buttonStyle,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 5,
                      children: [
                        Text(
                          subgroup.group.name,
                          textAlign: TextAlign.center,
                          textScaler: scaler,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                          ),
                        ),
                        const Icon(
                          Icons.person_rounded,
                          color: Colors.black87,
                        ),
                      ],
                    )
                  ),
                  TextButton(onPressed: () {
                      SessionInfo.instance.scheduleService.changeModelToAuditory(id: subgroup.auditorie.id);
                    },
                    style: buttonStyle,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 5,
                      children: [
                        Text(
                          subgroup.auditorie.name,
                          textAlign: TextAlign.center,
                          textScaler: scaler,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                          ),
                        ),
                        const Icon(
                          Icons.group_rounded,
                          color: Colors.black87,
                        ),
                      ],
                    )
                  ),
                ],
              )
            ],
          )
      ],
    );
  }
}