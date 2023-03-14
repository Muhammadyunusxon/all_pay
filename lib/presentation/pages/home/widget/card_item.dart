import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../style/style.dart';

const List<List> listOfGradient = [
  [0xff3DD14A, 0xffECD416],
  [0xffB85BEB, 0xff615DE1],
  [0xffF23658, 0xffF5990E],
  [0xffEDA725, 0xffBAB4A2],
  [0xff060606, 0xff1E1E20],
  [0xffF4990C, 0xffF63F58],
];

class CardItem extends StatelessWidget {
  final String cardName;
  final String number;
  final String owner;
  final String expireData;
  final int indexGradient;
  final int indexImage;
  final num moneyAmount;
  final bool moneyVisibility;

  const CardItem(
      {Key? key,
      required this.cardName,
      required this.number,
      required this.owner,
      required this.expireData,
      required this.indexGradient,
      required this.indexImage,
      required this.moneyAmount,
      this.moneyVisibility = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 21.h),
      margin: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: indexGradient != -1
              ? LinearGradient(colors: [
                  Color(listOfGradient[indexGradient].first),
                  Color(listOfGradient[indexGradient].last),
                ])
              : null,
          image: indexImage != -1
              ? DecorationImage(
                  image: AssetImage("assets/background/$indexImage.jpg"),
                  fit: BoxFit.cover)
              : null),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cardName,
            style: Style.textStyleSemiBold(size: 18),
          ),
          const Spacer(),
          moneyVisibility
              ? Text(
                  NumberFormat.currency(name: '\$', decimalDigits: 0)
                      .format(moneyAmount),
                  style: Style.textStyleSemiBold(size: 20),
                )
              : const SizedBox.shrink(),
          const Spacer(),
          Text(
            number,
            style: Style.textStyleSemiBold(size: moneyVisibility? 17: 21),
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Card Holder",
                      style: Style.textStyleNormal(size: 12),
                    ),
                    5.verticalSpace,
                    Text(
                      owner,
                      style: Style.textStyleSemiBold(size: 16),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Expiry date",
                    style: Style.textStyleNormal(size: 12),
                  ),
                  5.verticalSpace,
                  Text(
                    expireData,
                    style: Style.textStyleSemiBold(size: 18),
                  ),
                ],
              ),
              56.w.horizontalSpace,
            ],
          ),
        ],
      ),
    );
  }
}
