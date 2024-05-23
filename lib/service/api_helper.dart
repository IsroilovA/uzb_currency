import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uzb_currency/data/models/currency_rate.dart';

class ApiHelper {
  static Future<List<CurrencyRate>?> fetchCurrencies() async {
    final response = await http.get(Uri.parse(
        "https://cbu.uz/ru/arkhiv-kursov-valyut/json/all/2024-05-23/"));

    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);
      return body.map((e) => CurrencyRate.fromJson(e)).toList();
    } else {
      return null;
    }
  }
}
