import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final ScrollController _homeScrollController = ScrollController();
  double scrollPosition = 0.0;

  @override
  void dispose() {
    _homeScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _homeScrollController.addListener(() {
      setState(() {
        scrollPosition = _homeScrollController.offset;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: RefreshIndicator.adaptive(
        onRefresh: () {
          BlocProvider.of<RatesCubit>(context).fetchData(DateTime.now());
          return BlocProvider.of<PinnedCubit>(context).fetchPinnedCurrencies();
        },
        child: Column(
          children: [
            Platform.isIOS
                ? CupertinoSearchTextField(
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                    onChanged: (value) {
                      BlocProvider.of<RatesCubit>(context).onSearch(value);
                    },
                  )
                : SearchBar(
                    hintText: "Search",
                    leading: const Icon(Icons.search),
                    onChanged: (value) {
                      BlocProvider.of<RatesCubit>(context).onSearch(value);
                    },
                  ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.onSurface))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Currency",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  Text(
                    "Rate",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  Text(
                    "Diff",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: _homeScrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<RatesCubit, RatesState>(
                          builder: (context, state) {
                            //fetch pinned currency only after the info was updated
                            if (state is RatesDataFetched) {
                              return BlocBuilder<PinnedCubit, PinnedState>(
                                builder: (context, state) {
                                  if (state is PinnedInitial) {
                                    BlocProvider.of<PinnedCubit>(context)
                                        .fetchPinnedCurrencies();
                                    return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                                  } else if (state is PinnedRatesFetched) {
                                    return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.pinnedCurrencies.length,
                                      itemBuilder: (context, index) {
                                        return CurrencyItem(
                                          currencyItem:
                                              state.pinnedCurrencies[index]!,
                                          isPinned: true,
                                        );
                                      },
                                    );
                                  } else if (state is PinnedError) {
                                    return Text(
                                      state.message,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        const SizedBox(height: 10),
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
                                              .onSurface,
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              );
                            } else {
                              return Text(
                                "Something went wrong",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 5,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: scrollPosition <= 100
                          ? null
                          : FloatingActionButton(
                              onPressed: () {
                                _homeScrollController.animateTo(
                                  0.0,
                                  curve: Curves.easeOut,
                                  duration: const Duration(milliseconds: 300),
                                );
                              },
                              child: const Icon(Icons.arrow_upward),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
