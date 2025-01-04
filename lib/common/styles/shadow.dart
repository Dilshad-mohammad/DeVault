import 'package:flutter/material.dart';

import '../../utils/constants/helpers/colors.dart';

class DShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: DColors.darkGrey.withAlpha(25),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );

  static final horizontalProductShadow = BoxShadow(
      color: DColors.darkGrey.withAlpha(25),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2)
  );
}