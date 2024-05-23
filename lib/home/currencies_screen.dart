import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uzb_currency/home/cubit/currencies_cubit.dart';

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
      child: BlocProvider(
        create: (context) => CurrenciesCubit(),
        child: BlocBuilder<CurrenciesCubit, CurrenciesState>(
          builder: (context, state) {
            BlocProvider.of<CurrenciesCubit>(context).fetchData();
            return Text("letsgo");
          },
        ),
      ),
    );
  }
}
