import 'package:all_pay/application/app_cubit/app_cubit.dart';
import 'package:all_pay/infrastructure/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_router.dart';
import '../../style/style.dart';
import '../../utils/my_button.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              120.h.verticalSpace,
              BlocBuilder<AppCubit, AppState>(
                buildWhen: (p, s) => p.page != s.page,
                builder: (context, state) {
                  return SizedBox(
                    height: 350,
                    child: Image.asset(
                        "assets/images/${state.page == 1 ? "image1" : state.page == 2 ? "image2" : "image3"}.png"),
                  );
                },
              ),
              34.h.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: BlocBuilder<AppCubit, AppState>(
                  buildWhen: (p, s) => p.page != s.page,
                  builder: (context, state) {
                    return Text(
                      state.page == 1
                          ? "Easy, Fast & Trusted"
                          : state.page == 2
                              ? "Saving Your Money"
                              : "Multiple Credit Cards",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontSize: 35.sp),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.h, right: 24.w, left: 24.w),
                child: BlocBuilder<AppCubit, AppState>(
                  buildWhen: (p, s) => p.page != s.page,
                  builder: (context, state) {
                    return Text(
                      state.page == 1
                          ? "Fast money transfer and gauranteed safe transactions with others."
                          : state.page == 2
                              ? "Track the progress of your savings and start a habit of saving with All Pay."
                              : "Provides the 100% freedom of the financial management with Multiple Payment Options for local & International Payments.",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
              const Spacer(),
              BlocBuilder<AppCubit, AppState>(
                buildWhen: (p, s) => p.page != s.page,
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 1; i < 4; i++)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          height: 6,
                          width: state.page == i ? 14 : 6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: state.page == i
                                  ? null
                                  : Theme.of(context).cardColor,
                              gradient:
                                  state.page == i ? Style.blueGradiant : null),
                        ),
                    ],
                  );
                },
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: MyButton(
                  text: 'Next',
                  onTap: () {
                    context.read<AppCubit>().changePageIndex(onPushed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          Routes.goAuth(), (route) => false);
                      LocalStore.setOnBoarding();
                    });
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
