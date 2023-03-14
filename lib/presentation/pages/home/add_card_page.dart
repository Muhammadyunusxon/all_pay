import 'package:all_pay/presentation/pages/home/widget/card_item.dart';
import 'package:all_pay/presentation/pages/home/widget/card_utils.dart';
import 'package:all_pay/presentation/pages/home/widget/change_card_theme.dart';
import 'package:all_pay/presentation/pages/home/widget/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../application/card_cubit/card_cubit.dart';
import '../../../infrastructure/models/card_model.dart';
import '../../../infrastructure/services/diss_keyboard.dart';
import '../../utils/my_button.dart';
import '../../utils/my_form_field.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class AddCardPage extends StatefulWidget {
  final bool isUpdate;
  final ValueChanged<CardModel> onSummit;

  const AddCardPage({Key? key, required this.isUpdate, required this.onSummit})
      : super(key: key);

  @override
  State<AddCardPage> createState() => AddCardPageState();
}

class AddCardPageState extends State<AddCardPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController cardNumber;
  late TextEditingController cardDate;
  late TextEditingController cardName;
  late TextEditingController cardOwner;

  @override
  void initState() {
    cardNumber = MaskedTextController(mask: '0000 0000 0000 0000');
    cardDate = MaskedTextController(mask: '00/00');
    cardName = TextEditingController();
    cardOwner = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    cardNumber.dispose();
    cardDate.dispose();
    cardName.dispose();
    cardOwner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: OnUnFocusTap(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   MyAppBar(
                    title: widget.isUpdate? "Update Card": "Add Card",
                  ),
                  BlocBuilder<CardCubit, CardState>(
                    buildWhen: (p, s) => p.card != s.card,
                    builder: (context, state) {
                      if (widget.isUpdate) {
                        cardName.text = state.card?.cardName ?? "";
                        cardNumber.text = state.card?.number ?? "";
                        cardOwner.text = state.card?.owner ?? "";
                        cardDate.text = state.card?.expireDate ?? "";
                      }
                      return CardItem(
                        cardName: state.card?.cardName ?? "",
                        number: state.card?.number ?? "",
                        owner: state.card?.owner ?? "",
                        expireData: state.card?.expireDate ?? "",
                        indexGradient: state.card?.indexGradient ?? -1,
                        indexImage: state.card?.indexImage ?? 1,
                        moneyAmount: state.card?.moneyAmount ?? 0,
                        moneyVisibility: false,
                      );
                    },
                  ),
                  10.verticalSpace,
                  BlocBuilder<CardCubit, CardState>(
                    buildWhen: (p, s) =>
                        p.card?.indexGradient != s.card?.indexGradient ||
                        p.card?.indexImage != s.card?.indexImage,
                    builder: (context, state) {
                      return ChangeCardTheme(
                        onGradient: (index) {
                          context.read<CardCubit>().changeGradient(index);
                        },
                        onImage: (index) {
                          context.read<CardCubit>().changeImage(index);
                        },
                        indexGradient: state.card?.indexGradient ?? -1,
                        indexImage: state.card?.indexImage ?? 1,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  MyFormField(
                    controller: cardNumber,
                    title: 'Card number',
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.number,
                    onChange: (value) {
                      context.read<CardCubit>().changeNumber(value);
                    },
                    validator: CardUtils.validateCardNum,
                  ),
                  MyFormField(
                    controller: cardDate,
                    title: 'Expiry date',
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.number,
                    onChange: (value) {
                      context.read<CardCubit>().changeDate(value);
                    },
                    validator: CardUtils.validateDate,
                  ),
                  MyFormField(
                    controller: cardName,
                    title: 'Card name',
                    textInputAction: TextInputAction.next,
                    onChange: (value) {
                      context.read<CardCubit>().changeName(value);
                    },
                    validator: CardUtils.validateEmpty,
                  ),
                  MyFormField(
                    textInputAction: TextInputAction.done,
                    controller: cardOwner,
                    title: "Card Holder",
                    onChange: (value) {
                      context.read<CardCubit>().changeOwner(value);
                    },
                    validator: CardUtils.validateEmpty,
                  ),
                  32.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: BlocBuilder<CardCubit, CardState>(
                      buildWhen: (p, s) => p.isLoading != s.isLoading,
                      builder: (context, state) {
                        return MyButton(
                          isLoading: state.isLoading,
                          text: widget.isUpdate? "Update": "Add",
                          onTap: () {
                            if (formKey.currentState?.validate() ?? false) {
                              context.read<CardCubit>().createCard(
                                  onSuccess: (v) {
                                    widget.onSummit(v);
                                    Navigator.pop(context);
                                  },
                                  isUpdate: widget.isUpdate);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  32.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
