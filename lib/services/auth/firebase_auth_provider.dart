// Implements the AuthProvider interface using Firebase Auth

import 'package:firebase_core/firebase_core.dart';
import 'package:inventory/firebase_options.dart';
import 'package:inventory/services/auth/auth_exceptions.dart';
import 'package:inventory/services/auth/auth_user.dart';
import 'package:inventory/services/auth/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;

class FirebaseAuthProvider implements AuthProvider {
  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    return user == null ? null : AuthUser.fromFirebase(user);
  }

  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user == null) {
        throw UserNotLoggedInException(message: 'User not logged in');
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw CreateUserException.fromFirebaseAuthException(e);
    } catch (e) {
      throw GenericAuthException(message: e.toString());
    }
  }

  @override
  Future<AuthUser> logIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user == null) {
        throw UserNotLoggedInException(message: 'User not logged in');
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw LogInException.fromFirebaseAuthException(e);
    } catch (e) {
      throw GenericAuthException(message: e.toString());
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw UserNotLoggedInException(message: 'User not logged in');
    }
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
    } catch (e) {
      throw UserNotLoggedInException(message: 'User not logged in');
    }
  }

  @override
  Future<AuthUser> updateCurrentUser() async {
    await FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw UserNotLoggedInException(message: 'User not logged in');
    }
    return AuthUser.fromFirebase(user);
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
}
