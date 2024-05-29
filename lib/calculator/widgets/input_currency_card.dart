import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uzb_currency/home/cubit/rates_cubit.dart';
import 'package:uzb_currency/service/helper_functions.dart';

class InputCurrencyCard extends StatelessWidget {
  const InputCurrencyCard(
      {super.key,
      required this.onCurrencyChanged,
      required this.currency,
      required this.inputAmount});
  final ValueChanged<String> onCurrencyChanged;
  final String currency;
  final String inputAmount;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                BlocProvider.of<CurrenciesCubit>(context).showPicker(
                    (currency) {
                  onCurrencyChanged(currency.code);
                }, context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flag.fromString(
                    currency.substring(0, 2),
                    height: 55,
                    width: 55,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    currency,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              softWrap: true,
              inputAmount.isEmpty
                  ? currencyFormat(0.toString())
                  : currencyFormat(inputAmount),
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      ),
    );
  }
}
