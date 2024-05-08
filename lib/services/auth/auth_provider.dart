// Abstract class for AuthProvider

import 'dart:async';

import 'package:inventory/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();

  AuthUser? get currentUser;

  Future<AuthUser> updateCurrentUser();

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<void> sendEmailVerification();
}
