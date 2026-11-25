// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInfoAdapter extends TypeAdapter<UserInfo> {
  @override
  final typeId = 1;

  @override
  UserInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInfo()
      ..coupleId = (fields[0] as num).toInt()
      ..showType = fields[2] as ShowType
      ..favoriteGroups = (fields[3] as Set).cast<int>()
      ..favoriteTeachers = (fields[4] as Set).cast<int>()
      ..favoriteAuditories = (fields[5] as Set).cast<int>()
      ..trackedObject = fields[6] as TrackedObject?
      ..saveRoadMap = fields[7] == null ? true : fields[7] as bool
      ..roadMap = fields[8] as RoadMap?
      ..lastSync = fields[9] as DateTime?
      ..syncIntervalMinutes = fields[10] == null
          ? 60
          : (fields[10] as num).toInt();
  }

  @override
  void write(BinaryWriter writer, UserInfo obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.coupleId)
      ..writeByte(2)
      ..write(obj.showType)
      ..writeByte(3)
      ..write(obj.favoriteGroups)
      ..writeByte(4)
      ..write(obj.favoriteTeachers)
      ..writeByte(5)
      ..write(obj.favoriteAuditories)
      ..writeByte(6)
      ..write(obj.trackedObject)
      ..writeByte(7)
      ..write(obj.saveRoadMap)
      ..writeByte(8)
      ..write(obj.roadMap)
      ..writeByte(9)
      ..write(obj.lastSync)
      ..writeByte(10)
      ..write(obj.syncIntervalMinutes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
