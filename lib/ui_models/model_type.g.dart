// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelTypeAdapter extends TypeAdapter<ModelType> {
  @override
  final typeId = 3;

  @override
  ModelType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ModelType.teacher;
      case 1:
        return ModelType.auditory;
      case 2:
        return ModelType.group;
      default:
        return ModelType.teacher;
    }
  }

  @override
  void write(BinaryWriter writer, ModelType obj) {
    switch (obj) {
      case ModelType.teacher:
        writer.writeByte(0);
      case ModelType.auditory:
        writer.writeByte(1);
      case ModelType.group:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
