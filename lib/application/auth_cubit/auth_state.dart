part of 'auth_cubit.dart';

class AuthState {
  bool isGoogleLoading;
  bool isFacebookLoading;

  AuthState({this.isFacebookLoading = false, this.isGoogleLoading = false});

  AuthState copyWith({bool? isGoogleLoading, bool? isFacebookLoading}) {
    return AuthState(
      isFacebookLoading: isFacebookLoading ?? this.isFacebookLoading,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
    );
  }
}
