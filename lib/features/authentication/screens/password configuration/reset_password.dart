import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:untitled/features/authentication/screens/Login/login.dart';
import 'package:untitled/utils/constants/helpers/image_strings.dart';
import 'package:untitled/utils/constants/helpers/text_strings.dart';
import '../../../../utils/constants/helpers/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear)),
        ],
      ),
      body: SingleChildScrollView(
        // padding to give default and equal Space on all sides in all screens.
        child: Padding(
          padding: const EdgeInsets.all(DSizes.defaultSpace),
          child: Column(
            children: [
              /// Image with 60% of screen width
              Image(
                  image: const AssetImage(DImages.deliveredEmailIllustration),
                  width: DHelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: DSizes.spaceBtwSections),

              ///Email, Title & SubTitle
              Text(email, style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: DSizes.spaceBtwItems),
              Text(DTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: DSizes.spaceBtwItems),
              Text(DTexts.changeYourPasswordSupTitle, style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: DSizes.spaceBtwSections),

              /// Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.offAll(const LoginScreen()),
                      child: const Text(DTexts.dDone)),
              ),
              const SizedBox(height: DSizes.spaceBtwItems * 1.3),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email),
                    child: const Text(DTexts.resendEmail)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
