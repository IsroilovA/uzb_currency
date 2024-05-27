import 'package:flutter/material.dart';
import 'package:uzb_currency/calculator/widgets/calculator_button.dart';
import 'package:uzb_currency/calculator/widgets/input_currency_card.dart';
import 'package:uzb_currency/calculator/widgets/output_currency_card.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() {
    return _CalculatorScreenState();
  }
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  //variable to hold the value user entered
  String inputAmount = '';
  //variable to hold currency from which convert
  String curencyConvertedFrom = 'USD';
  //variable to hold currency to which convert
  String curencyConvertedTo = 'UZS';
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
                    InputCurrencyCard(
                      onCurrencyChanged: (currency) {
                        setState(() {
                          curencyConvertedFrom = currency;
                        });
                      },
                      currency: curencyConvertedFrom,
                      inputAmount: inputAmount,
                    ),
                    IconButton(
                      onPressed: () {
                        final temp = curencyConvertedFrom;
                        setState(() {
                          curencyConvertedFrom = curencyConvertedTo;
                          curencyConvertedTo = temp;
                        });
                      },
                      icon: const Icon(
                        Icons.swap_vert,
                        size: 50,
                      ),
                    ),
                    OutputCurrencyCard(
                      onCurrencyChanged: (currency) {
                        setState(() {
                          curencyConvertedTo = currency;
                        });
                      },
                      currencyConvertedFrom: curencyConvertedFrom,
                      inputAmount: inputAmount,
                      currencyConvertedTo: curencyConvertedTo,
                    ),
                  ],
                ),
              ),
            ),
            ...customKeyboard()
          ]),
    );
  }

  //function to build keyboard
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
