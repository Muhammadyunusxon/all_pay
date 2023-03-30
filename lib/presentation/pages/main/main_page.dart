import 'package:all_pay/presentation/pages/home/home_page.dart';
import 'package:all_pay/presentation/pages/payment/payment_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../application/app_cubit/app_cubit.dart';
import '../../../application/home_cubit/home_cubit.dart';
import '../../style/style.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<void> getMassage() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((event) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message:
              "${event.data["title"] ?? "title"} ${event.data["body"] ?? "body"}",
        ),
      );
      context.read<HomeCubit>().getCardInfo();
    });
  }

  @override
  void initState() {
    getMassage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (p, s) => p.selected != s.selected,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
            child: ProsteIndexedStack(
              index: state.selected,
              children: [
                IndexedStackChild(child: const HomePage()),
                IndexedStackChild(child: const PaymentPage()),
                IndexedStackChild(child: const Placeholder()),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Style.primaryColor,
            unselectedItemColor: Theme.of(context).secondaryHeaderColor,
            backgroundColor: Theme.of(context).primaryColor,
            currentIndex: state.selected,
            onTap: (s) {
              context.read<AppCubit>().changePage(s);
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sync_alt), label: "Payment"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        );
      },
    );
  }
}
