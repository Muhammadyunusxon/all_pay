import 'package:all_pay/application/app_cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_router.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              children: [
                120.h.verticalSpace,
                Image.asset(
                    "assets/images/${state.page == 1 ? "image1" : state.page == 2 ? "image2" : "image3"}.png"),
                34.h.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    state.page == 1
                        ? "Easy, Fast & Trusted"
                        : state.page == 2
                            ? "Saving Your Money"
                            : "Multiple Credit Cards",
                    style: const TextStyle(
                      color: Color(0xff2972FE),
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.h, right: 24, left: 24),
                  child: Text(
                    state.page == 1
                        ? "Fast money transfer and gauranteed safe transactions with others."
                        : state.page == 2
                            ? "Track the progress of your savings and start a habit of saving with All Pay."
                            : "Provides the 100% freedom of the financial management with Multiple Payment Options for local & International Payments.",
                    style: TextStyle(
                        color: const Color(0xff2C3A4B),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 1; i < 4; i++)
                      AnimatedContainer(
                        duration: const Duration(seconds: 7),
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        height: 6,
                        width: state.page == i ? 12 : 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: state.page == i
                              ? const Color(0xff2972FE)
                              : const Color(0xffEBEEF2),
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: GestureDetector(
                    onTap: () {
                      if (state.page == 3) {
                        Navigator.of(context).pushAndRemoveUntil(
                            Routes.goAuth(), (route) => false);
                      } else {
                        context.read<AppCubit>().changePageIndex();
                      }
                    },
                    child: Container(
                      height: 55.h,
                      width: 380.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(33.r),
                          gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xff2972FE),
                                Color(0xff6499FF),
                              ])),
                      child: const Center(
                          child: Text(
                        "Next",
                        style: TextStyle(
                          color: Color(0xffFFFFFF),
                        ),
                      )),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
