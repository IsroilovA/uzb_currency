import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uzb_currency/data/models/currency_rate.dart';
import 'package:uzb_currency/service/helper_functions.dart';

//class to fetch curencies from remote API
class ApiHelper {
  //fetch data fucntion
  static Future<Map<String, dynamic>> fetchCurrencies(
      {required DateTime date, String? currency}) async {
    //fromat date to insert into the link
    final insertedDate = dateFormatter.format(date);
    //variable to hold the response
    final http.Response response;
    //ckeck if currency was passed and insert if needed
    if (currency != null) {
      response = await http.get(Uri.parse(
          "https://cbu.uz/ru/arkhiv-kursov-valyut/json/$currency/$insertedDate/"));
    } else {
      response = await http.get(Uri.parse(
          "https://cbu.uz/ru/arkhiv-kursov-valyut/json/all/$insertedDate/"));
    }
    //check for status code
    if (response.statusCode == 200) {
      //decode the body received
      final List body = jsonDecode(response.body);
      //convert to the list of CurrencyRate and return
      return {
        'currencies': body.map((e) => CurrencyRate.fromJson(e)).toList(),
        'statusCode': response.statusCode
      };
    } else {
      return {'currencies': null, 'statusCode': response.statusCode};
    }
  }
}
