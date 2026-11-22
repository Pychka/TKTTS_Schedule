import 'package:flutter/material.dart';
import 'package:tktts_schedule/screens/additional/wheel_picker_v2.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/storage_service.dart';

class UpdatesScreen extends StatefulWidget{
  const UpdatesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> with WidgetsBindingObserver {
  int currentValue = SessionInfo.instance.userInfo.syncIntervalMinutes;

  final textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          Text(
            'Автообновление:',
            style: textStyle,
          ),
          Expanded(
            child: WheelPickerV2(
              initialValue: SessionInfo.instance.userInfo.syncIntervalMinutes,
              values: List.generate(22, (i) => 15 + i * 5),
              onChanged: (val) {
                currentValue = val;
                SessionInfo.instance.userInfo.syncIntervalMinutes = val;
                StorageService.instance.saveUserInfo(SessionInfo.instance.userInfo);
              },
              labelBuilder: (val) {
                int hours = val ~/ 60;
                int minutes = val % 60;
                return '${hours > 0 ? '$hours ч. ' : ''}${minutes > 0 ? '$minutes мин.' : ''}'; 
              } 
            ),
          ),
        ],
      ),
    );
  }
}