part of 'home_cubit.dart';

class HomeState {
  UserModel? user;
  List<CardModel>? cards=[];
  bool isLoading;

  HomeState({this.user, this.isLoading = false, this.cards});

  HomeState copyWith(
      {UserModel? user, bool? isLoading, List<CardModel>? cards}) {
    return HomeState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      cards: cards ?? this.cards,
    );
  }
}
