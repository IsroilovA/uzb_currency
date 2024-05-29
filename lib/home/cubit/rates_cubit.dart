import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:uzb_currency/data/models/currency_rate.dart';
import 'package:uzb_currency/service/currencies_repository.dart';

part 'rates_state.dart';

class RatesCubit extends Cubit<RatesState> {
  RatesCubit({required CurrenciesRepository currenciesRepository})
      : _currenciesRepository = currenciesRepository,
        super(RatesInitial());

  final CurrenciesRepository _currenciesRepository;
  List<CurrencyRate?> currencies = [];
  List<CurrencyRate?> pinnedCurrencies = [];

  void onSearch(String query) {
    if (currencies.isEmpty) {
      return;
    }
    final searchedCurrencies = currencies
        .where(
          (element) =>
              element!.currencyName
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              element.currency.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    emit(RatesDataFetched(searchedCurrencies));
  }

  void pinUnpinCurrency(CurrencyRate currencyRate) async {
    try {
      await _currenciesRepository.pinUnpinCurrency(currencyRate);
      await fetchPinnedCurrencies();
    } catch (e) {
      emit(RatesError(e.toString()));
    }
  }

  Future<void> fetchPinnedCurrencies() async {
    try {
      pinnedCurrencies = await _currenciesRepository.fetchPinnedCurrencies();
      if (pinnedCurrencies.isNotEmpty) {
        emit(RatesPinnedFetched(pinnedCurrencies));
      } else {
        emit(NoRatesPinned());
      }
    } catch (e) {
      emit(RatesError(e.toString()));
    }
  }

  Future<void> fetchData(DateTime date) async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        final serverResponse =
            await _currenciesRepository.getCurrencies(date: DateTime.now());
        await _currenciesRepository.saveCurrenciesLocally(serverResponse);
        currencies = await _currenciesRepository.fetchAllLocalCurrencies();
        // currencies.sort(
        //   (a, b) {
        //     if (_currenciesRepository.isCurrencyPinned(a!) &&
        //         _currenciesRepository.isCurrencyPinned(b!)) {
        //       return 0;
        //     } else if (_currenciesRepository.isCurrencyPinned(a) &&
        //         !_currenciesRepository.isCurrencyPinned(b!)) {
        //       return -1;
        //     } else {
        //       return 1;
        //     }
        //   },
        // );
        emit(RatesDataFetched(currencies));
      } else {
        currencies = await _currenciesRepository.fetchAllLocalCurrencies();
        pinnedCurrencies = currencies
            .where(
                (element) => _currenciesRepository.isCurrencyPinned(element!))
            .toList();
        emit(RatesDataFetched(currencies));
      }
    } catch (e) {
      emit(RatesError(e.toString()));
    }
  }

  void showPicker(
    ValueChanged<Currency> onCurrencySelected,
    BuildContext context,
  ) {
    showCurrencyPicker(
      favorite: ['UZS', 'USD', 'EUR', 'RUB'],
      currencyFilter: List.generate(
          currencies.length + 1,
          (index) =>
              index == currencies.length ? 'UZS' : currencies[index]!.currency),
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
