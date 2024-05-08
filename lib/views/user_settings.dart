import 'package:flutter/material.dart';
import 'package:inventory/message_dialog.dart';
import 'package:inventory/services/auth/auth_service.dart';

class UserSettingsView extends StatelessWidget {
  const UserSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Log out
            showDialog(
              context: context,
              builder: (context) => MessageDialog(
                title: 'Log out',
                message: 'Are you sure you want to log out?',
                icon: Icons.logout,
                onFirstButton: () {
                   Navigator.pop(context);
                },
                firstButtonName: 'Stay in',
                onSecondButton: () async {                
                  Navigator.pushNamedAndRemoveUntil(context, '/', ((route) => false));
                  await AuthService.firebase().logOut();
                },
                secondButtonName: 'Log out',
              ),
            );
            
          },
          child: const Text('Log out'),
        ),
      ),
    );
  }
}
