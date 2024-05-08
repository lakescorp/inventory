import 'package:firebase_auth/firebase_auth.dart';

class MessageException implements Exception {
  final String message;

  MessageException({required this.message});

  factory MessageException.fromFirebaseAuthException(FirebaseAuthException e) {
    return MessageException(message: e.message ?? e.toString());
  }

  @override
  String toString() {
    return message;
  }
}

class UserNotLoggedInException implements MessageException {
  @override
  final String message;

  UserNotLoggedInException({required this.message});
}

class CreateUserException implements MessageException {
  @override
  final String message;

  CreateUserException({required this.message});

  factory CreateUserException.fromFirebaseAuthException(
      FirebaseAuthException e) {
    return CreateUserException(message: e.message ?? e.toString());
  }
}

class LogInException implements MessageException {
  @override
  final String message;

  LogInException({required this.message});
  factory LogInException.fromFirebaseAuthException(FirebaseAuthException e) {
    return LogInException(message: e.message ?? e.toString());
  }
}

class GenericAuthException implements MessageException {
  @override
  final String message;

  GenericAuthException({required this.message});
}
