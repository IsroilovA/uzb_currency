import 'package:json_annotation/json_annotation.dart';

part 'currency_rate.g.dart';

@JsonSerializable()
class CurrencyRate {
  int id;
  int code;
  String currency;
  String currencyName;
  String date;
  double rate;
  double difference;

  CurrencyRate(this.id, this.code, this.currency, this.currencyName, this.date,
      this.rate, this.difference);

  factory CurrencyRate.fromJson(Map<String, dynamic> json) =>
      _$CurrencyRateFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyRateToJson(this);
}
