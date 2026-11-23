import 'package:hive_ce_flutter/adapters.dart';
import 'package:tktts_schedule/app_settings.dart';
import 'package:tktts_schedule/ui_models/model_type.dart';
import 'package:tktts_schedule/ui_models/road_map.dart';
import 'package:tktts_schedule/ui_models/show_type.dart';
import 'package:tktts_schedule/ui_models/tracked_object.dart';
import 'package:tktts_schedule/user_info.dart';

class StorageService {
  StorageService._internal();

  static final StorageService instance = StorageService._internal();

  bool _isInitialized = false;

  static const String _boxName = 'tktts_schedule_records';
  static const String _userKey = 'user_info_data';
  static const String _appSettingsKey = 'app_settings_data';

  late Box _userBox;

  Future init() async{
    if(_isInitialized) return;
    await Hive.initFlutter();
    
    Hive.registerAdapter(UserInfoAdapter());
    Hive.registerAdapter(ShowTypeAdapter());
    Hive.registerAdapter(ModelTypeAdapter());
    Hive.registerAdapter(RoadMapAdapter());
    Hive.registerAdapter(TrackedObjectAdapter());
    Hive.registerAdapter(AppSettingsAdapter());
    _userBox = await Hive.openBox(_boxName);
    _isInitialized = true;
  }

  Future<Box> _getBox() async {
    if (_userBox.isOpen){
      _userBox = await Hive.openBox(_boxName);
    }
     return _userBox;
  }

  Future<UserInfo?> getUserInfo() async => await _get(_userKey);

  Future saveUserInfo(UserInfo userInfo) async => await _save(userInfo, _userKey);

  Future<AppSettings?> getAppSettings() async => await _get(_appSettingsKey);

  Future saveAppSettings(AppSettings appSettings) async => await _save(appSettings, _appSettingsKey);

  Future<T?> _get<T>(String key) async{
    final box = await _getBox();
    return box.get(key);
  }

  Future _save<T>(T data, String key) async {
    final box = await _getBox();
    box.put(key, data);
  }

  Future clearProgress() async {
    final box = await _getBox();
    box.delete(_userKey);
  }
}