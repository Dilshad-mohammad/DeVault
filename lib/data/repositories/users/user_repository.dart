import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:untitled/data/repositories/authentication/authentication_repo.dart';
import 'package:untitled/data/repositories/authentication/user/user_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

/// Repository class for user-related operations.
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

/// Function to save user data to FireStore.
Future<void> saveUserRecord(UserModel user) async { // UserModel
  try {
    await _db.collection('Users').doc(user.id).set(user.toJson());
  } on FirebaseException catch (e) {
      throw DFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const DFormatException();
    } on PlatformException catch (e) {
      throw DPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to fetch user details based on user ID.
  Future<UserModel> fetchUserDetails() async { // UserModel
    try {
     final documentSnapshot = await _db.collection('Users').doc(AuthenticationRepository.instance.authUser?.uid).get();
     if (documentSnapshot.exists) {
       return UserModel.fromSnapshot(documentSnapshot);
     } else {
       return UserModel.empty();
     }
    } on FirebaseException catch (e) {
      throw DFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const DFormatException();
    } on PlatformException catch (e) {
      throw DPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Functions to update user data in FireStore.
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db.collection('Users').doc(updateUser.id).update(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw DFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const DFormatException();
    } on PlatformException catch (e) {
      throw DPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update any field in specific users collection.
  Future<void> updateSingleField(Map<String, dynamic> json) async { // UserModel
    try {
      await _db.collection('Users').doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    } on FirebaseException catch (e) {
      throw DFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const DFormatException();
    } on PlatformException catch (e) {
      throw DPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to remove user data from FireStore.
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw DFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const DFormatException();
    } on PlatformException catch (e) {
      throw DPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}

