import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/utils/constants/helpers/colors.dart';
import '../../../utils/constants/helpers/sizes.dart';

class DAnimationLoaderWidget extends StatelessWidget {
  /// Default constructor for the DAnimationLoaderWidget.
  ///
  /// Parameters:
  ///  - text: The text to be displayed below the animation.
  ///  - animation: The path to the Lottie animation file.
  ///  - showAction:Whether to show an action button below the text.
  ///  - actionText: The text to be displayed on the action button.
  ///  - onActionPressed: Callback function to be execute when the action button is pressed.

  const DAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,
              width: MediaQuery.of(context).size.width * 0.8),
          const SizedBox(height: DSizes.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DSizes.defaultSpace),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    style:
                        OutlinedButton.styleFrom(backgroundColor: DColors.dark),
                    child: Text(
                      actionText!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: DColors.light),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
