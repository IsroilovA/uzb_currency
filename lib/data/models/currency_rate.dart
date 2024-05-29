import 'package:hive/hive.dart';
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

  CurrencyRate(this.id, this.code, this.currency, this.currencyName, this.date,
      this.rate, this.difference);

  factory CurrencyRate.fromJson(Map<String, dynamic> json) =>
      _$CurrencyRateFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyRateToJson(this);
}
