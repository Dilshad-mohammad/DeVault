import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/common/widgets/Appbar/appbar.dart';
import 'package:untitled/common/widgets/Images/dcircular_image.dart';
import 'package:untitled/common/widgets/texts/section_heading.dart';
import 'package:untitled/features/personalization/Screens/Profile/widgets/change_name.dart';
import 'package:untitled/features/personalization/Screens/Profile/widgets/profile_menu.dart';
import 'package:untitled/utils/constants/helpers/image_strings.dart';
import 'package:untitled/utils/constants/helpers/sizes.dart';
import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const DAppBar(
        showBackArrow: true, title: Text('Profile')),
      /// -- Body
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(DSizes.defaultSpace),
        child: Column(
          children: [
            /// Profile Picture
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Obx(() {
                    final networkImage = controller.user.value.profilePicture;
                    final image = networkImage.isNotEmpty ? networkImage : DImages.user;
                    return DCircularImage(image: image, width: 80, height: 80, isNetworkImage: networkImage.isNotEmpty);
                  }),
                  TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),
                ],
              ),
            ),

            /// Detailed
            const SizedBox(height: DSizes.spaceBtwItems / 2),
            const Divider(),
            const SizedBox(height: DSizes.spaceBtwItems),

            /// Heading Profile Info
            const DSectionHeading(title: 'Profile Information', showActionButton: false),
            const SizedBox(height: DSizes.spaceBtwItems),

            DProfileMenu(onPressed: () => Get.to(const ChangeName()), title: 'Name',value: controller.user.value.fullName),
            DProfileMenu(onPressed: (){}, title: 'Username',value: controller.user.value.email),

            const SizedBox(height: DSizes.spaceBtwItems),
            const Divider(),
            const SizedBox(height: DSizes.spaceBtwItems),

            /// Heading Personal Info
            const DSectionHeading(title: 'Personal Information', showActionButton: false),
            const SizedBox(height: DSizes.spaceBtwItems),

            DProfileMenu(onPressed: (){},title: 'User ID',value: controller.user.value.id),
            DProfileMenu(onPressed: (){},title: 'E-mail',value: controller.user.value.email),
            DProfileMenu(onPressed: (){},title: 'Phone Number',value: controller.user.value.phoneNumber),
            DProfileMenu(onPressed: (){},title: 'Gender',value: 'Male'),
            DProfileMenu(onPressed: (){},title: 'Date of Birth',value: '09 Feb 2003'),
            const Divider(),
            const SizedBox(height: DSizes.spaceBtwItems),

            Center(
              child: TextButton(onPressed: ()=> controller.deleteAccountWarningPopup(),
                child: const Text('Close Account', style: TextStyle(color: Colors.red)),
              ),
            )

          ],
        ),
        ),
      ),
    );
  }
}


