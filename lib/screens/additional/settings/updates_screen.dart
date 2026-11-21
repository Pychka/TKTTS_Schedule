import 'package:flutter/material.dart';
import 'package:tktts_schedule/screens/additional/wheel_picker.dart';
import 'package:tktts_schedule/services/background/android_background_sync_helper.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/storage_service.dart';

class UpdatesScreen extends StatefulWidget{
  const UpdatesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> with WidgetsBindingObserver {
  int currentValue = SessionInfo.instance.userInfo.syncIntervalMinutes;
  final buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.blueAccent,
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
    return Scaffold(
      backgroundColor: Color(0xFFf4faff),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () async {
                      if(currentValue != SessionInfo.instance.userInfo.syncIntervalMinutes){
                        SessionInfo.instance.userInfo.syncIntervalMinutes = currentValue;
                        StorageService.instance.saveUserInfo(SessionInfo.instance.userInfo);
                        await AndroidBackgroundSyncHelper.schedulePeriodicSync(currentValue);
                      }
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  ),
                  Expanded(
                    child: Text(
                      "Обновления",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Text(
                'Обновлять расписание через:',
                style: textStyle,
              ),
              WheelPicker(
                initialMinutes: SessionInfo.instance.userInfo.syncIntervalMinutes,
                onChanged: (val) => currentValue = val,
                labelBuilder: (val) {
                  int hours = val ~/ 60;
                  int minutes = val % 60;
                  return '${hours > 0 ? '$hours ч. ' : ''}${minutes > 0 ? '$minutes мин.' : ''}'; 
                } 
              ),
            ],
          ),
        )
      )
    );
  }
}