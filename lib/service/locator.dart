import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:uzb_currency/data/models/currency_rate.dart';
import 'package:uzb_currency/service/currencies_repository.dart';

final GetIt locator = GetIt.instance;

Future<void> initialiseLocator() async {
  //key
  const currenciesKey = 'currencies';
  //box
  final currenciesBox = await Hive.openBox<CurrencyRate?>(currenciesKey);

  locator.registerSingleton(
    CurrenciesRepository(currenciesBox: currenciesBox),
  );
}
