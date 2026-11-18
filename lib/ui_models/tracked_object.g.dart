// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracked_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackedObjectAdapter extends TypeAdapter<TrackedObject> {
  @override
  final typeId = 5;

  @override
  TrackedObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrackedObject(
      id: (fields[0] as num).toInt(),
      type: fields[1] as ModelType,
    );
  }

  @override
  void write(BinaryWriter writer, TrackedObject obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackedObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
