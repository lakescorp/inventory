import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory/views/error_message.dart';
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

  var _error = false;

  Widget _errorMessage = ErrorMessage(
    title: '',
    message: '',
    icon: Icons.error,
    onFirstButton: () {},
    onSecondButton: () {},
    firstButtonName: '',
  );

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

  void setError(Widget errorMessage) {
    setState(() {
      _error = true;
      _errorMessage = errorMessage;
    });
  }

  void hideError() {
    setState(() {
      _error = false;
    });
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
        print(e);
        setError(ErrorMessage(
          title: 'Error on register',
          message: e.message!,
          icon: Icons.error, // Add the error icon here
          onFirstButton: () {
            hideError();
          },
          onSecondButton: () {}, firstButtonName: 'Close',
        ));
      }
    } else {
      try {
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        success = true;
      } on FirebaseAuthException catch (e) {
        print(e);
        setError(ErrorMessage(
          title: 'Error on log in',
          message: e.message!,
          icon: Icons.error, // Add the error icon here
          onFirstButton: () {
            hideError();
          },
          onSecondButton: () {}, firstButtonName: 'Close',
        ));
      }
    }


    if(success) homeOrVerifyEmail();

  }

  void homeOrVerifyEmail(){

    final user = FirebaseAuth.instance.currentUser;

    if(user?.emailVerified ?? false){
      print("TODO: lAUNCH APP");
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => const VerifyEmailView()));
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
        flexibleSpace: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
        ),
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
          _error ? Center(child: _errorMessage) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
