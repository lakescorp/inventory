import 'package:flutter/material.dart';
import 'package:inventory/constants/routes.dart';
import 'package:inventory/message_dialog.dart';
import 'package:inventory/services/auth/auth_exceptions.dart';
import 'package:inventory/services/auth/auth_service.dart';

class LoginAndRegisterView extends StatefulWidget {
  const LoginAndRegisterView({
    super.key,
    required this.isLogin,
  });

  final bool isLogin;

  @override
  State<LoginAndRegisterView> createState() => _LoginAndRegisterViewState();
}

class _LoginAndRegisterViewState extends State<LoginAndRegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void setError(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => MessageDialog(
        title: title,
        message: message,
        icon: Icons.error,
        onFirstButton: hideError,
        firstButtonName: 'Close',
      ),
    );
  }

  void hideError() {
    Navigator.of(context).pop();
  }

  void submitButton() async {
    final email = _email.text;
    final password = _password.text;

    try {
      if (!widget.isLogin) {
        await AuthService.firebase().createUser(email: email, password: password);
      } else {
        await AuthService.firebase().logIn(email: email, password: password);
      }
      // print(userCredential);
      homeOrVerifyEmail();
    } on CreateUserException catch (e) {
      final text = widget.isLogin ? 'log in' : 'sign up';
      setError('Error on $text', e.message);
    } catch (e) {
      setError('Error', e.toString());
    }
  }

  void homeOrVerifyEmail() {
    final user = AuthService.firebase().currentUser;
    if (user == null) {
      setError('Error', 'User not found');
      return;
    }

    if (user.isEmailVerified) {
      Navigator.pushNamedAndRemoveUntil(context, homeRoute, ((route) => false));
    } else {
      Navigator.pushNamed(context, verifyEmailRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String text = widget.isLogin ? 'Log In' : 'Sign Up';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(50.0),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.3),
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText: 'Email',
                      contentPadding: EdgeInsets.all(15.0),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(50.0),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.3),
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _password,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    contentPadding: EdgeInsets.all(15.0),
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),
              const SizedBox(height: 20.0),
              FilledButton(
                onPressed: submitButton,
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
