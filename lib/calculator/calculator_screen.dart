import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uzb_currency/calculator/widgets/calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() {
    return _CalculatorScreenState();
  }
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            4,
            (index) {
              while (index < 3) {
                index = index * 3;
                return Row(
                  children: [
                    CalculatorButton(
                        value: (1 + index).toString(), pressed: (value) {}),
                    CalculatorButton(
                        value: (2 + index).toString(), pressed: (value) {}),
                    CalculatorButton(
                        value: (3 + index).toString(), pressed: (value) {}),
                  ],
                );
              }
              return Row(
                children: [
                  CalculatorButton(value: '.', pressed: (value) {}),
                  CalculatorButton(value: 0.toString(), pressed: (value) {}),
                  CalculatorButton(value: "DELL", pressed: (value) {}),
                ],
              );
            },
          )
          // children: [
          //   Text(
          //     "data",
          //     style: Theme.of(context).textTheme.titleMedium!.copyWith(
          //           color: Theme.of(context).colorScheme.onBackground,
          //         ),
          //   ),

          //   // Expanded(
          //   //   child: GridView.builder(
          //   //     itemCount: 12,
          //   //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //   //       crossAxisCount: 3,
          //   //       childAspectRatio: 2.2,
          //   //     ),
          //   //     itemBuilder: (context, index) {
          //   //       if (index <= 8) {
          //   //         return CalculatorButton(
          //   //             value: (index + 1).toString(), pressed: (value) {});
          //   //       } else if (index == 9) {
          //   //         return CalculatorButton(value: ".", pressed: (value) {});
          //   //       } else if (index == 10) {
          //   //         return CalculatorButton(value: "0", pressed: (value) {});
          //   //       } else {
          //   //         return CalculatorButton(value: "DEL", pressed: (value) {});
          //   //       }
          //   //     },
          //   //   ),
          //   // ),
          // ],
          ),
    );
  }
}
