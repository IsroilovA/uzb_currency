import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uzb_currency/data/models/currency_rate.dart';
import 'package:uzb_currency/service/currencies_repository.dart';

part 'pinned_state.dart';

class PinnedCubit extends Cubit<PinnedState> {
  PinnedCubit({required CurrenciesRepository currenciesRepository})
      : _currenciesRepository = currenciesRepository,
        super(PinnedInitial());

  final CurrenciesRepository _currenciesRepository;

  void pinUnpinCurrency(CurrencyRate currencyRate) async {
    try {
      await _currenciesRepository.pinUnpinCurrency(currencyRate);
      emit(PinnedInitial());
    } catch (e) {
      emit(PinnedError(e.toString()));
    }
  }

  bool isPinned(CurrencyRate currencyRate) {
    return _currenciesRepository.isCurrencyPinned(currencyRate);
  }

  Future<void> fetchPinnedCurrencies() async {
    try {
      emit(PinnedInitial());
      final pinnedCurrencies =
          await _currenciesRepository.fetchPinnedCurrencies();
      if (pinnedCurrencies.isNotEmpty) {
        emit(PinnedRatesFetched(pinnedCurrencies));
      } else {
        emit(PinnedNoRates());
      }
    } catch (e) {
      emit(PinnedError(e.toString()));
    }
  }
}
