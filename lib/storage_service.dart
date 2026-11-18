import 'package:hive_ce_flutter/adapters.dart';
import 'package:tktts_schedule/ui_models/model_type.dart';
import 'package:tktts_schedule/ui_models/road_map.dart';
import 'package:tktts_schedule/ui_models/show_type.dart';
import 'package:tktts_schedule/ui_models/tracked_object.dart';
import 'package:tktts_schedule/user_info.dart';

class StorageService {
  StorageService._internal();

  static final StorageService instance = StorageService._internal();

  static const String _boxName = 'tktts_schedule_records';
  static const String _userKey = 'user_info_data';

  late Box<UserInfo> _userBox;

  Future<void> init() async{
    await Hive.initFlutter();
    
    Hive.registerAdapter(UserInfoAdapter());
    Hive.registerAdapter(ShowTypeAdapter());
    Hive.registerAdapter(ModelTypeAdapter());
    Hive.registerAdapter(RoadMapAdapter());
    Hive.registerAdapter(TrackedObjectAdapter());
    _userBox = await Hive.openBox<UserInfo>(_boxName);
  }

  UserInfo? getUserInfo() {
    return _userBox.get(_userKey);
  }

  void saveUserInfo(UserInfo userInfo) {
    _userBox.put(_userKey, userInfo);
  }

  void clearProgress() {
    _userBox.delete(_userKey);
  }
}