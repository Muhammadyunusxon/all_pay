import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState());

  changePageIndex() {
    emit(state.copyWith(page: state.page + 1));
  }
}
