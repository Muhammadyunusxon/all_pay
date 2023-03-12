part of 'auth_cubit.dart';

class AuthState {
  bool isLoading;
  bool isGoogleLoading;
  bool isFacebookLoading;
  UserModel? userModel;
  String verificationId;
  String phone;
  String? errorText;

  AuthState(
      {this.isLoading = false,
      this.isFacebookLoading = false,
      this.isGoogleLoading = false,
      this.verificationId = '',
      this.phone = '',
      this.userModel,
      this.errorText});

  AuthState copyWith(
      {bool? isLoading,
      bool? isGoogleLoading,
      bool? isFacebookLoading,
      UserModel? userModel,
      String? verificationId,
      String? phone,
      String? errorText}) {
    return AuthState(
        isLoading: isLoading ?? this.isLoading,
        isFacebookLoading: isFacebookLoading ?? this.isFacebookLoading,
        isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
        userModel: userModel ?? this.userModel,
        phone: phone ?? this.phone,
        verificationId: verificationId ?? this.verificationId,
        errorText: errorText ?? this.errorText);
  }
}
