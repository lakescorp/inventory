import 'package:flutter/material.dart';
import 'package:inventory/message_dialog.dart';
import 'package:inventory/services/auth/auth_exceptions.dart';
import 'package:inventory/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  void setError(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => MessageDialog(
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

  void sendEmail() async {
    try {
      await AuthService.firebase().sendEmailVerification();
    } on UserNotLoggedInException catch (e){
      setError('Error sending email', e.message);
    }
    catch (e) {
      setError('Error sending email', e.toString());
    }
  }

  void onAlreadyVerified() async {
    final user = await AuthService.firebase().updateCurrentUser();
    if (!user.isEmailVerified) {
      setError('Error', 'Email not verified');
      return;
    }
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/', ((route) => false));
  }

  @override
  Widget build(BuildContext context) {
    sendEmail();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Verify email",
          style: TextStyle(
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
              "Verify your email!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "For added account security, you will need to verify your email.\nWe have sent you an email with a verification link. Click on the link and come back after you have verified and click on \"Already verified\".",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton(
              onPressed: onAlreadyVerified,
              child: const Text(
                'Already verified',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),            
            const SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: sendEmail,
              child: const Text(
                'Send email again',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
