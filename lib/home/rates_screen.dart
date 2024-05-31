import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uzb_currency/home/cubit/pinned_cubit.dart';
import 'package:uzb_currency/home/cubit/rates_cubit.dart';
import 'package:uzb_currency/home/widgets/rate_item.dart';

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
          CupertinoSearchTextField(
            // style: Theme.of(context).textTheme.titleMedium!.copyWith(
            //       color: Theme.of(context).colorScheme.onBackground,
            //     ),
            onChanged: (value) {
              BlocProvider.of<RatesCubit>(context).onSearch(value);
            },
            // decoration: InputDecoration(
            //   labelText: 'Search',
            //   border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(50)),
            //   prefixIcon: const Icon(Icons.search),
            // ),
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<PinnedCubit, PinnedState>(
                    builder: (context, state) {
                      if (state is PinnedInitial) {
                        BlocProvider.of<PinnedCubit>(context)
                            .fetchPinnedCurrencies();
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (state is PinnedRatesFetched) {
                        return Column(
                          children: [
                            Text(
                              "Pinned:",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Card(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.pinnedCurrencies.length,
                                  itemBuilder: (context, index) {
                                    return CurrencyItem(
                                        currencyItem:
                                            state.pinnedCurrencies[index]!);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      } else if (state is PinnedError) {
                        return Text(
                          state.message,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BlocBuilder<RatesCubit, RatesState>(
                    builder: (context, state) {
                      if (state is RatesInitial) {
                        BlocProvider.of<RatesCubit>(context)
                            .fetchData(DateTime.now());
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (state is RatesDataFetched) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.currencies.length,
                          itemBuilder: (context, index) {
                            return CurrencyItem(
                                currencyItem: state.currencies[index]!);
                          },
                        );
                      } else if (state is RatesBadResponse) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ))
                          ],
                        );
                      } else if (state is RatesError) {
                        return Text(
                          state.message,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        );
                      } else {
                        return Text(
                          "Something went wrong",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
