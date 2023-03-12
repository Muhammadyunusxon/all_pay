part of 'app_cubit.dart';

class AppState {
  int page;
  bool isChangeTheme;

  AppState({this.page = 1, this.isChangeTheme = false});

  AppState copyWith({int? page, bool? isChangeTheme}) {
    return AppState(
        page: page ?? this.page,
        isChangeTheme: isChangeTheme ?? this.isChangeTheme);
  }
}
