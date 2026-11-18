// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShowTypeAdapter extends TypeAdapter<ShowType> {
  @override
  final typeId = 2;

  @override
  ShowType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ShowType.all;
      case 1:
        return ShowType.today;
      case 2:
        return ShowType.fromToday;
      case 3:
        return ShowType.singleDay;
      default:
        return ShowType.all;
    }
  }

  @override
  void write(BinaryWriter writer, ShowType obj) {
    switch (obj) {
      case ShowType.all:
        writer.writeByte(0);
      case ShowType.today:
        writer.writeByte(1);
      case ShowType.fromToday:
        writer.writeByte(2);
      case ShowType.singleDay:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShowTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
