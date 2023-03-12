import 'package:all_pay/infrastructure/services/local_storage.dart';
import 'package:all_pay/presentation/pages/initial/no_connection.dart';
import 'package:all_pay/presentation/pages/initial/splash.dart';
import 'package:all_pay/presentation/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../application/app_cubit/app_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getTheme(),
      child: const AppWidget(),
    );
  }
}

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();

  // ignore: library_private_types_in_public_api
  static _AppWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AppWidgetState>();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
 // LocalStore.removeDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return BlocBuilder<AppCubit, AppState>(
          buildWhen: (e, v) => e.isChangeTheme != v.isChangeTheme,
          builder: (context, state) {
            return MaterialApp(
              themeMode: state.isChangeTheme ? ThemeMode.dark : ThemeMode.light,
              theme: ThemeStyle.lightTheme,
              darkTheme: ThemeStyle.darkTheme,
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
      },
    );
  }
}
