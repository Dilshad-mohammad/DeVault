import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled/utils/constants/helpers/colors.dart';
import 'package:untitled/utils/helpers/helper_function.dart';

class DShimmerEffect extends StatelessWidget {
  const DShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color
  });

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
        baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
        highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color ?? (dark ? DColors.darkerGrey : DColors.white),
            borderRadius: BorderRadius.circular(radius),
          ),
        )
    );
  }
}
