import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/repositories/authentication/authentication_repo.dart';
import 'package:untitled/utils/constants/helpers/image_strings.dart';
import 'package:untitled/utils/constants/helpers/sizes.dart';
import 'package:untitled/utils/constants/helpers/text_strings.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../controllers/signup/verify_email_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      /// The close icon in the app bar is used to log out the user and redirect them to the login screen.
      /// This approach is taken to handle scenarios where the user enters the registration process,
      /// and the data is stored. Upon reopening the app, it checks if the email is verified.
      /// If not verified, the app always navigates to the verification screen.

      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear))],
      ),
      body: SingleChildScrollView(
        // padding to give default and equal Space on all sides in all screens.
        child: Padding(
          padding: const EdgeInsets.all(DSizes.defaultSpace),
          child: Column(
            children: [
              /// Image
              Image(
                  image: const AssetImage(DImages.deliveredEmailIllustration),
                  width: DHelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: DSizes.spaceBtwSections),

              /// Title & SubTitle
              Text(DTexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: DSizes.spaceBtwItems),
              Text(email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: DSizes.spaceBtwItems),
              Text(DTexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: DSizes.spaceBtwSections),

              /// Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.checkEmailVerificationStatus(),
                      child: const Text(DTexts.dContinue))),
              const SizedBox(height: DSizes.spaceBtwItems),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => controller.sendEmailVerification(), child: const Text(DTexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
