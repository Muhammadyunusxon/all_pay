import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../style/style.dart';
import 'card_item.dart';

class ChangeCardTheme extends StatelessWidget {
  final ValueChanged onGradient;
  final ValueChanged onImage;
  final int indexGradient;
  final int indexImage;

  const ChangeCardTheme(
      {Key? key,
      required this.onGradient,
      required this.onImage,
      required this.indexGradient,
      required this.indexImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ListView.builder(
                itemCount: 14,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding:  EdgeInsets.only(left: 18.w,right: 6.w),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () => onImage(index),
                      child: Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/background/$index.jpg"),
                              fit: BoxFit.cover),
                        ),
                        child: indexImage == index
                            ? const Icon(Icons.done, color: Style.whiteColor)
                            : const SizedBox.shrink(),
                      ),
                    ),
                  );
                }),
            ListView.builder(
                itemCount: listOfGradient.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(right: 18.w),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () => onGradient(index),
                      child: Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [
                            Color(listOfGradient[index].first),
                            Color(listOfGradient[index].last),
                          ]),
                        ),
                        child: indexGradient == index
                            ? const Icon(
                                Icons.done,
                                color: Style.whiteColor,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
