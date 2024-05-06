import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory/error_message_dialog.dart';
import 'package:inventory/views/home/verify_email.dart';

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
      builder: (context) => ErrorMessageDialog(
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

    var success = false;

    if (!widget.isLogin) {
      try {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        success = true;
      } on FirebaseAuthException catch (e) {
        setError('Error on register', e.message!);
      }
    } else {
      try {
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        success = true;
      } on FirebaseAuthException catch (e) {
        setError('Error on log in', e.message!);
      }
    }

    if (success) homeOrVerifyEmail();
  }

  void homeOrVerifyEmail() {
    final user = FirebaseAuth.instance.currentUser;
    if(user == null) {
      setError('Error', 'User not found');
      return;
    }

    if (user.emailVerified) {
      print("TODO: lAUNCH APP");
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const VerifyEmailView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final String text = widget.isLogin ? 'Log In' : 'Sign Up';
    //print(Theme.of(context).colorScheme.);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        title: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white24,
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: Offset(0, 6),
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
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white24,
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: Offset(0, 6),
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
                  FilledButton.tonal(
                      onPressed: submitButton,
                      child: Text(text,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF381E72)))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
