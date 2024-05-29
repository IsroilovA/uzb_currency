// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_pinned.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyPinnedAdapter extends TypeAdapter<CurrencyPinned> {
  @override
  final int typeId = 1;

  @override
  CurrencyPinned read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyPinned(
      fields[0] as int,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyPinned obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyPinnedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
