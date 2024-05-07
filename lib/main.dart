import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory/constants/routes.dart';
import 'package:inventory/message_dialog.dart';
import 'package:inventory/firebase_options.dart';
import 'package:inventory/views/favourites_view.dart';
import 'package:inventory/views/home/home_view.dart';
import 'package:inventory/views/home/login_register_view.dart';
import 'package:inventory/views/main_view.dart';

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
      theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorSchemeSeed: Colors.deepPurple),
      darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.deepPurple),
      initialRoute: '/',
      routes: {
        registerRoute: (context) => const LoginAndRegisterView(isLogin: false),
        loginRoute: (context) => const LoginAndRegisterView(isLogin: true),
        homeRoute: (context) => const MainView(),
        favouritesRoute: (context) => const FavouritesView(),
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
            return MessageDialog(
              title: 'Error',
              message: 'Could not connect to Firebase',
              icon: Icons.error,
              onFirstButton: () {
                // Handle retry restart app
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', ((route) => false));
              },
              firstButtonName: 'Retry',
            );
          }
          if (FirebaseAuth.instance.currentUser != null){
            return const MainView();
          }
          return const HomeView();
        },
      ),
    );
  }
}
