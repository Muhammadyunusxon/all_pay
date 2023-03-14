import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../infrastructure/services/local_storage.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState());

  getTheme() async =>
      emit(state.copyWith(isChangeTheme: await LocalStore.getTheme()));


  Future<void> change() async {
    emit(state.copyWith(isChangeTheme: !state.isChangeTheme));
    LocalStore.setTheme(state.isChangeTheme);

  }

  changePageIndex({required VoidCallback onPushed}) {
    state.page != 3 ? emit(state.copyWith(page: state.page + 1)) : onPushed();
  }

  changePage(int select) {
    emit(state.copyWith(selected: select));
  }

}
