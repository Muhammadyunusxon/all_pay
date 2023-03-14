import 'package:all_pay/presentation/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ThemeStyle {
  ThemeStyle._();

  static ThemeData? lightTheme = ThemeData(
      primaryColor: Style.whiteColor,
      cardColor: Style.greyscale300Color,
      hintColor: Style.whiteColor,
      hoverColor: Style.primaryColor.withOpacity(0.1),
      secondaryHeaderColor: Style.greyscale800Color,
      textTheme: TextTheme(
        displayLarge: Style.textStyleBold(textColor: Style.greyscale900Color),
        displayMedium:
            Style.textStyleSemiBold(textColor: Style.greyscale900Color),
        displaySmall: Style.textStyleNormal(textColor: Style.greyscale900Color),
        headlineMedium:
            Style.textStyleRegular(textColor: Style.greyscale900Color),
        titleMedium:
            Style.textStyleCustom(textColor: Style.greyColor, size: 16.sp),
      ));

  static ThemeData? darkTheme = ThemeData(
      primaryColor: Style.dark1Color,
      cardColor: Style.dark3Color,
      hintColor: Style.dark2Color,
      hoverColor: Style.dark3Color,
      secondaryHeaderColor: Style.whiteColor,
      textTheme: TextTheme(
        displayLarge: Style.textStyleBold(textColor: Style.whiteColor),
        displayMedium: Style.textStyleSemiBold(textColor: Style.whiteColor),
        displaySmall: Style.textStyleNormal(textColor: Style.whiteColor),
        headlineMedium: Style.textStyleRegular(textColor: Style.whiteColor),
        titleMedium:
            Style.textStyleCustom(textColor: Style.greyColor, size: 16.sp),
      ));
}
