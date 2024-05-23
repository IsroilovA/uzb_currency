import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uzb_currency/data/models/currency_rate.dart';
import 'package:uzb_currency/service/helper_functions.dart';

class ApiHelper {
  static Future<List<CurrencyRate>?> fetchCurrencies(
      {required DateTime date, String? currency}) async {
    final insertedDate = dateFormatter.format(date);
    final http.Response response;
    if (currency != null) {
      response = await http.get(Uri.parse(
          "https://cbu.uz/ru/arkhiv-kursov-valyut/json/$currency/$insertedDate/"));
    } else {
      response = await http.get(Uri.parse(
          "https://cbu.uz/ru/arkhiv-kursov-valyut/json/all/$insertedDate/"));
    }

    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);
      return body.map((e) => CurrencyRate.fromJson(e)).toList();
    } else {
      return null;
    }
  }
}
