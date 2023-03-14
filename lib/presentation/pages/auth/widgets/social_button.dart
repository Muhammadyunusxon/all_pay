import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool isLoading;

  const SocialButton(
      {Key? key,
      required this.onTap,
      required this.title,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: 14, horizontal: MediaQuery.of(context).size.width/6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Theme.of(context).hoverColor,
            border: Border.all(color: Theme.of(context).cardColor)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: isLoading
                  ? CircularProgressIndicator(
                      color: Theme.of(context).textTheme.displayMedium?.color,
                    )
                  : Image.asset("assets/images/${title.toLowerCase()}.png"),
            ),
            14.w.horizontalSpace,
            Text(
              "Continue with $title",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontWeight: FontWeight.w500,fontSize: 19.5.sp),
            )
          ],
        ),
      ),
    );
  }
}
