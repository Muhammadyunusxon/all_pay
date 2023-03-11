part of 'app_cubit.dart';

 class AppState {
  int page;
  AppState({this.page = 1});

  AppState copyWith({int? page}){
   return AppState(page: page ?? this.page);
  }
 }

