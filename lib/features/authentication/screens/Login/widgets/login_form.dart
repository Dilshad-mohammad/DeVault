import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:untitled/features/authentication/controllers/login/login_controller.dart';
import 'package:untitled/features/authentication/screens/Signup/signup.dart';
import 'package:untitled/features/authentication/screens/password%20configuration/forgot_password.dart';
import 'package:untitled/utils/validators/validators.dart';
import '../../../../../utils/constants/helpers/sizes.dart';
import '../../../../../utils/constants/helpers/text_strings.dart';

class DLoginForm extends StatelessWidget {
  const DLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DSizes.spaceBtwSections),
        child: Column(
          children: [
            /// Email
            TextFormField(
              controller: controller.email,
              validator: (value) => DValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right_copy),
                  labelText: DTexts.email),
            ),
            const SizedBox(height: DSizes.spaceBtwInputFields),

            /// Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => DValidator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: DTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check_copy),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash_copy
                        : Iconsax.eye_copy),
                  ),
                ),
              ),
            ),
            const SizedBox(height: DSizes.spaceBtwInputFields / 2),

            /// Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remember Me
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value)),
                    const Text(DTexts.rememberMe),
                  ],
                ),

                /// Forget Password
                TextButton(
                    onPressed: () => Get.to(const ForgotPassword()),
                    child: const Text(DTexts.forgetPassword)),
              ],
            ),
            const SizedBox(height: DSizes.spaceBtwSections),

            /// Sign in Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.emailAndPasswordSignIn(),
                    child: const Text(DTexts.signIn))),
            const SizedBox(height: DSizes.spaceBtwItems),

            /// Create Account Button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(const SignupScreen()),
                    child: const Text(DTexts.createAccount))),
          ],
        ),
      ),
    );
  }
}
