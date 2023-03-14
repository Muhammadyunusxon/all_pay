import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Style {
  Style._();

  static const primaryColor = Color(0xff246BFD);
  static const secondaryColor = Color(0xffFFD300);

  //Alert & Status
  static const successColor = Color(0xff4ADE80);
  static const infoColor = Color(0xff246BFD);
  static const warningColor = Color(0xffFACC15);
  static const errorColor = Color(0xffF75555);

  //Greyscale
  static const greyscale900Color = Color(0xff212121);
  static const greyscale800Color = Color(0xff424242);
  static const greyscale700Color = Color(0xff616161);
  static const greyscale600Color = Color(0xff757575);
  static const greyscale500Color = Color(0xff9E9E9E);
  static const greyscale400Color = Color(0xffBDBDBD);
  static const greyscale300Color = Color(0xffE0E0E0);
  static const greyscale200Color = Color(0xffF5F5F5);
  static const greyscale50Color = Color(0xffFAFAFA);

  //Dark Colors
  static const dark1Color = Color(0xff181A20);
  static const dark2Color = Color(0xff1F222A);
  static const dark3Color = Color(0xff35383F);

  //Others
  static const whiteColor = Color(0xffFFFFFF);
  static const blackColor = Color(0xff000000);
  static const redColor = Color(0xffF44336);
  static const pinkColor = Color(0xffE91E63);
  static const purpleColor = Color(0xff9C27B0);
  static const deepPurpleColor = Color(0xff673AB7);
  static const indigoColor = Color(0xff3F51B5);
  static const blueColor = Color(0xff2196F3);
  static const greyColor = Color(0xff878787);
  static const transparent = Colors.transparent;

  //Gradients
  static LinearGradient blueGradiant = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xff6F9EFF), Color(0xff246BFD)]);

  static LinearGradient sunsetOrangeGradiant = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xffFF8285), Color(0xffFF575C)]);

  static LinearGradient purpleGradiant = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xff896BFF),
        Color(0xff6842FF),
      ]);

  static LinearGradient greenGradiant = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xff39E180),
        Color(0xff1AB65C),
      ]);

  static LinearGradient yellowGradiant = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xffFFE580),
        Color(0xffFACC15),
      ]);

  static textStyleNormal(
      {double size = 16,
      Color textColor = whiteColor,
      bool isActive = false}) {
    return GoogleFonts.urbanist(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.normal,
      decoration: isActive ? TextDecoration.lineThrough : TextDecoration.none,
    );
  }

  static textStyleSemiBold(
      {double size = 16, Color textColor = whiteColor}) {
    return GoogleFonts.urbanist(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    );
  }

  static textStyleBold(
      {double size = 18, Color textColor = greyscale900Color}) {
    return GoogleFonts.urbanist(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none,
    );
  }

  static textStyleRegular(
      {double size = 16, Color textColor = whiteColor}) {
    return GoogleFonts.urbanist(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
    );
  }

  static textStyleCustom(
      {double size = 16,
      Color textColor = whiteColor,
      FontWeight fontWeight = FontWeight.w500}) {
    return GoogleFonts.urbanist(
      fontSize: size,
      color: textColor,
      fontWeight: fontWeight,
      decoration: TextDecoration.none,
    );
  }

  static myDecoration(
      {required String title,
      Color? titleColor,
      Color? fillColor,
      Widget? prefixIcon,
      Widget? suffixIcon,
      Color? borderColor}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      prefixIconConstraints: const BoxConstraints(maxHeight: 18),
      hintText: title,
      prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: prefixIcon),
      suffixIcon: suffixIcon,
      hintStyle: Style.textStyleNormal(
          textColor: titleColor ?? whiteColor.withOpacity(0.6), size: 15),
      filled: true,
      fillColor: fillColor ?? whiteColor.withOpacity(0.2),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor ?? Colors.transparent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor ?? Colors.transparent)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor ?? Colors.transparent)),
    );
  }
}
