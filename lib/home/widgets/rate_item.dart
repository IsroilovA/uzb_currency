import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uzb_currency/data/models/currency_rate.dart';
import 'package:uzb_currency/home/cubit/rates_cubit.dart';
import 'package:uzb_currency/service/helper_functions.dart';

class CurrencyItem extends StatelessWidget {
  const CurrencyItem({super.key, required this.currencyItem});
  final CurrencyRate currencyItem;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Dismissible(
          key: ValueKey(currencyItem.id),
          direction: DismissDirection.startToEnd,
          confirmDismiss: (direction) async {
            BlocProvider.of<CurrenciesCubit>(context)
                .pinUnpinCurrency(currencyItem);
            return false;
          },
          background: Material(
            color: Colors.blue,
            child: Icon(
              Icons.push_pin,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Flag.fromString(
                    currencyItem.currency.substring(0, 2),
                    height: 55,
                    width: 55,
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
                currencyFormat(currencyItem.rate.toString()),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              Text(
                currencyFormat(currencyItem.difference.toString()),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: currencyItem.difference < 0
                          ? Colors.red
                          : Colors.green,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
