// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RetailModelAdapter extends TypeAdapter<RetailModel> {
  @override
  final int typeId = 1;

  @override
  RetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RetailModel(
      name: fields[0] as String,
      phone: fields[1] as String,
      address: fields[2] as String,
      id: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RetailModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
