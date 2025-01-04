import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled/data/repositories/authentication/authentication_repo.dart';
import 'package:untitled/features/authentication/screens/password%20configuration/reset_password.dart';
import 'package:untitled/utils/constants/helpers/image_strings.dart';
import 'package:untitled/utils/helpers/network_manager.dart';
import 'package:untitled/utils/popups/full_screen_loader.dart';
import 'package:untitled/utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variable
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      // Start Loading
      DFullScreenLoader.openLoadingDialog('Processing your request...', DImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {DFullScreenLoader.stopLoading(); return;}

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        DFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      // Remove Loader
      DFullScreenLoader.stopLoading();
      
      // Show Success Screen
      DLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset Your Password'.tr);
      
      // Redirect
      Get.to(ResetPasswordScreen(email: email.text.trim()));

    } catch (e) {
      // Remove Loader
      DFullScreenLoader.stopLoading();
      DLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      // Start Loading
      DFullScreenLoader.openLoadingDialog('Processing your request...', DImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {DFullScreenLoader.stopLoading(); return;}


      // Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Remove Loader
      DFullScreenLoader.stopLoading();

      // Show Success Screen
      DLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset Your Password'.tr);

    } catch (e) {
      // Remove Loader
      DFullScreenLoader.stopLoading();
      DLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
    }
  }

}