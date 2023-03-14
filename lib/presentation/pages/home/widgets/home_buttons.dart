import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../style/style.dart';

class HomeButtons extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const HomeButtons({Key? key, required this.icon, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              child: Icon(
                icon,
                color: Style.primaryColor,
              ),
            ),
            8.h.verticalSpace,
            Text(
              title,
              style: Style.textStyleSemiBold(
                  textColor: Style.primaryColor,size: 18.sp),
            ),
          ],
        ),
      ),
    );
  }
}
