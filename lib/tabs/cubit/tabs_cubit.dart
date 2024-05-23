import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tabs_state.dart';

class TabsCubit extends Cubit<TabsState> {
  TabsCubit() : super(TabsInitial());

  int pageIndex = 0;

  void selectPage(int index) async {
    pageIndex = index;
    emit(TabsPageChanged(index));
  }
}
