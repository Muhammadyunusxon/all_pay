import 'package:all_pay/infrastructure/services/local_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../app_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // checking();
    super.initState();
  }

  checking() async {
    print(await LocalStore.getDocId());
    print(await LocalStore.getOnBoarding());

    if (await LocalStore.getOnBoarding()) {
      FlutterNativeSplash.remove();
      // ignore: use_build_context_synchronously
      Navigator.push(context, Routes.goOnBoarding());
    } else {
      if (await LocalStore.getDocId() != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(context, Routes.goMain());
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(context, Routes.goOnBoarding());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/splash.png",
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
