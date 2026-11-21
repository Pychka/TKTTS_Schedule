import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tktts_schedule/screens/additional/settings/updates_screen.dart';

class SettingsScreen extends StatefulWidget{
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with WidgetsBindingObserver {
  final buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Color.fromARGB(255, 75, 168, 255),
    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
    elevation: 3, 
    shadowColor: Colors.black.withValues(alpha: 0.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ); 
  final textStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, 
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        debugPrint(didPop.toString());
        if (didPop) return;

        final bool shouldLeave = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Выйти?'),
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
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Настройки",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),
            Divider(),
            _getButton(
              Icons.system_update_alt_rounded,
              "Обновление",
              nav: UpdatesScreen()
            ),
            _getButton(
              Icons.notifications_active_rounded,
              "Уведомления"
            ),
          ],
        ),
      )
    );
  }

  ElevatedButton _getButton(IconData icon, String text, { Widget? nav}){
    return ElevatedButton(
      style: buttonStyle,
      onPressed: 
      () {
        if(nav != null) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => nav),
          );
        }
      },
      child: Row(
        spacing: 7.5,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          Text(
            text,
            style: textStyle,
          ),
        ],
      )
    );
  }
}