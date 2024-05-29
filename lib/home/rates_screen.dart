import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uzb_currency/home/cubit/rates_cubit.dart';
import 'package:uzb_currency/home/widgets/rate_item.dart';
import 'package:uzb_currency/service/currencies_repository.dart';
import 'package:uzb_currency/service/locator.dart';

class RatesScreen extends StatefulWidget {
  const RatesScreen({super.key});

  @override
  State<RatesScreen> createState() {
    return _RatesScreenState();
  }
}

class _RatesScreenState extends State<RatesScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          TextField(
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
            onChanged: (value) {
              BlocProvider.of<RatesCubit>(context).onSearch(value);
            },
            decoration: InputDecoration(
              labelText: 'Search',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
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
          BlocProvider(
            create: (context) => RatesCubit(
                currenciesRepository: locator<CurrenciesRepository>()),
            child: BlocBuilder<RatesCubit, RatesState>(
              builder: (context, state) {
                // final pinnedCurrencies = context
                //     .select((RatesCubit cubit) => cubit.pinnedCurrencies);
                // BlocProvider.of<RatesCubit>(context).fetchPinnedCurrencies();
                // return Expanded(
                //   child: ListView.builder(
                //     physics: const NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount: pinnedCurrencies.length,
                //     itemBuilder: (context, index) {
                //       return CurrencyItem(
                //           currencyItem: pinnedCurrencies[index]!);
                //     },
                //   ),
                // );
                if (state is RatesInitial) {
                  BlocProvider.of<RatesCubit>(context).fetchPinnedCurrencies();
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is RatesPinnedFetched) {
                  return Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.currencies.length,
                      itemBuilder: (context, index) {
                        return CurrencyItem(
                            currencyItem: state.currencies[index]!);
                      },
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<RatesCubit, RatesState>(
            buildWhen: (previous, current) {
              if (current is RatesPinnedFetched || current is NoRatesPinned) {
                return false;
              }
              return true;
            },
            builder: (context, state) {
              if (state is RatesInitial) {
                BlocProvider.of<RatesCubit>(context).fetchData(DateTime.now());
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is RatesDataFetched) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.currencies.length,
                    itemBuilder: (context, index) {
                      return CurrencyItem(
                          currencyItem: state.currencies[index]!);
                    },
                  ),
                );
              } else if (state is RatesBadResponse) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      size: 80,
                    ),
                    Text(
                      'Bad request: status code: ${state.responseCode}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<RatesCubit>(context)
                              .fetchData(DateTime.now());
                        },
                        child: Text(
                          'Retry',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ))
                  ],
                );
              } else if (state is RatesError) {
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
