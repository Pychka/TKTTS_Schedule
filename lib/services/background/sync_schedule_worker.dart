  import 'package:tktts_schedule/services/schedule_service.dart';
  import 'package:flutter/widgets.dart';
  import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:tktts_schedule/session_info.dart';
  import 'package:tktts_schedule/storage_service.dart';

  @pragma('vm:entry-point')
  Future<bool> syncScheduleWorker(Map<String, dynamic>? input) async {
    WidgetsFlutterBinding.ensureInitialized();
    ScheduleService? scheduleService;

    try {
      await StorageService.instance.init();
      final userInfo = await StorageService.instance.getUserInfo();

      if (userInfo == null ||
          (userInfo.favoriteAuditories.isEmpty &&
              userInfo.favoriteGroups.isEmpty &&
              userInfo.favoriteTeachers.isEmpty &&
              userInfo.trackedObject == null)) {
        return true;
      }

      SessionInfo.instance.userInfo = userInfo;
      scheduleService = ScheduleService(null);
      SessionInfo.instance.scheduleService = scheduleService;

      await scheduleService.updateFavorites(sessionInfo: SessionInfo.instance);

      userInfo.lastSync = DateTime.now();
      await StorageService.instance.saveUserInfo(userInfo);
      return true;
    } catch (e, stack) {
      debugPrint('Ошибка фоновой синхронизации: $e\n$stack');
      return false;
    } finally {
      await scheduleService?.dataBase.close();
      await Hive.close();
    }
  }