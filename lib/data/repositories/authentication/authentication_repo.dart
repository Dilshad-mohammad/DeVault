import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/features/authentication/screens/Login/login.dart';
import 'package:untitled/features/authentication/screens/onboarding/onboarding.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  ///Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// called from main.dart on app launch
  @override
  void onReady(){
    FlutterNativeSplash.remove();
    // Redirect to the Appropriate screen
    screenRedirect();
  }

  /// Function to show relevant Screen
  screenRedirect() async{
    // Local Storage
      deviceStorage.writeIfNull('isFirstTime', true);
      // check if true then launch the app
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnboardingScreen());
    }

/*------------------------Email & Password sign-in -----------------------*/
  /// [EmailAuthentication] - Sign-in

  /// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailVerification] - MAIL VERIFICATION

  /// [rEAuthentication] - ReAuthenticate user

  /// [EmailAuthentication] - FORGET PASSWORD

/*------------------------ Federated identity & Social sign-in ------------------*/
  /// [GoogleAuthentication] - GOOGLE

  /// [FacebookAuthentication] - FORGET PASSWORD

/*------------------------ ./end Federated identity & Social sign-in -------------------*/
    /// [LogoutUser] - Valid for any authentication.

    /// [DeleteUser] - Remove user Auth and FireStore Account.

}

