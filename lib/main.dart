import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory/error_message_dialog.dart';
import 'package:inventory/firebase_options.dart';
import 'package:inventory/views/home/home_view.dart';
import 'package:inventory/views/home/login_register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/register': (context) => const LoginAndRegisterView(isLogin: false),
        '/login': (context) => const LoginAndRegisterView(isLogin: true),      
      },
      home: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return ErrorMessageDialog(
              title: 'Error',
              message: 'Could not connect to Firebase',
              icon: Icons.error,
              onFirstButton: () {
                // Handle retry restart app
                Navigator.pushNamedAndRemoveUntil(context, '/', ((route) => false));
              },
              firstButtonName: 'Retry',
            );
          }

          return const HomeView();
        },
      ),
    );
  }
}
