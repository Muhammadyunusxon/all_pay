import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<bool> checkPhone(String phone) async {
    try {
      var res = await firestore
          .collection("users")
          .where("phone", isEqualTo: phone)
          .get();
      // ignore: unnecessary_null_comparison
      if (res.docs.first != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      return false;
    }
  }

  sendSms(String phone, VoidCallback codeSend) async {
    emit(state.copyWith(isLoading: true, errorText: null));
    if (await checkPhone(phone)) {
      emit(state.copyWith(
          isLoading: false, errorText: "bu nomer ga uje account ochilgan"));
    } else {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) {
          debugPrint(credential.toString());
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(state.copyWith(
            phone: phone,
            isLoading: false,
          ));
          codeSend();
          emit(state.copyWith(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  checkCode(String code, VoidCallback onSuccess) async {
    emit(state.copyWith(isLoading: true));
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: state.verificationId, smsCode: code);
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(state.copyWith(isLoading: false));
      onSuccess();
    } catch (e) {
      debugPrint("$e");
    }
  }

  setStateUser(
      {required String name,
      required String username,
      required String password,
      required String email,
      required String gender,
      required String birth,
      required VoidCallback onSuccess}) {
    state.copyWith(
      userModel: UserModel(
          name: name,
          username: username,
          password: password,
          email: email,
          gender: gender,
          phone: state.phone,
          birth: birth,
          favourite: ''),
    );
    onSuccess();
  }

  login(String phone, String password, VoidCallback onSuccess) async {
    emit(state.copyWith(isLoading: true, errorText: null));
    try {
      var res = await firestore
          .collection("users")
          .where("phone", isEqualTo: phone)
          .get();
      if (res.docs.first["password"] == password) {
        LocalStore.setDocId(res.docs.first.id);
        onSuccess();
        emit(state.copyWith(isLoading: false));
      } else {
        emit(
          state.copyWith(
              isLoading: false,
              errorText:
                  "Password xatto bolishi mumkin yoki bunaqa nomer bn sign up qilinmagan"),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
            isLoading: false,
            errorText:
                "Password xatto bolishi mumkin yoki bunaqa nomer bn sign up qilinmagan"),
      );
    }
  }

  createUser(VoidCallback onSuccess) async {
    firestore
        .collection("users")
        .add(UserModel(
                name: state.userModel?.name ?? "",
                username: state.userModel?.username ?? "",
                password: state.userModel?.password ?? "",
                email: state.userModel?.email ?? "",
                gender: state.userModel?.gender ?? "",
                phone: state.userModel?.phone ?? "",
                birth: state.userModel?.birth ?? "",
                favourite: '')
            .toJson())
        .then((value) async {
      await LocalStore.setDocId(value.id);
      onSuccess();
    });
  }

  loginGoogle(VoidCallback onSuccess) async {
    emit(state.copyWith(isGoogleLoading: true));
    GoogleSignIn googleSignIn = GoogleSignIn();

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if(googleUser?.authentication !=null){
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
            favourite: '')
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
                  favourite: '')
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
    emit(state.copyWith(isFacebookLoading: false));
  }
}
