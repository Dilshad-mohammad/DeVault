import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled/data/repositories/users/user_repository.dart';
import 'package:untitled/features/personalization/Screens/Profile/profile.dart';
import 'package:untitled/features/personalization/controllers/user_controller.dart';
import 'package:untitled/utils/constants/helpers/image_strings.dart';
import 'package:untitled/utils/helpers/network_manager.dart';
import 'package:untitled/utils/popups/full_screen_loader.dart';
import 'package:untitled/utils/popups/loaders.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// Init user data when HomeScreen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading
      DFullScreenLoader.openLoadingDialog('We are updating your information...', DImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        DFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if(!updateUserNameFormKey.currentState!.validate()) {
        DFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first & last name in the Firebase FireStore
      Map<String, dynamic> name = {'FirstName' : firstName.text.trim(), 'LastName' : lastName.text.trim()};
      await userRepository.updateSingleField(name);

      // Update the Rx user values
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Remove Loader
      DFullScreenLoader.stopLoading();

      // Show Success Message
      DLoaders.successSnackBar(title: 'Congratulations', message: 'Your Name has been updated.');

      // Move to previous screen.
      Get.off(const ProfileScreen());
    } catch (e) {
      DFullScreenLoader.stopLoading();
      DLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

}