// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalesModelAdapter extends TypeAdapter<SalesModel> {
  @override
  final int typeId = 9;

  @override
  SalesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalesModel(
      customer: fields[0] as String,
      product: fields[1] as String,
      nos: fields[2] as String,
      total: fields[3] as String,
      grand: fields[4] as String,
      id: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SalesModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.customer)
      ..writeByte(1)
      ..write(obj.product)
      ..writeByte(2)
      ..write(obj.nos)
      ..writeByte(3)
      ..write(obj.total)
      ..writeByte(4)
      ..write(obj.grand)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
