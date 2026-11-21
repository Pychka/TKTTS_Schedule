import 'package:flutter/material.dart';
import 'package:tktts_schedule/nav_item.dart';
import 'package:tktts_schedule/screens/additional/menu_component.dart';
import 'package:tktts_schedule/screens/schedule_screen.dart';
import 'package:tktts_schedule/screens/settings_screen.dart';

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
    const Center(child: SettingsScreen()),
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
    return Container(
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
    );
  }
}

class Person{
  int calculate(int a, int b, {
    int c = 0,
    int d = 0
  }){
    return a + b + c + d;
  }

  void start(){
    debugPrint(calculate(11, 12, c: 20).toString());
  } 
}