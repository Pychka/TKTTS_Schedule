import 'package:flutter/material.dart';
import 'package:tktts_schedule/screens/additional/wheel_picker_v2.dart';
import 'package:tktts_schedule/session_info.dart';

class DesignSettingsSceen extends StatefulWidget{
  const DesignSettingsSceen({super.key});

  @override
  State<StatefulWidget> createState() => _DesignSettingsSceenState();
}

class _DesignSettingsSceenState extends State<DesignSettingsSceen> with WidgetsBindingObserver {
  MainAxisAlignment currentValue = SessionInfo.instance.appSettings.bottomNavContentAligmentValue;

  final textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          Text(
            'Расположение элементов в панели задач:',
            style: textStyle,
          ),
          WheelPickerV2(
            initialValue: SessionInfo.instance.appSettings.bottomNavContentAligmentNotifier.value,
            values: [MainAxisAlignment.start, MainAxisAlignment.center, MainAxisAlignment.end],
            onChanged: (val) {
              currentValue = val;
              SessionInfo.instance.appSettings.bottomNavContentAligmentValue = val;
            },
            labelBuilder: (val) => switch(val){
              MainAxisAlignment.center => "По центру",
              MainAxisAlignment.start => "С лева",
              MainAxisAlignment.end => "С права",
              _ => val.toString()
            }
          ),
        ],
      ),
    );
  }
}