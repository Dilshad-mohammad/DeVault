import 'package:flutter/material.dart';

import '../../../utils/constants/helpers/colors.dart';
import '../../../utils/helpers/helper_function.dart';

class DFormDivider extends StatelessWidget {
  const DFormDivider({
    super.key,
    required this.dividerText,
  });

  final String dividerText;
  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Divider(color: dark ? DColors.darkGrey : DColors.grey, thickness: 0.5, indent: 60, endIndent: 5)),
        Text(dividerText, style: Theme.of(context).textTheme.labelMedium),
        Flexible(child: Divider(color: dark ? DColors.darkGrey : DColors.grey, thickness: 0.5, indent: 5, endIndent: 60)),
      ],
    );
  }
}