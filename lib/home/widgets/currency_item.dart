import 'package:flutter/material.dart';
import 'package:uzb_currency/data/models/currency_rate.dart';
import 'package:uzb_currency/service/helper_functions.dart';

class CurrencyItem extends StatelessWidget {
  const CurrencyItem({super.key, required this.currencyItem});
  final CurrencyRate currencyItem;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(currencyItem.currency),
      title: Text(currencyFormatter.format(currencyItem.rate)),
      trailing: Text(currencyFormatter.format(currencyItem.difference)),
    );
  }
}
