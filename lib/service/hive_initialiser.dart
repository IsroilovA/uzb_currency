import 'package:hive/hive.dart';
import 'package:uzb_currency/data/models/currency_rate.dart';
import 'package:uzb_currency/service/currencies_repository.dart';

Future<void> initialiseHive() async {
  //key
  const currenciesKey = 'currencies';
  //adapters
  Hive.registerAdapter(CurrencyRateAdapter());
  //box
  final currenciesBox = await Hive.openBox<CurrencyRate?>(currenciesKey);
  //repo
  CurrenciesRepository(currenciesBox: currenciesBox);
}
