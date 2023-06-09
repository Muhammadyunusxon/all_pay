import 'package:all_pay/infrastructure/services/local_storage.dart';
import 'package:all_pay/presentation/pages/home/widgets/home_buttons.dart';
import 'package:all_pay/presentation/utils/my_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../application/app_cubit/app_cubit.dart';
import '../../../application/home_cubit/home_cubit.dart';
import '../../app_router.dart';
import '../../style/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RefreshController _refreshController;
  @override
  void initState() {
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeCubit>().getUserInfo();
    });
    super.initState();
  }


  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      onLoading: () {},
      onRefresh: () async {
        context.read<HomeCubit>().getCardInfo();
        _refreshController.refreshCompleted();
      },
      child: SingleChildScrollView(
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
                    onPressed: () {
                      LocalStore.removeDocId();
                      Navigator.pushAndRemoveUntil(
                          context, Routes.goSplash(), (route) => false);
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).secondaryHeaderColor,
                    )),
                BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    return IconButton(
                        onPressed: () {
                          context.read<AppCubit>().change();
                        },
                        icon: Icon(
                          state.isChangeTheme? Icons.sunny :Icons.nightlight,
                          color: Theme.of(context).secondaryHeaderColor,
                        ));
                  },
                ),
              ],
            ),
            24.h.verticalSpace,
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Container(
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
                          Expanded(
                            child: Text(
                              state.user?.name ?? "",
                              style: Style.textStyleSemiBold(size: 18),
                            ),
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
                            .format(state.allMoney),
                        style: Style.textStyleSemiBold(size: 24),
                      ),
                      24.h.verticalSpace,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Theme.of(context).primaryColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            HomeButtons(
                              icon: Icons.credit_card,
                              title: 'Cards',
                              onTap: () {
                                Navigator.push(context, Routes.goCards(context));
                              },
                            ),
                            HomeButtons(
                              icon: Icons.sync_alt,
                              title: 'Payment',
                              onTap: () {
                                Navigator.push(
                                    context, Routes.goPayment(context));
                              },
                            ),
                            HomeButtons(
                              icon: Icons.stacked_line_chart,
                              title: 'Statistic',
                              onTap: () {
                                // Navigator.push(context, Routes.goCards(context));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
