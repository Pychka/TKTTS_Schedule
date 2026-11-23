import 'package:tktts_schedule/app_settings.dart';
import 'package:tktts_schedule/services/schedule_service.dart';
import 'package:tktts_schedule/storage_service.dart';
import 'package:tktts_schedule/user_info.dart';

class SessionInfo{
  late UserInfo userInfo;
  late AppSettings appSettings;
  late ScheduleService scheduleService;
  SessionInfo._internal();
  SessionInfo();

  static final SessionInfo instance = SessionInfo._internal();

  Future init() async {
    userInfo = await StorageService.instance.getUserInfo() ?? UserInfo();
    appSettings = await StorageService.instance.getAppSettings() ?? AppSettings();
    scheduleService = ScheduleService(null);
    scheduleService.showType = userInfo.showType;
  }
}