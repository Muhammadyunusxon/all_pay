import 'package:all_pay/presentation/pages/initial/no_connection.dart';
import 'package:all_pay/presentation/pages/initial/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
              stream: Connectivity().onConnectivityChanged,
              builder: (context, data) {
                if (data.data == ConnectivityResult.mobile ||
                    data.data == ConnectivityResult.wifi) {
                  return const SplashPage();
                } else {
                  return const NoConnectionPage();
                }
              }),
        );
      },
    );
  }
}
