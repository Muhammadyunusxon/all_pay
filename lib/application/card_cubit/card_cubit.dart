import 'package:all_pay/infrastructure/models/card_model.dart';
import 'package:all_pay/infrastructure/services/local_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardState());

  changeCard(CardModel? card) {
    emit(state.copyWith(card: card));
  }

  changeNumber(String number) {
    emit(state.copyWith(number: number));
  }

  changeDate(String expireDate) {
    emit(state.copyWith(expireDate: expireDate));
  }

  changeOwner(String owner) {
    emit(state.copyWith(owner: owner));
  }

  changeName(String cardName) {
    emit(state.copyWith(cardName: cardName));
  }

  changeGradient(int index) {
    emit(state.copyWith(indexGradient: index, indexImage: -1));
  }

  changeImage(int index) {
    emit(state.copyWith(indexGradient: -1, indexImage: index));
  }

  createCard({required ValueChanged<CardModel> onSuccess, required bool isUpdate}) async {
    emit(state.copyWith(isLoading: true));
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    if (isUpdate) {
      await firestore
          .collection("cards")
          .doc(state.card?.docId ?? "")
          .update(state.card!.toJson());
    } else {
      emit(state.copyWith(
          ownerId: await LocalStore.getDocId(), moneyAmount: 500));
     var res= await firestore.collection("cards").add(state.card!.toJson());
     emit(state.copyWith(docId: res.id));
    }
    onSuccess(state.card!);
    emit(state.copyWith(isLoading: false));
  }
}
