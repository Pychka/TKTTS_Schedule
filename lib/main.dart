import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:tktts_schedule/screens/main_screen.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/storage_service.dart';

void main() async {
  await StorageService.instance.init();
  SessionInfo.instance.init();
  await initializeDateFormatting('ru', null);
  Intl.defaultLocale = 'ru'; 
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpoofFinny',
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
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en', 'US'),
      ],
      home: const MainScreen(),
    );
  }
}
