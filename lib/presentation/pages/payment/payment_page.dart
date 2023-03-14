import 'package:all_pay/application/home_cubit/home_cubit.dart';
import 'package:all_pay/presentation/pages/cards/widget/card_item.dart';
import 'package:all_pay/presentation/utils/my_app_bar.dart';
import 'package:all_pay/presentation/utils/my_button.dart';
import 'package:all_pay/presentation/utils/my_form_field.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../infrastructure/services/my_errors.dart';
import '../cards/widget/card_utils.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late TextEditingController cardNumber;
  late TextEditingController price;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    cardNumber = MaskedTextController(mask: '0000 0000 0000 0000');
    price = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    cardNumber.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Form(
        key: formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
            child: Column(
              children: [
                const MyAppBar(title: "Payment"),
                32.verticalSpace,
                MyFormField(
                  controller: cardNumber,
                  title: "Card number",
                  textInputAction: TextInputAction.next,
                  inputType: TextInputType.number,
                  onChange: (s) {},
                  validator: CardUtils.validateCardNum,
                ),
                12.verticalSpace,
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
                  builder: (context, state) {
                    return SizedBox(
                      height: 150,
                      child: PageView.builder(
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
                MyButton(
                    text: "Send",
                    onTap: () {
                      if (formKey.currentState?.validate() ?? false) {
                        context
                            .read<HomeCubit>()
                            .sendMoney(price: price.text, onSend: () {



                        }, cardNumber: cardNumber.text);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
