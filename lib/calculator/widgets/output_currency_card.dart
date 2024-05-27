import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uzb_currency/home/cubit/currencies_cubit.dart';
import 'package:uzb_currency/service/helper_functions.dart';

class OutputCurrencyCard extends StatelessWidget {
  const OutputCurrencyCard(
      {super.key,
      required this.onCurrencyChanged,
      required this.currencyConvertedFrom,
      required this.inputAmount,
      required this.currencyConvertedTo});
  final ValueChanged<String> onCurrencyChanged;
  final String currencyConvertedFrom;
  final String currencyConvertedTo;
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
                  CircleFlag(currencyConvertedTo.substring(0, 2)),
                  const SizedBox(width: 8),
                  Text(
                    currencyConvertedTo,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            BlocBuilder<CurrenciesCubit, CurrenciesState>(
              buildWhen: (previous, current) {
                if (current is CurrenciesDataFetched) {
                  return true;
                } else {
                  return false;
                }
              },
              builder: (context, state) {
                if (state is CurrenciesDataFetched) {
                  double rateCurrencyConvertedFrom = 0;
                  double rateCurrencyConvertedTo = 0;
                  double convertedAmount = 0;
                  if (currencyConvertedFrom == 'UZS') {
                    rateCurrencyConvertedFrom = 1;
                  } else {
                    rateCurrencyConvertedFrom = state.currencies
                        .firstWhere((element) =>
                            element.currency == currencyConvertedFrom)
                        .rate;
                  }
                  if (currencyConvertedTo == 'UZS') {
                    rateCurrencyConvertedTo = 1;
                  } else {
                    rateCurrencyConvertedTo = state.currencies
                        .firstWhere((element) =>
                            element.currency == currencyConvertedTo)
                        .rate;
                  }
                  if (inputAmount.isNotEmpty) {
                    convertedAmount = double.parse(inputAmount) *
                        rateCurrencyConvertedFrom /
                        rateCurrencyConvertedTo;
                  } else {
                    convertedAmount = 0;
                  }
                  return Text(
                    softWrap: true,
                    currencyFormat(convertedAmount.toString()),
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
