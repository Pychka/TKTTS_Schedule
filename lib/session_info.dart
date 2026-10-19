import 'package:tktts_schedule/services/schedule_service.dart';
import 'package:tktts_schedule/storage_service.dart';
import 'package:tktts_schedule/user_info.dart';

class SessionInfo{
  late UserInfo userInfo;
  late ScheduleService scheduleService;
  SessionInfo._internal();

  static final SessionInfo instance = SessionInfo._internal();

  void init(){
    scheduleService = ScheduleService();
    userInfo = StorageService.instance.getUserInfo() ?? UserInfo();
  }
}