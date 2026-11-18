// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'road_map.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoadMapAdapter extends TypeAdapter<RoadMap> {
  @override
  final typeId = 4;

  @override
  RoadMap read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoadMap(
      id: (fields[0] as num).toInt(),
      type: fields[1] as ModelType,
      previous: fields[2] as RoadMap?,
    );
  }

  @override
  void write(BinaryWriter writer, RoadMap obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.previous);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoadMapAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
