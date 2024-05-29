part of 'rates_cubit.dart';

@immutable
sealed class RatesState {}

final class RatesInitial extends RatesState {}

final class RatesDataFetched extends RatesState {
  final List<CurrencyRate?> currencies;
  RatesDataFetched(this.currencies);
}

final class RatesError extends RatesState {
  final String message;
  RatesError(this.message);
}

final class RatesBadResponse extends RatesState {
  final int responseCode;

  RatesBadResponse(this.responseCode);
}
