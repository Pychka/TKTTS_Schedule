import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tktts_schedule/nav_item.dart';
import 'package:tktts_schedule/screens/additional/menu_component.dart';
import 'package:tktts_schedule/screens/additional/settings/design_settings_sceen.dart';
import 'package:tktts_schedule/screens/additional/settings/updates_screen.dart';
import 'package:tktts_schedule/screens/schedule_screen.dart';
import 'package:tktts_schedule/screens/settings_screen.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/storage_service.dart';
import 'package:tktts_schedule/ui_models/settings_group.dart';

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const ScheduleScreen(),
    const Center(child:  Text('Экран профиля'),),
    Center(child: const SettingsScreen(
      groups: [
        SettingsGroup(
          title: "Обновление",
          icon: Icons.download_rounded,
          widgets: [
            UpdatesScreen()
          ]
        ),
        SettingsGroup(
          title: 'Дизайн',
          icon: Icons.display_settings_rounded,
          widgets: [
            DesignSettingsSceen()
          ]
        ),
      ]
    )),
  ];
  final List<NavItem> _navItems = const [
    NavItem(
      Icons.table_chart_outlined,
      Icons.table_chart_rounded,
    ),
    NavItem(
      Icons.person_outline,
      Icons.person,
    ),
    NavItem(
      Icons.settings,
      Icons.settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, 
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;

        if(_currentIndex == 0 && await SessionInfo.instance.userInfo.back()){
          await SessionInfo.instance.scheduleService.changeModel(SessionInfo.instance.userInfo.roadMap);
        }
        else if(context.mounted){
          final bool shouldLeave = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Вы хотите выйти?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Остаться'),
                ),
                TextButton(
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (!Platform.isIOS) {
                      exit(0);
                    }
                  },
                  child: const Text('Выйти'),
                ),
              ],
            ),
          ) ??
          false;

          if (shouldLeave && context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Container(
        color: Color(0xFFf4faff),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFFf4faff), 
            extendBody: true,
            body: IndexedStack(
              index: _currentIndex,
              children: _screens,
            ),
            bottomNavigationBar:  MenuComponent(
              navItems: _navItems,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        )
      )
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      await StorageService.instance.saveUserInfo(SessionInfo.instance.userInfo);
    }
  }
}