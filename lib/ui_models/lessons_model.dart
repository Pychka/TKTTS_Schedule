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
    int now = DateTime.now().toInt();
    int start = couple.date.toInt() + stringToMinute(call.timeStart);
    int end = couple.date.toInt() + stringToMinute(call.timeEnd);
    return now >= start && now <= end;
  }

  static int stringToMinute(String time){
    final parts = time.split(':');
    return parts.length == 2 ? int.parse(parts[0]) * 60 + int.parse(parts[1]) : 0;
  }

  int collision(List<LessonsModel> newLessons, {int? auditoryId, int? teacherId}) {
    return newLessons.indexWhere((lesson) {
      final isBaseEqual = coupleIsEquals(lesson.couple, couple) && lesson.call.time == call.time;
      if (!isBaseEqual) return false;

      bool matchesFilter(CoupleSubgroupModel s) {
        if (auditoryId != null && s.auditorie.id != auditoryId) return false;
        if (teacherId != null && s.teacher.id != teacherId) return false;
        return true;
      }

      final mySubs = subgroups.where(matchesFilter).toList();
      final otherSubs = lesson.subgroups.where(matchesFilter).toList();

      if (mySubs.length != otherSubs.length) return false;

      for (final subgroup in otherSubs) {
        if (!mySubs.any((s) =>
            s.auditorie.id == subgroup.auditorie.id &&
            s.teacher.id == subgroup.teacher.id &&
            s.group.id == subgroup.group.id &&
            s.number == subgroup.number)) {
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
      couple.week == oldCouple.week &&
      couple.weekDay == oldCouple.weekDay &&
      couple.groupId == oldCouple.groupId;
  }

}