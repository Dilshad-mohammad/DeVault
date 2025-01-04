import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:untitled/features/personalization/controllers/user_controller.dart';
import '../../../utils/constants/helpers/colors.dart';
import '../../../utils/constants/helpers/image_strings.dart';
import '../Images/dcircular_image.dart';

class DUserProfileTile extends StatelessWidget {
  const DUserProfileTile({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: const DCircularImage(image: DImages.user, width: 50, height: 50, padding: 0),
      title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: DColors.white)),
      subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: DColors.white)),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit_copy, color: DColors.white)),
    );
  }
}