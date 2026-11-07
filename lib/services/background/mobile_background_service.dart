// import 'package:tktts_schedule/session_info.dart';
// import 'package:workmanager/workmanager.dart';

// class MobileBackgroundService {
//   static const fetchScheduleTask = "fetchScheduleTask";

//   @pragma('vm:entry-point')
//   static void callbackDispatcher() {
//     Workmanager().executeTask((task, inputData) async {
//       try {
//         SessionInfo sessionInfo = SessionInfo();
//         sessionInfo.init();
//         await sessionInfo.scheduleService.updateFavorites(sessionInfo: sessionInfo);
//         print("Фоновая задача '$task' выполнена успешно.");
//         return true;
//       } catch (e) {
//         print("Ошибка в фоновой задаче: $e");
//         return false;
//       }
//     });
//   }
// }