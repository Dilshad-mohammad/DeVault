import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/data/repositories/authentication/authentication_repo.dart';
import 'package:untitled/data/repositories/authentication/user/user_model.dart';
import 'package:untitled/data/repositories/users/user_repository.dart';
import 'package:untitled/features/authentication/screens/Login/login.dart';
import 'package:untitled/features/personalization/Screens/Profile/widgets/re_authenticate_user_login_form.dart';
import 'package:untitled/utils/constants/helpers/image_strings.dart';
import 'package:untitled/utils/constants/helpers/sizes.dart';
import 'package:untitled/utils/popups/full_screen_loader.dart';
import 'package:untitled/utils/popups/loaders.dart';

import '../../../utils/helpers/network_manager.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh user Record
      await fetchUserRecord();

      // If no record already stored.
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to First and Last Name
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          // Map Data
          final user = UserModel(
              id: userCredentials.user!.uid,
              firstName: nameParts[0],
              lastName:
                  nameParts.length > 1 ? nameParts.sublist(1).join(" ") : '',
              username: username,
              email: userCredentials.user!.email ?? '',
              phoneNumber: userCredentials.user!.phoneNumber ?? '',
              profilePicture: userCredentials.user!.photoURL ?? '');

          // Save user Data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      DLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. You can re-save your data in your Profile.');
    }
  }

  /// Delete Account Warning Popup
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(DSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you Sure? You want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: DSizes.lg),
            child: Text('Delete')),
      ),
      cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel')),
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      DFullScreenLoader.openLoadingDialog(
          'Processing...', DImages.decorAnimation);

      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser?.providerData.map((e) => e.providerId).first;

      if (provider != null && provider.isNotEmpty) {
        switch (provider) {
          case 'Google.com':
            await auth.signInWithGoogle();
            break;
          case 'password':
            DFullScreenLoader.stopLoading();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (Navigator.of(Get.context!).canPop()) {
                Get.to(() => const ReAuthLoginForm());
              } else {
                Navigator.of(Get.context!).push(
                  MaterialPageRoute(builder: (_) => const ReAuthLoginForm()),
                );
              }
            });
            return;
          // Handle other providers if needed
        }

        await auth.deleteAccount();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (Navigator.of(Get.context!).canPop()) {
            Get.offAll(() => const LoginScreen());
          } else {
            Navigator.of(Get.context!).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (Route<dynamic> route) => false,
            );
          }
        });
      }
    } catch (e) {
      DLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      DFullScreenLoader.stopLoading();
    }
  }

  /// -- Re-AUTHENTICATE before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    DFullScreenLoader.openLoadingDialog(
        'Processing...', DImages.decorAnimation);
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        DLoaders.warningSnackBar(
          title: 'No Internet',
          message: 'Please check your internet connection.',
        );
        return;
      }

      // Form Validation
      if (!reAuthFormKey.currentState!.validate()) {
        DLoaders.warningSnackBar(
          title: 'Validation Error',
          message: 'Please fill all required fields correctly.',
        );
        return;
      }

      // Re-authenticate and delete account
      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
        verifyEmail.text.trim(),
        verifyPassword.text.trim(),
      );
      await AuthenticationRepository.instance.deleteAccount();

      DLoaders.successSnackBar(
        title: 'Success',
        message: 'Account deleted successfully.',
      );

      // Ensure navigation happens after the current frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Navigator.of(Get.context!).canPop()) {
          Get.offAll(const LoginScreen());
        } else {
          Navigator.of(Get.context!).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (Route<dynamic> route) => false,
          );
        }
      });
    } catch (e) {
      DLoaders.warningSnackBar(
        title: 'Oh Snap!',
        message: 'Failed to delete account: ${e.toString()}',
      );
    } finally {
      DFullScreenLoader.stopLoading();
    }
  }

  /// -- Upload profile Image
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        // Upload Image
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        // Update User Image Record
        Map<String, dynamic> json = {'profilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        DLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your Profile Image has been updated!');
      }
    } catch (e) {
      DLoaders.errorSnackBar(
          title: 'OhSnap', message: 'Something went wrong: $e');
    }
  }
}
