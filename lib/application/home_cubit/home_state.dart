part of 'home_cubit.dart';

class HomeState {
  UserModel? user;
  List<CardModel>? cards = [];
  bool isLoading;
  num allMoney;
  int changeCardIndex;

  HomeState({this.user, this.isLoading = false, this.cards, this.allMoney = 0,this.changeCardIndex=0});

  HomeState copyWith(
      {UserModel? user,
      bool? isLoading,
      List<CardModel>? cards,
      num? allMoney,
      int? changeCardIndex
      }) {
    return HomeState(
        user: user ?? this.user,
        isLoading: isLoading ?? this.isLoading,
        cards: cards ?? this.cards,
        allMoney: allMoney ?? this.allMoney,
      changeCardIndex: changeCardIndex ?? this.changeCardIndex,

    );
  }
}
