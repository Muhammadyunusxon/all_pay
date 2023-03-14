import 'package:all_pay/application/auth_cubit/auth_cubit.dart';
import 'package:all_pay/presentation/app_router.dart';
import 'package:all_pay/presentation/pages/auth/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Text(
                "Let’s you in",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 46.sp),
              ),
              const Spacer(flex: 2),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: SizedBox(
                    height: 315.h,
                    child: Image.asset("assets/images/auth.png")),
              ),
              const Spacer(flex: 2),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (p, s) => p.isFacebookLoading != s.isFacebookLoading,
                builder: (context, state) {
                  return SocialButton(
                      isLoading: state.isFacebookLoading,
                      onTap: () {
                        context.read<AuthCubit>().loginFacebook(() {
                          Navigator.pushAndRemoveUntil(
                              context, Routes.goMain(), (route) => false);
                        });
                      },
                      title: "Facebook");
                },
              ),
              const Spacer(),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (p, s) => p.isGoogleLoading != s.isGoogleLoading,
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
              const Spacer(flex: 5),
            ],
          ),
        ),
      ),
    );
  }
}
