part of 'pinned_cubit.dart';

sealed class PinnedState extends Equatable {
  const PinnedState();

  @override
  List<Object> get props => [];
}

final class PinnedInitial extends PinnedState {}

final class PinnedRatesFetched extends PinnedState {
  final List<CurrencyRate?> pinnedCurrencies;
  const PinnedRatesFetched(this.pinnedCurrencies);
}

final class PinnedNoRates extends PinnedState {}

final class PinnedError extends PinnedState{
  final String message;
  const PinnedError(this.message);
}
