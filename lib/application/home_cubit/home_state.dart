part of 'home_cubit.dart';

class HomeState {
  UserModel? user;
  List<CardModel>? cards = [];
  List<UserModel>? users = [];
  bool isLoading;
  num allMoney;
  int changeCardIndex;
  int changeUserIndex;
  bool sendLoading;
  String senderName;

  HomeState({
    this.user,
    this.isLoading = false,
    this.cards,
    this.allMoney = 0,
    this.changeCardIndex = 0,
    this.users,
    this.sendLoading = false,
    this.senderName = '',
    this.changeUserIndex = -1,
  });

  HomeState copyWith({
    UserModel? user,
    bool? isLoading,
    List<CardModel>? cards,
    List<UserModel>? users,
    num? allMoney,
    int? changeCardIndex,
    bool? sendLoading,
    String? senderName,
    int? changeUserIndex,
  }) {
    return HomeState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      cards: cards ?? this.cards,
      allMoney: allMoney ?? this.allMoney,
      changeCardIndex: changeCardIndex ?? this.changeCardIndex,
      users: users ?? this.users,
      sendLoading: sendLoading ?? this.sendLoading,
      senderName: senderName ?? this.senderName,
      changeUserIndex: changeUserIndex ?? this.changeUserIndex,
    );
  }
}
