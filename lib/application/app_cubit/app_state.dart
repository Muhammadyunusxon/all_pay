part of 'app_cubit.dart';

class AppState {
  int page;
  bool isChangeTheme;
  int selected;

  AppState({this.page = 1, this.isChangeTheme = false,this.selected=0});

  AppState copyWith({int? page, bool? isChangeTheme,int? selected}) {
    return AppState(
        page: page ?? this.page,
        isChangeTheme: isChangeTheme ?? this.isChangeTheme,selected: selected ?? this.selected);
  }
}
