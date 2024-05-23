// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyRate _$CurrencyRateFromJson(Map<String, dynamic> json) => CurrencyRate(
      (json['id'] as num).toInt(),
      int.parse(json['Code'] as String),
      json['Ccy'] as String,
      json['CcyNm_EN'] as String,
      json['Date'] as String,
      double.parse(json['Rate'] as String),
      double.parse(json['Diff'] as String),
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
