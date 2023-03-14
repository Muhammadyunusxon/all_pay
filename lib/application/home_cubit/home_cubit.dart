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
    getAllMoney();
  }

  getAllMoney() {
    num amount = 0;
    for (int i = 0; i < (state.cards?.length ?? 0); i++) {
      amount = amount + (state.cards?[i].moneyAmount ?? 0);
    }
    emit(state.copyWith(allMoney: amount));
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
      }
    }

    emit(state.copyWith(cards: state.cards));
  }

  removeCard({required String docId, required int index}) async {
    emit(state.copyWith(allMoney: state.allMoney + (state.cards?[index].moneyAmount ?? 0)));
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
    var res = await firestore
        .collection("cards")
        .where("number", isEqualTo: cardNumber)
        .get();
    print(res.docs.first.data()["owner"]);
  }

  sendMoney(
      {required String price,
      required VoidCallback onSend,
      required String cardNumber}) async {
    emit(state.copyWith(isLoading: true));
    await sendMessage(await getToken(cardNumber));
    price = price.replaceAll("\$", "");
    price = price.replaceAll(",", "");
    state.cards?[state.changeCardIndex].moneyAmount =
        ((state.cards![state.changeCardIndex].moneyAmount ?? 0) -
            int.parse(price));
    emit(state.copyWith(cards: state.cards, isLoading: false));
    onSend;
    getAllMoney();
  }


  getToken(String cardNumber) async {
    var res = await firestore
        .collection("cards")
        .where("number", isEqualTo: cardNumber)
        .get();
    var response = await firestore
        .collection("users")
        .doc(res.docs.first.data()['ownerId'])
        .get();
    return response.data()?["fcmToken"];
  }

  sendMessage(String fcmToken) async {
    var res= await http.post(
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
            "body": "Sizning kartangizdan *** summa yechib olindi",
            "title": "Biz bn ishlaganiz raxmat !!!"
          }
        },
      ),
    );
    debugPrint("${res.statusCode}");
  }
}
