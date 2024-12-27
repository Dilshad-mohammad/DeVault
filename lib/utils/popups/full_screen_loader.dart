import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/Loaders/animation_loader.dart';
import '../constants/helpers/colors.dart';
import '../helpers/helper_function.dart';

/// A utility class for managing a full screen loading dialog.
class DFullScreenLoader {
  /// open a full screen loading dialog with a given text and animation.
  /// this method does not return anything.
  ///
  /// parameters:
  /// - text: The text to be displayed in the loading dialog
  /// - animation: The lottie animation to be shown.
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: DHelperFunctions.isDarkMode(Get.context!) ? DColors.dark : DColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250), // Adjust as required
              DAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  /// Stop the currently open loading dialog.
 /// This method doesn't return anything.
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop(); // close the dialog using Navigator.
  }
}
