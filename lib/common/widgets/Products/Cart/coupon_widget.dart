import 'package:flutter/material.dart';

import '../../../../utils/constants/helpers/colors.dart';
import '../../../../utils/constants/helpers/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../Custom shapes/Containers/rounded_container.dart';

class DCouponCode extends StatelessWidget {
  const DCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return DRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? DColors.dark : DColors.white,
      padding: const EdgeInsets.only(
          top: DSizes.sm,
          bottom: DSizes.sm,
          right: DSizes.sm,
          left: DSizes.md),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),

          /// Buttons
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: dark
                    ? DColors.white.withAlpha(128)
                    : DColors.dark.withAlpha(128),
                backgroundColor: DColors.grey..withAlpha(51),
                side:
                BorderSide(color: DColors.grey..withAlpha(25)),
              ),
              child: const Text('Apply'),
            ),
          )
        ],
      ),
    );
  }
}
