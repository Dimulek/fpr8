// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pr_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrModelAdapter extends TypeAdapter<PrModel> {
  @override
  final int typeId = 0;

  @override
  PrModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrModel(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      full_description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PrModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.full_description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
