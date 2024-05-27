import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton(
      {super.key, required this.value, required this.onPress, this.onHolded});

  final dynamic value;
  final ValueChanged<dynamic> onPress;
  final ValueChanged<dynamic>? onHolded;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return TextButton(
      style: OutlinedButton.styleFrom(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          minimumSize: Size(
              (screenSize.width / 3) - 8,
              (screenSize.height -
                      kBottomNavigationBarHeight -
                      Scaffold.of(context).appBarMaxHeight!) /
                  10)),
      onPressed: () {
        onPress(value);
      },
      onLongPress: () {
        onHolded == null ? null : onHolded!(dynamic);
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
