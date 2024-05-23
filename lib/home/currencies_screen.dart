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
      child: BlocProvider(
        create: (context) => CurrenciesCubit(),
        child: BlocBuilder<CurrenciesCubit, CurrenciesState>(
          builder: (context, state) {
            if (state is CurrenciesInitial) {
              BlocProvider.of<CurrenciesCubit>(context)
                  .fetchData(DateTime.now());
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is CurrenciesDataFetched) {
              return ListView.builder(
                itemCount: state.currencies.length,
                itemBuilder: (context, index) {
                  return CurrencyItem(currencyItem: state.currencies[index]);
                },
              );
            }
            return Text("letsgo");
          },
        ),
      ),
    );
  }
}
