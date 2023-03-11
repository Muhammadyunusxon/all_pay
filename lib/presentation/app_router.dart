import 'package:all_pay/application/app_cubit/app_cubit.dart';
import 'package:all_pay/application/auth_cubit/auth_cubit.dart';
import 'package:all_pay/presentation/pages/auth/auth_page.dart';
import 'package:all_pay/presentation/pages/initial/no_connection.dart';
import 'package:all_pay/presentation/pages/initial/onboarding_page.dart';
import 'package:all_pay/presentation/pages/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class Routes {
  Routes._();

  static PageRoute goOnBoarding() {
    return MaterialPageRoute(builder: (_) => BlocProvider(
        create: (BuildContext context) => AppCubit(),
        child: const OnBoardingPage()));
  }

  static PageRoute goMain() {
    return MaterialPageRoute(builder: (_) => const MainPage());
  }

  static PageRoute goAuth() {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (BuildContext context) => AuthCubit(),
            child: const AuthPage()));
  }
}
