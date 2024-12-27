import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/utils/formatters/formatters.dart';

/// Model class representing user data.
class UserModel {
  // Fields that are immutable
  final String id;
  final String username;
  final String email;

  // Mutable fields
  String firstName;
  String lastName;
  String phoneNumber;
  String profilePicture;

  /// Constructor for UserModel.
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// Helper function to get the full name.
  String get fullName => '$firstName $lastName';

  /// Helper function to format the phone number.
  String get formattedPhoneNo => DFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name.
  static List<String> splitFullName(String fullName) {
    return fullName.split(" ");
  }

  /// Static function to generate a username from the full name.
  static String generateUsername(String fullName) {
    if (fullName.trim().isEmpty) return "cwt_user";

    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName"; // Combine first and last
    return "cwt_$camelCaseUsername"; // Add "cwt_" prefix
  }

  /// Static function to create an empty user model.
  static UserModel empty() {
    return UserModel(
      id: '',
      firstName: '',
      lastName: '',
      username: '',
      email: '',
      phoneNumber: '',
      profilePicture: '',
    );
  }

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) {
      throw Exception("Document does not contain valid data");
    }

    return UserModel(
      id: document.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      profilePicture: data['profilePicture'] ?? '',
    );
  }
}
