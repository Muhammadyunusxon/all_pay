import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../infrastructure/models/user_model.dart';
import '../../infrastructure/services/local_storage.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  loginGoogle(VoidCallback onSuccess) async {
    emit(state.copyWith(isGoogleLoading: true));
    GoogleSignIn googleSignIn = GoogleSignIn();

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser?.authentication != null) {
      GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userObj =
          await FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint("${userObj.additionalUserInfo?.isNewUser}");
      if (userObj.additionalUserInfo?.isNewUser ?? true) {
        // sing in
        firestore
            .collection("users")
            .add(UserModel(
                    name: userObj.user?.displayName ?? "",
                    username: userObj.user?.displayName ?? "",
                    password: userObj.user?.uid ?? "",
                    email: userObj.user?.email ?? "",
                    gender: "",
                    phone: userObj.user?.phoneNumber ?? "",
                    birth: "",
                    avatar: userObj.user?.photoURL ?? "",
                    favourite: '',
                    fcmToken: await getToken())
                .toJson())
            .then((value) async {
          await LocalStore.setDocId(value.id);
          onSuccess();
          googleSignIn.signOut();
        });
      } else {
        // sing up
        var res = await firestore
            .collection("users")
            .where("email", isEqualTo: userObj.user?.email)
            .get();

        if (res.docs.isNotEmpty) {
          await LocalStore.setDocId(res.docs.first.id);
          onSuccess();
        }
      }
    }

    emit(state.copyWith(isGoogleLoading: false));
  }

  loginFacebook(VoidCallback onSuccess) async {
    emit(state.copyWith(isFacebookLoading: true));
    final fb = FacebookLogin();
    final user = await fb.logIn(permissions: [
      FacebookPermission.email,
      FacebookPermission.publicProfile
    ]);
    if (user.status == FacebookLoginStatus.success) {
      final OAuthCredential credential =
          FacebookAuthProvider.credential(user.accessToken?.token ?? "");

      final userObj =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userObj.additionalUserInfo?.isNewUser ?? true) {
        // sing in
        firestore
            .collection("users")
            .add(UserModel(
                    name: userObj.user?.displayName ?? "",
                    username: userObj.user?.displayName ?? "",
                    password: userObj.user?.uid ?? "",
                    email: userObj.user?.email ?? "",
                    gender: "",
                    phone: userObj.user?.phoneNumber ?? "",
                    birth: "",
                    avatar: userObj.user?.photoURL ?? "",
                    favourite: '',
                    fcmToken: await getToken())
                .toJson())
            .then((value) async {
          await LocalStore.setDocId(value.id);
          onSuccess();
        });
      } else {
        // sing up
        var res = await firestore
            .collection("users")
            .where("email", isEqualTo: userObj.user?.email)
            .get();

        if (res.docs.isNotEmpty) {
          await LocalStore.setDocId(res.docs.first.id);
          onSuccess();
        }
      }
    }

    emit(state.copyWith(isFacebookLoading: false));
  }

  Future<String?> getToken() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      sound: true,
    );
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    return fcmToken;
  }
}
