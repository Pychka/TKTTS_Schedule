import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:native_workmanager/native_workmanager.dart';
import 'package:tktts_schedule/screens/main_screen.dart';
import 'package:tktts_schedule/services/background/android_background_sync_helper.dart';
import 'package:tktts_schedule/services/background/sync_schedule_worker.dart';
import 'package:tktts_schedule/services/notifications/android_notification_service.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/storage_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.init();
  SessionInfo.instance.init();
  await initializeDateFormatting('ru', null);
  Intl.defaultLocale = 'ru'; 
  if(Platform.isAndroid){
    await NativeWorkManager.initialize(
      dartWorkers: {
        'sync-schedule': syncScheduleWorker,
      },
      registerPlugins: true,
      debugMode: kDebugMode,
    );
    await AndroidNotificationService.init(requestPermissions: true);
    await AndroidBackgroundSyncHelper.schedulePeriodicSync(SessionInfo.instance.userInfo.syncIntervalMinutes);
  }
  // if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
  //   await Workmanager().initialize(
  //     MobileBackgroundService.callbackDispatcher, 
  //   );
    
  //   await Workmanager().registerPeriodicTask(
  //     "schedule_sync_id",
  //     MobileBackgroundService.fetchScheduleTask,
  //     frequency: const Duration(minutes: 16),
  //     constraints: Constraints(networkType: NetworkType.connected),
  //     existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
  //   );
  // }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tktts Schedule',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlueAccent,
          brightness: Brightness.light, 
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Color(0xFF94A3B8)
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en', 'US'),
      ],
      home: const MainScreen(),
    );
  }
}
