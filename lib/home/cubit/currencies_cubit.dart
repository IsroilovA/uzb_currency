import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:uzb_currency/data/models/currency_rate.dart';
import 'package:uzb_currency/service/api_helper.dart';

part 'currencies_state.dart';

class CurrenciesCubit extends Cubit<CurrenciesState> {
  CurrenciesCubit() : super(CurrenciesInitial());

  List<CurrencyRate>? currencies;

  void fetchData(DateTime date) async {
    try {
      currencies = await ApiHelper.fetchCurrencies(date: date);
      if (currencies != null) {
        emit(CurrenciesDataFetched(currencies!));
      }
    } catch (e) {
      emit(CurrenciesError(e.toString()));
    }
  }

  void showPicker(
    ValueChanged<Currency> onCurrencySelected,
    BuildContext context,
  ) {
    showCurrencyPicker(
      currencyFilter: currencies == null
          ? null
          : List.generate(
              currencies!.length, (index) => currencies![index].currency),
      theme: CurrencyPickerThemeData(
        bottomSheetHeight: MediaQuery.of(context).size.height / 1.5,
        currencySignTextStyle: const TextStyle().copyWith(
          color: Theme.of(context).colorScheme.secondary,
        ),
        titleTextStyle: const TextStyle().copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        onCurrencySelected(currency);
      },
    );
  }
}
