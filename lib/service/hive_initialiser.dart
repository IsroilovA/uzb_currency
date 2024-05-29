import 'package:hive/hive.dart';
import 'package:uzb_currency/data/models/currency_pinned.dart';
import 'package:uzb_currency/data/models/currency_rate.dart';
import 'package:uzb_currency/service/currencies_repository.dart';

Future<void> initialiseHive() async {
  //key
  const currenciesKey = 'currencies';
  const currenciesPinnedKey = 'currenciesPinned';
  //adapters
  Hive.registerAdapter(CurrencyRateAdapter());
  Hive.registerAdapter(CurrencyPinnedAdapter());
  //boxes
  final currenciesBox = await Hive.openBox<CurrencyRate?>(currenciesKey);
  final currenciesPinnedBox =
      await Hive.openBox<CurrencyPinned?>(currenciesPinnedKey);
  //repo
  CurrenciesRepository(
      currenciesBox: currenciesBox, currenciesPinnedBox: currenciesPinnedBox);
}
