import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton(
      {super.key, required this.value, required this.pressed});

  final dynamic value;
  final ValueChanged<dynamic> pressed;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return TextButton(
      style: OutlinedButton.styleFrom(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          minimumSize: Size((screenSize.width / 3) - 8, screenSize.width / 5)),
      onPressed: () {
        pressed(value);
      },
      child: value is String
          ? Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          : Icon(value),
    );
  }
}
