import 'dart:convert';

import 'package:all_pay/infrastructure/models/card_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../infrastructure/models/user_model.dart';
import '../../infrastructure/services/local_storage.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  getUserInfo() async {
    var id = await LocalStore.getDocId();
    var res = await firestore.collection("users").doc(id).get();
    emit(state.copyWith(
        user: UserModel.fromJson(data: res.data(), docId: res.id)));
  }

  getUsers() async {
    var res = await firestore.collection("users").get();
    List<UserModel> users = [];
    var id = await LocalStore.getDocId();
    for (var element in res.docs) {
      if (element.id != id) {
        users.add(UserModel.fromJson(data: element.data(), docId: element.id));
      }
    }
    emit(state.copyWith(users: users));
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

    for (int i = 0; i < cards.length; i++) {
      if (cards[i].isMain ?? false) {
        emit(state.copyWith(changeCardIndex: i));
      }
    }
    emit(state.copyWith(cards: cards));
    getAllMoney();
  }

  getAllMoney() {
    num amount = 0;
    for (int i = 0; i < (state.cards?.length ?? 0); i++) {
      amount = amount + (state.cards?[i].moneyAmount ?? 0);
    }
    emit(state.copyWith(allMoney: amount));
  }

  setFavourite({required int index, required VoidCallback onSave}) async {
    state.cards?.forEach((element) async {
      if (element.isMain == true) {
        element.isMain = false;
        await firestore
            .collection("cards")
            .doc(element.docId)
            .update(element.toJson());
      }
    });
    state.cards?[index].isMain = true;
    await firestore
        .collection("cards")
        .doc(state.cards?[index].docId)
        .update(state.cards![index].toJson());
    emit(state.copyWith(cards: state.cards, changeCardIndex: index));
    onSave();
  }

  addCard(CardModel card) async {
    state.cards?.add(card);
    emit(state.copyWith(
        cards: state.cards,
        allMoney: state.allMoney + (card.moneyAmount ?? 0)));
  }

  updateCard(CardModel card) async {
    for (int i = 0; i < (state.cards?.length ?? 0); i++) {
      if (state.cards?[i].docId == card.docId) {
        state.cards?[i] = card;
        await firestore
            .collection("cards")
            .doc(card.docId)
            .update(card.toJson());
      }
    }

    emit(state.copyWith(cards: state.cards));
  }

  removeCard({required String docId, required int index}) async {
    emit(state.copyWith(
        allMoney: state.allMoney + (state.cards?[index].moneyAmount ?? 0)));
    await firestore.collection("cards").doc(docId).delete();
    state.cards?.removeAt(index);
    emit(state.copyWith(cards: state.cards));
  }

  changeCardIndex(int i) async {
    emit(state.copyWith(changeCardIndex: i));
  }

  checkPrice(String price) {
    price = price.replaceAll("\$", "");
    price = price.replaceAll(",", "");
    if ((int.tryParse(price) ?? 0) >=
        (state.cards?[state.changeCardIndex].moneyAmount ?? 0)) {
      return true;
    } else {
      return false;
    }
  }

  getCardOwner(String cardNumber) async {
    try {
      var res = await firestore
          .collection("cards")
          .where("number", isEqualTo: cardNumber)
          .get();
      emit(state.copyWith(senderName: res.docs.first.data()["owner"]));
    } catch (e) {
      emit(state.copyWith(senderName: ""));
    }
  }

  Future<String> getUserCard(int index) async {
    var res = await firestore
        .collection("cards")
        .where("ownerId", isEqualTo: state.users?[index].docId)
        .get();
    List<CardModel> cards = [];
    for (var element in res.docs) {
      cards.add(CardModel.fromJson(json: element.data(), docId: element.id));
    }
    for (int i = 0; i < cards.length; i++) {
      if (cards[i].isMain ?? false) {
        emit(state.copyWith(changeUserIndex: index));
       return cards[i].number ?? "";
      }
    }
    return "";
  }

  sendMoney(
      {required String price,
      required VoidCallback onSend,
      required String cardNumber}) async {
    emit(state.copyWith(sendLoading: true));

    price = price.replaceAll("\$", "");
    price = price.replaceAll(",", "");
    state.cards?[state.changeCardIndex].moneyAmount =
        ((state.cards![state.changeCardIndex].moneyAmount ?? 0) -
            int.parse(price));
    await updateCard(state.cards![state.changeCardIndex]);

    await sendMessage(
      fcmToken: await getToken(cardNumber, int.parse(price)),
      price: price,
    );
    emit(state.copyWith(cards: state.cards, senderName: ""));
    getAllMoney();
    onSend();
    emit(state.copyWith(sendLoading: false));
  }

  getToken(String cardNumber, num money) async {
    var res = await firestore
        .collection("cards")
        .where("number", isEqualTo: cardNumber)
        .get();
    var resCard =
        await firestore.collection("cards").doc(res.docs.first.id).get();

    CardModel card =
        CardModel.fromJson(json: resCard.data()!, docId: resCard.id);

    card = card.copyWith(moneyAmount: card.moneyAmount! + money);

    await firestore
        .collection("cards")
        .doc(res.docs.first.id)
        .update(card.toJson());

    var response = await firestore
        .collection("users")
        .doc(res.docs.first.data()['ownerId'])
        .get();
    return response.data()?["fcmToken"];
  }

  sendMessage({required String fcmToken, required String price}) async {
    var res = await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: {
        "Content-Type": "application/json",
        'Authorization':
            'key=AAAAPPvmRz0:APA91bFFtzOoZuf-71tbUtscsiqRfHFJ_M-6ajYA06vqU6gDIklFSnNIPlehdSVkLoII1n-pGFEBs54Nz2c4CHb8AmIwrcWfHw0uVjq3FoE20e1uR70Qw9GlsEO2x4KmhJhFPOjJVTTM'
      },
      body: jsonEncode(
        {
          "to": fcmToken,
          "data": {
            "body": "transferred $price to you.",
            "title": "${state.user?.name}"
          }
        },
      ),
    );
    debugPrint("${res.statusCode}");
  }
}
