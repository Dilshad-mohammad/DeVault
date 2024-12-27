import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:untitled/features/authentication/controllers/signup/signup_controller.dart';
import 'package:untitled/features/authentication/screens/Signup/widgets/terms_condition_cbox.dart';
import '../../../../../utils/constants/helpers/sizes.dart';
import '../../../../../utils/constants/helpers/text_strings.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../../../utils/validators/validators.dart';

class DSignupForm extends StatelessWidget {
  const DSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          /// First & Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      DValidator.validateEmptyText('First name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: DTexts.firstName,
                      prefixIcon: Icon(Iconsax.user_copy)),
                ),
              ),
              const SizedBox(width: DSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      DValidator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: DTexts.lastName,
                      prefixIcon: Icon(Iconsax.user_copy)),
                ),
              ),
            ],
          ),
          const SizedBox(height: DSizes.spaceBtwInputFields),

          /// Username
          TextFormField(
            controller: controller.username,
            validator: (value) =>
                DValidator.validateEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: DTexts.username,
                prefixIcon: Icon(Iconsax.user_edit_copy)),
          ),
          const SizedBox(height: DSizes.spaceBtwInputFields),

          /// Email
          TextFormField(
            controller: controller.email,
            validator: (value) => DValidator.validateEmail(value),
            expands: false,
            decoration: const InputDecoration(
                labelText: DTexts.email, prefixIcon: Icon(Iconsax.direct_copy)),
          ),
          const SizedBox(height: DSizes.spaceBtwInputFields),

          /// Phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => DValidator.validatePhoneNumber(value),
            expands: false,
            decoration: const InputDecoration(
                labelText: DTexts.phoneNo, prefixIcon: Icon(Iconsax.call_copy)),
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
                  icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash_copy : Iconsax.eye_copy),
                ),
              ),
            ),
          ),
          const SizedBox(height: DSizes.spaceBtwSections),

          /// Terms&Conditions Checkbox
          const DTermsConditions(),

          /// Sign up button
          const SizedBox(height: DSizes.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Validate the form
                if (!controller.signupFormKey.currentState!.validate()) {
                  DLoaders.warningSnackBar(
                    title: 'Invalid Input',
                    message: 'Please fill in all required fields correctly.',
                  );
                  return; // Do not proceed with signup if validation fails
                }

                // Trigger signup only if validation passes
                controller.signup();
              },
              child: const Text(DTexts.createAccount),
            ),
          ),

        ],
      ),
    );
  }
}
