import 'package:all_pay/infrastructure/services/app_helper.dart';
import 'package:all_pay/presentation/pages/cards/widget/card_item.dart';
import 'package:all_pay/presentation/utils/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../application/home_cubit/home_cubit.dart';
import '../../app_router.dart';
import '../../style/style.dart';
import 'package:lottie/lottie.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const MyAppBar(title: "Cards"),
              32.verticalSpace,
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return state.cards?.isEmpty ?? false
                      ? Lottie.network(
                          "https://assets7.lottiefiles.com/packages/lf20_NeuXI2OPLG.json")
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.cards?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 14.h),
                              child: GestureDetector(
                                onTap: () {
                                  AppHelpers.showBottomChange(
                                      context: context,
                                      onEdit: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            Routes.goAddCard(
                                                isUpdate: true,
                                                card: state.cards?[index],
                                                onSummit: (card) {
                                                  context
                                                      .read<HomeCubit>()
                                                      .updateCard(card);
                                                }));
                                      },
                                      onDelete: () async {
                                        Navigator.pop(context);
                                        AppHelpers.showConfirm(context, () {
                                          context.read<HomeCubit>().removeCard(
                                              docId:
                                                  state.cards?[index].docId ??
                                                      "",
                                              index: index);
                                        });
                                      });
                                },
                                child: CardItem(
                                  cardName: state.cards?[index].cardName ?? "",
                                  number: state.cards?[index].number ?? "",
                                  owner: state.cards?[index].owner ?? "",
                                  expireData:
                                      state.cards?[index].expireDate ?? "",
                                  indexGradient:
                                      state.cards?[index].indexGradient ?? -1,
                                  indexImage:
                                      state.cards?[index].indexImage ?? 1,
                                  moneyAmount:
                                      state.cards?[index].moneyAmount ?? 0,
                                ),
                              ),
                            );
                          });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context, Routes.goAddCard(onSummit: (card) {
            context.read<HomeCubit>().addCard(card);
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                message:
                    "The card has been added successfully and you have been awarded \$500",
              ),
            );
          }));
        },
        child: Container(
          padding: EdgeInsets.all(7.r),
          decoration: BoxDecoration(
              gradient: Style.blueGradiant, shape: BoxShape.circle),
          child: Icon(
            Icons.add,
            size: 55.sp,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
