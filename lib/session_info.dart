import 'dart:io';

import 'package:tktts_schedule/services/background/mobile_background_service.dart';
import 'package:tktts_schedule/services/background/windows_background_service.dart';
import 'package:tktts_schedule/services/schedule_service.dart';
import 'package:tktts_schedule/storage_service.dart';
import 'package:tktts_schedule/user_info.dart';

class SessionInfo{
  late UserInfo userInfo;
  late ScheduleService scheduleService;
  SessionInfo._internal();
  SessionInfo();
  // late MobileBackgroundService mobileBackgroundService;
  // late WindowsBackgroundService windowsBackgroundService;
  static final SessionInfo instance = SessionInfo._internal();

  void init(){
    scheduleService = ScheduleService();
    userInfo = StorageService.instance.getUserInfo() ?? UserInfo();
    scheduleService.showType = userInfo.showType;
  }

  // void startApp(bool kIsWeb){
  //   if(kIsWeb){

  //   }
  //   else if(Platform.isWindows){
  //     windowsBackgroundService = WindowsBackgroundService()..startWindowsSync();
  //   }
  // }
}