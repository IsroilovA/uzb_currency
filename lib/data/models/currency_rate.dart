import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currency_rate.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class CurrencyRate {
  @HiveField(0)
  int id;
  @HiveField(1)
  int code;
  @HiveField(2)
  String currency;
  @HiveField(3)
  String currencyName;
  @HiveField(4)
  String date;
  @HiveField(5)
  double rate;
  @HiveField(6)
  double difference;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'curreny': currency,
      'currencyName': currencyName,
      'date': date,
      'rate': rate,
      'difference': difference,
    };
  }

  factory CurrencyRate.fromMap(Map<String, dynamic> map) {
    return CurrencyRate(
      map['id'] as int,
      map['code'] as int,
      map['currency'] as String,
      map['currencyName'] as String,
      map['date'] as String,
      map['rate'] as double,
      map['difference'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  CurrencyRate(this.id, this.code, this.currency, this.currencyName, this.date,
      this.rate, this.difference);

  factory CurrencyRate.fromJson(String source) =>
      CurrencyRate.fromMap(json.decode(source) as Map<String, dynamic>);
}
