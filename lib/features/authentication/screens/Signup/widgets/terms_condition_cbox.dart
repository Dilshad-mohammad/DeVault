import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/helpers/colors.dart';
import '../../../../../utils/constants/helpers/sizes.dart';
import '../../../../../utils/constants/helpers/text_strings.dart';
import '../../../../../utils/helpers/helper_function.dart';
import '../../../controllers/signup/signup_controller.dart';

class DTermsConditions extends StatelessWidget {
  const DTermsConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    final controller = SignupController.instance;
    return Row(
        children: [
          SizedBox(width: 24, height: 24,
              child: Obx(
                      () => Checkbox(value: controller.privacypolicy.value, onChanged: (value) =>
                      controller.privacypolicy.value = !controller.privacypolicy.value),
              )),
          const SizedBox(width: DSizes.spaceBtwItems),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: '${DTexts.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: DTexts.privacyPolicy,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(
                  color: dark ? DColors.white : DColors.primary,
                  decorationColor:
                  dark ? DColors.white : DColors.primary,
                )),
            TextSpan(
                text: ' ${DTexts.and} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: DTexts.terms0fUse,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(
                  color: dark ? DColors.white : DColors.primary,
                  decorationColor:
                  dark ? DColors.white : DColors.primary,
                )),
          ]),
          ),
        ]
    );
  }
}
