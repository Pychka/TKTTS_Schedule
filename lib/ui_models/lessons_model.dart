import 'package:flutter/rendering.dart';
import 'package:tktts_schedule/date_time_to_int.dart';
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/ui_models/couple_subgroup_model.dart';

class LessonsModel {
  Couple couple;
  List<CoupleSubgroupModel> subgroups;
  Call call;

  LessonsModel(
    this.couple,
    this.subgroups,
    this.call
  );

  bool isCurrent() {
    int now = DateTime(2026, 11, 20, 10, 30).toInt();
    int start = couple.date.toInt() + stringToMinute(call.timeStart);
    int end = couple.date.toInt() + stringToMinute(call.timeEnd);
    return now >= start && now <= end;
  }

  static int stringToMinute(String time){
    final parts = time.split(':');
    return parts.length == 2 ? int.parse(parts[0]) * 60 + int.parse(parts[1]) : 0;
  }

  int collision(List<LessonsModel> newLessons) {
    return newLessons.indexWhere((lesson) {
      final isBaseEqual = coupleIsEquals(lesson.couple, couple) && lesson.call.time == call.time;

      if (!isBaseEqual) return false;

     if(lesson.subgroups.length != subgroups.length) return false;
     for(final subgroup in lesson.subgroups){
      if(!subgroups.any((s) => 
        s.auditorie.id == subgroup.auditorie.id
        && s.teacher.id == subgroup.teacher.id
        && s.group.id == subgroup.group.id
        && s.number == subgroup.number)){
          return false;
        }
     }
      
      return true;
    });
  }

  static bool coupleIsEquals(Couple couple, Couple oldCouple){
    return 
      couple.date.year == oldCouple.date.year &&
      couple.date.month == oldCouple.date.month &&
      couple.date.day == oldCouple.date.day &&
      couple.subject == oldCouple.subject &&
      couple.subgroup == oldCouple.subgroup &&
      couple.groupId == oldCouple.groupId;
  }

}