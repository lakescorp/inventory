// Information about the current user

import 'package:firebase_auth/firebase_auth.dart' show User;

class AuthUser {
  final bool isEmailVerified;

  AuthUser(this.isEmailVerified);

  factory AuthUser.fromFirebase(User user) {
    return AuthUser(user.emailVerified);
  }
}