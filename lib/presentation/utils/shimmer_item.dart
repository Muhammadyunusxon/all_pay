import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItem extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const ShimmerItem(
      {Key? key,
      required this.height,
      required this.width,
      required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width,
        height: height,
        child: Shimmer.fromColors(
          baseColor: const Color(0x80FFFFFF),
          highlightColor: const Color(0x33FFFFFF),
          child:
              Container(width: width, height: height, color: const Color(0x3348319D)),
        ),
      ),
    );
  }
}
