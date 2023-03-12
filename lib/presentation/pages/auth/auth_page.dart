import 'package:all_pay/application/auth_cubit/auth_cubit.dart';
import 'package:all_pay/presentation/app_router.dart';
import 'package:all_pay/presentation/pages/auth/widgets/social_button.dart';
import 'package:all_pay/presentation/utils/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              105.h.verticalSpace,
              Text(
                "Let’s you in",
                style: Theme
                    .of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 46.sp),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Image.asset("assets/images/auth.png"),
              ),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (s,v)=> s.isFacebookLoading !=v.isFacebookLoading,
                builder: (context, state) {
                  return SocialButton(
                      isLoading: state.isFacebookLoading,
                      onTap: () {
                        print("object");
                        context.read<AuthCubit>().loginFacebook(() {
                          Navigator.pushAndRemoveUntil(
                              context, Routes.goMain(), (route) => false);
                        });
                      },
                      title: "Facebook");
                },
              ),
              18.h.verticalSpace,
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (s,v)=> s.isGoogleLoading !=v.isGoogleLoading,
                builder: (context, state) {
                  return SocialButton(
                      isLoading: state.isGoogleLoading,
                      onTap: () {
                        context.read<AuthCubit>().loginGoogle(() {
                          Navigator.pushAndRemoveUntil(
                              context, Routes.goMain(), (route) => false);
                        });
                      },
                      title: "Google");
                },
              ),
              32.h.verticalSpace,
              Row(
                children: [
                  Expanded(
                      child: Divider(
                        color: Theme
                            .of(context)
                            .cardColor,
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "or",
                        style: Theme
                            .of(context)
                            .textTheme
                            .displaySmall,
                      )),
                  Expanded(
                      child: Divider(
                        color: Theme
                            .of(context)
                            .cardColor,
                      )),
                ],
              ),
              20.h.verticalSpace,
              MyButton(
                  text: "Sign in with password",
                  onTap: () {
                    Navigator.push(context, Routes.goSignIn());
                  }),
              12.h.verticalSpace,
              TextButton(
                  onPressed: () {
                    Navigator.push(context, Routes.goSignUp());
                  },
                  child: Text(
                    "Don’t have an account? Sign up",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
