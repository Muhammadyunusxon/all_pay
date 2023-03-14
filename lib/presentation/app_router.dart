import 'package:all_pay/application/app_cubit/app_cubit.dart';
import 'package:all_pay/application/auth_cubit/auth_cubit.dart';
import 'package:all_pay/application/card_cubit/card_cubit.dart';
import 'package:all_pay/application/home_cubit/home_cubit.dart';
import 'package:all_pay/infrastructure/models/card_model.dart';
import 'package:all_pay/presentation/pages/auth/auth_page.dart';
import 'package:all_pay/presentation/pages/cards/add_card_page.dart';
import 'package:all_pay/presentation/pages/cards/cards_page.dart';
import 'package:all_pay/presentation/pages/initial/onboarding_page.dart';
import 'package:all_pay/presentation/pages/initial/splash.dart';
import 'package:all_pay/presentation/pages/main/main_page.dart';
import 'package:all_pay/presentation/pages/payment/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class Routes {
  Routes._();

  static PageRoute goSplash() {
    return MaterialPageRoute(builder: (_) => const SplashPage());
  }

  static PageRoute goOnBoarding() {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (BuildContext context) => AppCubit(),
            child: const OnBoardingPage()));
  }

  static PageRoute goMain() {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (BuildContext context) => HomeCubit()
              ..getUserInfo()
              ..getCardInfo(),
            child: const MainPage()));
  }

  static PageRoute goAuth() {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (BuildContext context) => AuthCubit(),
            child: const AuthPage()));
  }

  static PageRoute goCards(BuildContext context) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
            value: BlocProvider.of<HomeCubit>(context),
            child: const CardsPage()));
  }

  static PageRoute goAddCard(
      {CardModel? card,
      bool isUpdate = false,
      required ValueChanged onSummit}) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (BuildContext context) => CardCubit()..changeCard(card),
        child: AddCardPage(isUpdate: isUpdate, onSummit: onSummit),
      ),
    );
  }

  static PageRoute goPayment(BuildContext context) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
            value: BlocProvider.of<HomeCubit>(context),
            child: const PaymentPage()));
  }
}
