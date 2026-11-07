// import 'dart:async';

// import 'package:tktts_schedule/session_info.dart';

// class WindowsBackgroundService {
//   Timer? _syncTimer;

//   void startWindowsSync() {
//       _syncTimer?.cancel();
      
//       _syncTimer = Timer.periodic(const Duration(hours: 1), (timer) async {
//         try{
//           await SessionInfo.instance.scheduleService.updateFavorites();
//         }
//         catch(e){
//           print("Ошибка в фоновой задаче: $e");
//         }
//       });
//   }

//   void dispose() {
//     _syncTimer?.cancel();
//   }
// }