import 'package:get/get.dart';
import 'package:untitled/features/authentication/controllers/signup/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());

  }
}