import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/repositories/authentication/authentication_repo.dart';
import 'package:untitled/data/repositories/authentication/user/user_model.dart';
import 'package:untitled/data/repositories/users/user_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../../utils/constants/helpers/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../screens/Signup/verify_email.dart';
import 'network_manager.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final privacypolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// --Signup
  void signup() async {
    try {

      // Privacy Policy check
      if (!privacypolicy.value) {
        DLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'You must accept the Privacy Policy & Terms of Use to create an account.',
        );
        return;
      }

      // Start loading
      DFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        DImages.decorAnimation,
      );

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        DLoaders.warningSnackBar(
          title: 'No Internet',
          message: 'Please check your internet connection and try again.',
        );
        return;
      }

      // Register user with Firebase Authentication
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Create user model
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      // Save user record to FireStore
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove Loader
      DFullScreenLoader.stopLoading();

      // Show success message
      DLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been created! Please verify your email to continue.',
      );

      // Navigate to verify email screen
      Get.to(const VerifyEmailScreen());
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthError(e);
    } on Exception catch (e) {
      DLoaders.errorSnackBar(
        title: 'Error',
        message: 'An unexpected error occurred. Please try again later.',
      );
      debugPrint('Signup Error: $e');
    } finally {
      // Stop loader
      DFullScreenLoader.stopLoading();
    }
  }

  /// Handle Firebase authentication-specific errors.
  void _handleFirebaseAuthError(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'email-already-in-use':
        errorMessage = 'The email is already in use by another account.';
        break;
      case 'weak-password':
        errorMessage = 'The password is too weak. Please choose a stronger one.';
        break;
      case 'invalid-email':
        errorMessage = 'The email address is invalid. Please enter a valid email.';
        break;
      default:
        errorMessage = 'An error occurred during signup. Please try again.';
    }
    DLoaders.errorSnackBar(title: 'Signup Failed', message: errorMessage);
  }
}
