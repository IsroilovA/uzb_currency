import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uzb_currency/data/models/currency_rate.dart';
import 'package:uzb_currency/service/api_helper.dart';

part 'currencies_state.dart';

class CurrenciesCubit extends Cubit<CurrenciesState> {
  CurrenciesCubit() : super(CurrenciesInitial());

  void fetchData() async {
    final currencies = await ApiHelper.fetchCurrencies();
    print(currencies!.first.currency);
  }
}
