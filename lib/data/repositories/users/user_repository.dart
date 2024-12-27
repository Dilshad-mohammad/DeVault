import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:untitled/data/repositories/authentication/user/user_model.dart';

/// Repository class for user-related operations.
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

/// Function to save user data to FireStore.
Future<void> saveUserRecord(UserModel user) async { // UserModel
  try {
    return await _db.collection('Users').doc(user.id).set(user.toJson());
  } catch (e){
    throw 'Something went wrong. Please try again';
  }
}

/// Function to fetch user details based on user ID.
/// Functions to update user data in Firestore.
/// Update any field in specific users collection.

}

