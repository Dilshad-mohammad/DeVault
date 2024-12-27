import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/common/styles/spacing_styles.dart';
import 'package:untitled/features/authentication/screens/Login/widgets/login_form.dart';
import 'package:untitled/features/authentication/screens/Login/widgets/login_header.dart';
import 'package:untitled/utils/constants/helpers/sizes.dart';
import 'package:untitled/utils/constants/helpers/text_strings.dart';

import '../../../../common/widgets/Login_Signup/form_divider.dart';
import '../../../../common/widgets/Login_Signup/social_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: DSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo, Title & Sub-Title
              const DLoginHeader(),

              /// Form
              const DLoginForm(),

              ///Divider
              DFormDivider(dividerText: DTexts.orSignInWith.capitalize!),
              const SizedBox(height: DSizes.spaceBtwSections),

              ///Footer
              const DSocialButtons()

            ],
          ),
        ),
      ),
    );
  }
}
