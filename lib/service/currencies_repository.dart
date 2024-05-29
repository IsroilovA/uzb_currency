import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:uzb_currency/data/models/currency_pinned.dart';
import 'package:uzb_currency/data/models/currency_rate.dart';
import 'package:uzb_currency/service/helper_functions.dart';

//class to fetch curencies from remote API
class CurrenciesRepository {
  CurrenciesRepository(
      {required Box<CurrencyRate?> currenciesBox,
      required Box<CurrencyPinned?> currenciesPinnedBox})
      : _currenciesBox = currenciesBox,
        _currenciesPinnedBox = currenciesPinnedBox;

  final _client = http.Client();
  final Box<CurrencyPinned?> _currenciesPinnedBox;
  final Box<CurrencyRate?> _currenciesBox;

  //fetch data fucntion
  Future<List<CurrencyRate>> getCurrencies(
      {required DateTime date, String? currency}) async {
    //fromat date to insert into the link
    final formattedDate = dateFormatter.format(date);
    //variable to hold the response
    final http.Response response;
    //ckeck if currency was passed and insert if needed
    if (currency != null) {
      response = await _client.get(Uri.parse(
          "https://cbu.uz/ru/arkhiv-kursov-valyut/json/$currency/$formattedDate/"));
    } else {
      response = await _client.get(Uri.parse(
          "https://cbu.uz/ru/arkhiv-kursov-valyut/json/all/$formattedDate/"));
    }
    //check for status code
    if (response.statusCode != 200) {
      throw Exception('Something went wrong. Try again later');
    }
    final json = jsonDecode(response.body) as List<dynamic>;
    final posts = json.map(
      (e) => CurrencyRate.fromMap(
        Map<String, dynamic>.from(e as Map<String, dynamic>),
      ),
    );
    return posts.toList();
  }

  Future<void> saveCurrenciesLocally(List<CurrencyRate> currencies) async {
    for (final currency in currencies) {
      await _currenciesBox.put(currency.id, currency);
    }
  }

  Future<List<CurrencyRate?>> fetchAllLocalCurrencies() async {
    final localCurrencies = _currenciesBox.values.toList();
    return localCurrencies;
  }

  Future<List<CurrencyRate?>> fetchPinnedCurrencies() async {
    final List<CurrencyRate?> pinnedCurrencies = [];
    for (var element in _currenciesPinnedBox.values) {
      pinnedCurrencies.add(_currenciesBox.get(element!.id));
    }
    return pinnedCurrencies;
  }

  Future<void> pinUnpinCurrency(CurrencyRate currencyRate) async {
    if (_currenciesPinnedBox.keys.contains(currencyRate.code)) {
      await _currenciesPinnedBox.delete(currencyRate.code);
    } else {
      await _currenciesPinnedBox.put(
        currencyRate.code,
        CurrencyPinned(currencyRate.id, currencyRate.code),
      );
    }
  }

  bool isCurrencyPinned(CurrencyRate currencyRate) {
    final isPinned = _currenciesPinnedBox.keys.contains(currencyRate.code);
    if (isPinned) {
      return true;
    } else {
      return false;
    }
  }
}
