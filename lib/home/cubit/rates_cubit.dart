import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:uzb_currency/data/models/currency_rate.dart';
import 'package:uzb_currency/service/currencies_repository.dart';

part 'rates_state.dart';

class CurrenciesCubit extends Cubit<CurrenciesState> {
  CurrenciesCubit({required CurrenciesRepository currenciesRepository})
      : _currenciesRepository = currenciesRepository,
        super(CurrenciesInitial());

  final CurrenciesRepository _currenciesRepository;
  List<CurrencyRate?> currencies = [];

  Future<void> fetchData(DateTime date) async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        final serverResponse =
            await _currenciesRepository.getCurrencies(date: DateTime.now());
        await _currenciesRepository.saveCurrenciesLocally(serverResponse);
        currencies = await _currenciesRepository.fetchAllLocalCurrencies();
        emit(CurrenciesDataFetched(currencies));
      } else {
        currencies = await _currenciesRepository.fetchAllLocalCurrencies();
        emit(CurrenciesDataFetched(currencies));
      }
      // currencies = (await ApiHelper.fetchCurrencies(date: date))['currencies'];
      // final responseCode =
      //     (await ApiHelper.fetchCurrencies(date: date))['statusCode'];
      // if (currencies != null && currencies!.isNotEmpty) {
      //   emit(CurrenciesDataFetched(currencies!));
      // } else {
      //   emit(CurrenciesBadResponse(responseCode));
      // }
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
              (index) => index == currencies.length
                  ? 'UZS'
                  : currencies[index]!.currency),
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
