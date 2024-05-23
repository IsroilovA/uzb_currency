part of 'tabs_cubit.dart';

@immutable
sealed class TabsState {}

final class TabsInitial extends TabsState {}

final class TabsError extends TabsState {
  final String message;

  TabsError(this.message);
}

final class TabsPageChanged extends TabsState {
  final int pageIndex;
  TabsPageChanged(this.pageIndex);
}