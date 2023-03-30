import 'package:all_pay/application/home_cubit/home_cubit.dart';
import 'package:all_pay/presentation/pages/cards/widget/card_item.dart';
import 'package:all_pay/presentation/utils/my_app_bar.dart';
import 'package:all_pay/presentation/utils/my_button.dart';
import 'package:all_pay/presentation/utils/my_form_field.dart';
import 'package:all_pay/presentation/utils/my_image_network.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../infrastructure/services/my_errors.dart';
import '../../../infrastructure/services/time_deleyed.dart';
import '../../style/style.dart';
import '../../../infrastructure/services/card_utils.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late TextEditingController cardNumber;
  late TextEditingController price;
  late PageController pageController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _delayed = Delayed(milliseconds: 700);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().getUsers();
    });
    pageController = PageController();

    cardNumber = MaskedTextController(mask: '0000 0000 0000 0000');
    price = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    cardNumber.dispose();
    price.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      body: Form(
        key: formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MyAppBar(title: "Payment"),
                24.verticalSpace,
                SizedBox(
                  height: 50,
                  child: BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (p, s) => p.users != s.users,
                    builder: (context, state) {
                      return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          scrollDirection: Axis.horizontal,
                          itemCount: state.users?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: GestureDetector(
                                onTap: () async {
                                  cardNumber.text = await context
                                      .read<HomeCubit>()
                                      .getUserCard(index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                          color: state.changeUserIndex == index
                                              ? Theme
                                              .of(context)
                                              .secondaryHeaderColor
                                              : Style.transparent)),
                                  child: CustomImageNetwork(
                                    height: 50,
                                    width: 50,
                                    image: state.users?[index].avatar,
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
                18.verticalSpace,
                MyFormField(
                  controller: cardNumber,
                  title: "Card number",
                  textInputAction: TextInputAction.next,
                  inputType: TextInputType.number,
                  onChange: (s) {
                    _delayed.run(() async {
                      context.read<HomeCubit>().getCardOwner(s);
                    });
                  },
                  validator: CardUtils.validateCardNum,
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 48.w, vertical: 3.h),
                  child: BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (p, s) => p.senderName != s.senderName,
                    builder: (context, state) {
                      return Text(
                        state.senderName,
                        style: Theme
                            .of(context)
                            .textTheme
                            .displaySmall,
                      );
                    },
                  ),
                ),
                3.verticalSpace,
                MyFormField(
                  controller: price,
                  title: "Price",
                  textInputAction: TextInputAction.done,
                  inputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                        decimalDigits: 0,
                        symbol: "\$",
                        locale: "en",
                        enableNegative: false)
                  ],
                  onChange: (s) {
                    formKey.currentState?.validate();
                  },
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return Errors.fieldReq;
                    } else if (context
                        .read<HomeCubit>()
                        .checkPrice(price.text)) {
                      return Errors.moneyIsScarce;
                    } else {
                      return null;
                    }
                  },
                ),
                12.verticalSpace,
                BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (p, s) => p.cards != s.cards,
                  builder: (context, state) {
                    return SizedBox(
                      height: 150,
                      child: PageView.builder(
                          controller: pageController,
                          onPageChanged: (v) {
                            context.read<HomeCubit>().changeCardIndex(v);
                          },
                          itemCount: state.cards?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CardItem(
                              cardName: state.cards?[index].cardName ?? "",
                              number: state.cards?[index].number ?? "",
                              owner: state.cards?[index].owner ?? "",
                              expireData: state.cards?[index].expireDate ?? "",
                              indexGradient:
                              state.cards?[index].indexGradient ?? -1,
                              indexImage: state.cards?[index].indexImage ?? 1,
                              moneyAmount: state.cards?[index].moneyAmount ?? 0,
                            );
                          }),
                    );
                  },
                ),
                32.verticalSpace,
                BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (p, s) => p.sendLoading != s.sendLoading,
                  builder: (context, state) {
                    return MyButton(
                        isLoading: state.sendLoading,
                        text: "Send",
                        onTap: () {
                          if (formKey.currentState?.validate() ?? false) {
                            context.read<HomeCubit>().sendMoney(
                                price: price.text,
                                onSend: () {
                                  Navigator.pop(context);
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.success(
                                      message:
                                      "${price.text} sent successfully",
                                    ),
                                  );
                                },
                                cardNumber: cardNumber.text);
                          }
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
