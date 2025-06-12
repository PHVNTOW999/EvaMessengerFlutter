import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

/// Represents the authenticated user data.
class UserModel extends Equatable {
  final String uid;
  final String? phoneNumber;
  final String? email; // Not used in phone auth but good to have

  const UserModel({
    required this.uid,
    this.phoneNumber,
    this.email,
  });

  /// Factory constructor to create a UserModel from a Firebase User object.
  factory UserModel.fromFirebaseUser(fb_auth.User user) {
    return UserModel(
      uid: user.uid,
      phoneNumber: user.phoneNumber,
      email: user.email,
    );
  }

  @override
  List<Object?> get props => [uid, phoneNumber, email];
}