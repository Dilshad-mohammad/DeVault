import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../../common/widgets/Appbar/appbar.dart';
import '../../../../../utils/constants/helpers/sizes.dart';
import '../../../../../utils/constants/helpers/text_strings.dart';
import '../../../../../utils/validators/validators.dart';
import '../../../../authentication/controllers/edit profile/update_name_controller.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      /// Custom Appbar
      appBar: DAppBar(
          showBackArrow: true,
          title: Text('Change Name', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(padding: const EdgeInsets.all(DSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Headings
          Text('Use real name for easy verification. This name will appear on several pages.',
          style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: DSizes.spaceBtwSections),

          /// Textfield and Button
          Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) => DValidator.validateEmptyText('First Name', value),
                    expands: false,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.user_copy),
                        labelText: DTexts.firstName)),
                  const SizedBox(height: DSizes.spaceBtwInputFields),

                  TextFormField(
                      controller: controller.lastName,
                      validator: (value) => DValidator.validateEmptyText('Last Name', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: DTexts.lastName,
                        prefixIcon: Icon(Iconsax.user_copy)),
                    ),
                ],
              )),
          const SizedBox(height: DSizes.spaceBtwSections),

          /// Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: ()=> controller.updateUserName(), child: const Text('Save')),
          ),
        ],
      ),
      ),
    );
  }
}
