// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LengthModelAdapter extends TypeAdapter<LengthModel> {
  @override
  final int typeId = 12;

  @override
  LengthModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LengthModel(
      catlength: fields[0] as String?,
      prolength: fields[1] as String?,
      custlength: fields[2] as String?,
      outoflength: fields[3] as String?,
      salevalue: fields[4] as String?,
      id: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, LengthModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.catlength)
      ..writeByte(1)
      ..write(obj.prolength)
      ..writeByte(2)
      ..write(obj.custlength)
      ..writeByte(3)
      ..write(obj.outoflength)
      ..writeByte(4)
      ..write(obj.salevalue)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LengthModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
