import 'package:tktts_schedule/models/data_base.dart';

class CoupleSubgroupModel {
  Couple couple;
  Teacher teacher;
  Auditory auditorie;
  Group group;
  int number = 1;

  CoupleSubgroupModel(
    this.couple,
    this.teacher,
    this.auditorie,
    this.group,
    this.number
  );
}