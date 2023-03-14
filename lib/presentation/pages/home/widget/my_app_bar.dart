import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget {
  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 22,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        32.horizontalSpace,
        Text(
          title,
          style:
              Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 18),
        ),
      ],
    );
  }
}
