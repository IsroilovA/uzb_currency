// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_rate.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyRateAdapter extends TypeAdapter<CurrencyRate> {
  @override
  final int typeId = 0;

  @override
  CurrencyRate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyRate(
      fields[0] as int,
      fields[1] as int,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as double,
      fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyRate obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.currency)
      ..writeByte(3)
      ..write(obj.currencyName)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.rate)
      ..writeByte(6)
      ..write(obj.difference);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyRateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyRate _$CurrencyRateFromJson(Map<String, dynamic> json) => CurrencyRate(
      (json['id'] as num).toInt(),
      (json['code'] as num).toInt(),
      json['currency'] as String,
      json['currencyName'] as String,
      json['date'] as String,
      (json['rate'] as num).toDouble(),
      (json['difference'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrencyRateToJson(CurrencyRate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'currency': instance.currency,
      'currencyName': instance.currencyName,
      'date': instance.date,
      'rate': instance.rate,
      'difference': instance.difference,
    };
