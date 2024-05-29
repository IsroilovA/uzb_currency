part of 'rates_cubit.dart';

@immutable
sealed class CurrenciesState {}

final class CurrenciesInitial extends CurrenciesState {}

final class CurrenciesDataFetched extends CurrenciesState {
  final List<CurrencyRate> currencies;
  CurrenciesDataFetched(this.currencies);
}

final class CurrenciesError extends CurrenciesState {
  final String message;
  CurrenciesError(this.message);
}

final class CurrenciesBadResponse extends CurrenciesState {
  final int responseCode;

  CurrenciesBadResponse(this.responseCode);
}
