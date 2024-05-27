import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uzb_currency/calculator/widgets/calculator_button.dart';
import 'package:uzb_currency/home/cubit/currencies_cubit.dart';
import 'package:uzb_currency/service/helper_functions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() {
    return _CalculatorScreenState();
  }
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String inputAmount = '';
  String convertedAmount = '0';
  String selectedCurency1 = 'USD';
  String selectedCurency2 = 'UZS';
  double selectedCurrencyRate1 = 0.0;
  double selectedCurrencyRate2 = 0.0;
  bool isReversed = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.3,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                BlocProvider.of<CurrenciesCubit>(context)
                                    .showPicker((currency) {
                                  setState(() {
                                    selectedCurency1 = currency.code;
                                  });
                                }, context);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleFlag(selectedCurency1.substring(0, 2)),
                                  const SizedBox(width: 8),
                                  Text(
                                    selectedCurency1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
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
                                  if (selectedCurency1 == 'UZS') {
                                    selectedCurrencyRate1 = 1;
                                  } else {
                                    selectedCurrencyRate1 = state.currencies
                                        .firstWhere((element) =>
                                            element.currency ==
                                            selectedCurency1)
                                        .rate;
                                  }
                                  return Text(
                                    softWrap: true,
                                    insertCommas(inputAmount),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                  );
                                } else {
                                  return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.swap_vert,
                        size: 50,
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                BlocProvider.of<CurrenciesCubit>(context)
                                    .showPicker((currency) {
                                  setState(() {
                                    selectedCurency2 = currency.code;
                                  });
                                }, context);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleFlag(selectedCurency2.substring(0, 2)),
                                  const SizedBox(width: 8),
                                  Text(
                                    selectedCurency2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
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
                                  if (selectedCurency2 == 'UZS') {
                                    selectedCurrencyRate2 = 1;
                                  } else {
                                    selectedCurrencyRate2 = state.currencies
                                        .firstWhere((element) =>
                                            element.currency ==
                                            selectedCurency2)
                                        .rate;
                                  }
                                  if (inputAmount.isNotEmpty) {
                                    convertedAmount =
                                        (double.parse(inputAmount) *
                                                selectedCurrencyRate1 /
                                                selectedCurrencyRate2)
                                            .toStringAsFixed(2);
                                  } else {
                                    convertedAmount = '0.0';
                                  }
                                  return Text(
                                    softWrap: true,
                                    insertCommas(convertedAmount),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                  );
                                } else {
                                  return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ...customKeyboard()
          ]),
    );
  }

  List<Widget> customKeyboard() {
    return List.generate(
      4,
      (index) {
        while (index < 3) {
          index = index * 3;
          return Row(
            children: [
              CalculatorButton(
                  value: (1 + index).toString(),
                  onPress: (value) {
                    setState(() {
                      inputAmount = inputAmount + value;
                    });
                  }),
              CalculatorButton(
                  value: (2 + index).toString(),
                  onPress: (value) {
                    setState(() {
                      inputAmount = inputAmount + value;
                    });
                  }),
              CalculatorButton(
                  value: (3 + index).toString(),
                  onPress: (value) {
                    setState(() {
                      inputAmount = inputAmount + value;
                    });
                  }),
            ],
          );
        }
        return Row(
          children: [
            CalculatorButton(
                value: '.',
                onPress: (value) {
                  setState(() {
                    if (inputAmount == '') {
                      inputAmount = "${inputAmount}0$value";
                    } else {
                      inputAmount = inputAmount + value;
                    }
                  });
                }),
            CalculatorButton(
                value: 0.toString(),
                onPress: (value) {
                  setState(() {
                    inputAmount = inputAmount + value;
                  });
                }),
            CalculatorButton(
              value: Icons.backspace_outlined,
              onPress: (value) {
                setState(() {
                  if (inputAmount.isNotEmpty) {
                    inputAmount =
                        inputAmount.substring(0, inputAmount.length - 1);
                  }
                });
              },
              onHolded: (value) {
                setState(() {
                  inputAmount = '';
                });
              },
            ),
          ],
        );
      },
    );
  }
}
