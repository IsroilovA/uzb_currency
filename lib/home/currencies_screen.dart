import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uzb_currency/home/cubit/currencies_cubit.dart';
import 'package:uzb_currency/home/widgets/currency_item.dart';

class CurrenciesScreen extends StatefulWidget {
  const CurrenciesScreen({super.key});

  @override
  State<CurrenciesScreen> createState() {
    return _CurrenciesScreenState();
  }
}

class _CurrenciesScreenState extends State<CurrenciesScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.onBackground))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Currency",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                Text(
                  "Rate",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                Text(
                  "Diff",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<CurrenciesCubit, CurrenciesState>(
            builder: (context, state) {
              if (state is CurrenciesInitial) {
                BlocProvider.of<CurrenciesCubit>(context)
                    .fetchData(DateTime.now());
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is CurrenciesDataFetched) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.currencies.length,
                    itemBuilder: (context, index) {
                      return CurrencyItem(
                          currencyItem: state.currencies[index]);
                    },
                  ),
                );
              } else if (state is CurrenciesBadResponse) {
                return Column(
                  children: [
                    const Icon(Icons.wifi_tethering_error),
                    Text(
                      'Bad request: status code: ${state.responseCode}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<CurrenciesCubit>(context)
                              .fetchData(DateTime.now());
                        },
                        child: const Text('Retry'))
                  ],
                );
              } else if (state is CurrenciesError) {
                return Expanded(
                  child: ListView(
                    children: [
                      Text(
                        state.message,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ],
                  ),
                );
              } else {
                return Expanded(
                  child: ListView(
                    children: [
                      Text(
                        "Something went wrong",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
