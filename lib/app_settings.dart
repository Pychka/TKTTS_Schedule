import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:hive_ce/hive.dart';
import 'package:tktts_schedule/storage_service.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 6)
class AppSettings {
  @HiveField(0, defaultValue: 2)
  int bottomNavContentAligment = 2;

  AppSettings(){
    bottomNavContentAligmentNotifier = ValueNotifier(bottomNavContentAligmentValue);
  }

  late ValueNotifier<MainAxisAlignment> bottomNavContentAligmentNotifier;

  MainAxisAlignment get bottomNavContentAligmentValue => MainAxisAlignment.values[bottomNavContentAligment];

  set bottomNavContentAligmentValue(MainAxisAlignment value){
    bottomNavContentAligment = value.index;
    bottomNavContentAligmentNotifier.value = value;
    unawaited(StorageService.instance.saveAppSettings(this));
  }


}