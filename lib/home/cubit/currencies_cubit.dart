import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uzb_currency/data/models/currency_rate.dart';
import 'package:uzb_currency/service/api_helper.dart';

part 'currencies_state.dart';

class CurrenciesCubit extends Cubit<CurrenciesState> {
  CurrenciesCubit() : super(CurrenciesInitial());

  void fetchData(DateTime date) async {
    try {
      final currencies = await ApiHelper.fetchCurrencies(date: date);
      if (currencies != null) {
        emit(CurrenciesDataFetched(currencies));
      }
    } catch (e) {
      emit(CurrenciesError(e.toString()));
    }
  }
}
