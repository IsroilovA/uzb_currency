import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:uzb_currency/data/models/currency_rate.dart';
import 'package:uzb_currency/service/helper_functions.dart';

class CurrencyItem extends StatelessWidget {
  const CurrencyItem({super.key, required this.currencyItem});
  final CurrencyRate currencyItem;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CircleFlag(
                  currencyItem.currency.substring(0, 2).toLowerCase(),
                  size: 55,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  currencyItem.currency,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ],
            ),
            Text(
              currencyFormatter.format(currencyItem.rate),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            Text(
              currencyFormatter.format(currencyItem.difference),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color:
                        currencyItem.difference < 0 ? Colors.red : Colors.green,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
