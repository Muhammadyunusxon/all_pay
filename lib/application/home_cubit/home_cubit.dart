import 'package:all_pay/infrastructure/models/card_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../infrastructure/models/user_model.dart';
import '../../infrastructure/services/local_storage.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  getUserInfo() async {
    var id = await LocalStore.getDocId();
    var res = await firestore.collection("users").doc(id).get();
    emit(state.copyWith(user: UserModel.fromJson(res.data())));
  }

  getCardInfo() async {
    var res = await firestore
        .collection("cards")
        .where("ownerId", isEqualTo: await LocalStore.getDocId())
        .get();
    List<CardModel> cards = [];
    for (var element in res.docs) {
      cards.add(CardModel.fromJson(json: element.data(), docId: element.id));
    }
    emit(state.copyWith(cards: cards));
    print(state.cards?.length);
  }

  addCard(CardModel card) async {
    state.cards?.add(card);

    emit(state.copyWith(cards: state.cards));
  }

  updateCard(CardModel card) async {
    for (int i = 0; i < (state.cards?.length ?? 0); i++) {
      if (state.cards?[i].docId == card.docId) {
        state.cards?[i] = card;
      }
    }

    emit(state.copyWith(cards: state.cards));
  }

  removeCard({required String docId, required int index}) async {
    await firestore.collection("cards").doc(docId).delete();
    state.cards?.removeAt(index);
    emit(state.copyWith(cards: state.cards));
  }
}
