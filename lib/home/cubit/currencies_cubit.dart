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
      currencies = (await ApiHelper.fetchCurrencies(date: date))['currencies'];
      final responseCode =
          (await ApiHelper.fetchCurrencies(date: date))['statusCode'];
      if (currencies != null) {
        emit(CurrenciesDataFetched(currencies!));
      } else {
        emit(CurrenciesBadResponse(responseCode));
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
      favorite: ['UZS', 'USD', 'EUR', 'RUB'],
      currencyFilter: currencies == null
          ? null
          : List.generate(
              currencies!.length + 1,
              (index) => index == currencies!.length
                  ? 'UZS'
                  : currencies![index].currency),
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
