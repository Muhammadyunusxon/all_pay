import 'package:all_pay/presentation/utils/my_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../application/home_cubit/home_cubit.dart';
import '../../app_router.dart';
import '../../style/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeCubit>().getUserInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.r),
      child: Column(
        children: [
          Row(
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (p, s) => p.user?.avatar != s.user?.avatar,
                builder: (context, state) {
                  return CustomImageNetwork(
                      height: 48.r, width: 48.r, image: state.user?.avatar);
                },
              ),
              16.w.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning 👋",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    BlocBuilder<HomeCubit, HomeState>(
                      buildWhen: (p, s) => p.user?.name != s.user?.name,
                      builder: (context, state) {
                        return Text(
                          (state.user?.name?.contains(" ") == true
                                  ? state.user?.name?.substring(
                                      0, state.user?.name?.indexOf(" "))
                                  : state.user?.name) ??
                              "",
                          style: Theme.of(context).textTheme.displayMedium,
                        );
                      },
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: Theme.of(context).secondaryHeaderColor,
                  ))
            ],
          ),
          24.h.verticalSpace,
          Container(
            padding: EdgeInsets.all(32.r),
            decoration: BoxDecoration(
                gradient: Style.blueGradiant,
                borderRadius: BorderRadius.circular(32.r),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(4, 8),
                      blurRadius: 24,
                      color: Style.infoColor.withOpacity(0.25))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Andrew Ainsley",
                      style: Style.textStyleSemiBold(size: 18),
                    )
                  ],
                ),
                24.h.verticalSpace,
                Text(
                  "Your balance",
                  style: Style.textStyleCustom(size: 14),
                ),
                8.h.verticalSpace,
                Text(
                  NumberFormat.currency(name: '\$', decimalDigits: 0)
                      .format(123456),
                  style: Style.textStyleSemiBold(size: 24),
                ),
                24.h.verticalSpace,
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Theme.of(context).primaryColor),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, Routes.goCards(context));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16.r),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).hoverColor,
                                ),
                                child: const Icon(
                                  Icons.credit_card_rounded,
                                  color: Style.primaryColor,
                                ),
                              ),
                              8.h.verticalSpace,
                              Text(
                                "Cards",
                                style: Style.textStyleSemiBold(
                                    textColor: Style.primaryColor),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
