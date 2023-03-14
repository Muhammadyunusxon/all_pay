import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/style.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  const MyButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(33.r),
            gradient: Style.blueGradiant),
        child: Center(
            child: isLoading
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Style.whiteColor),
                  )),
      ),
    );
  }
}
