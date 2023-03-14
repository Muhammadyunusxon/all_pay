import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon;

  const ChangeButton(
      {Key? key, required this.onTap, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            20.horizontalSpace,
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 18),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 22,
              color: Theme.of(context).secondaryHeaderColor,
            )
          ],
        ),
      ),
    );
  }
}
