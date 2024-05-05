import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
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
        flexibleSpace: const Center(
          child: Text(
            "Verify email",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(10),
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
              "For added account security, you will need to verify your email.\n\nTo verify it, click on the button so that we can send you an email with a link to verify it.",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton.tonal(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                },
                child: const Text('Send email',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF381E72)))),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.currentUser?.reload();
                  final user = FirebaseAuth.instance.currentUser;
                  final verified = user?.emailVerified;
                  print('verified -> $verified');
                  print('TODO: to main app');
                },
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
