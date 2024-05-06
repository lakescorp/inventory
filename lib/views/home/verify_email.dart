import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory/error_message_dialog.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  void setError(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => ErrorMessageDialog(
        title: title,
        message: message,
        icon: Icons.email,
        onFirstButton: hideError,
        firstButtonName: 'Close',
      ),
    );
  }

  void hideError() {
    Navigator.of(context).pop();
  }

  void onSendEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.sendEmailVerification();
  }

  void onAlreadyVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    final verified = user?.emailVerified ?? false;
    if (!verified) {
      setError('Error', 'Email not verified');
      return;
    }
    print('verified -> $verified');
    print('TODO: to main app');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        title: const Text(
          "Verify email",
          style: TextStyle(
            color: Colors.white,
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
            const Icon(
              Icons.email_rounded,
              size: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your email is not\nverified",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "For added account security, you will need to verify your email.\nTo verify it, click on the button so that we can send you an email with a link to verify it.",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton.tonal(
                onPressed: onSendEmail,
                child: const Text('Send email',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF381E72)))),
            const SizedBox(
              height: 5,
            ),
            TextButton(
                onPressed: onAlreadyVerified,
                child: const Text('Already verified',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: Colors.white))),
          ],
        ),
      )),
    );
  }
}
