import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String logoPath = 'assets/Images/logo.svg';

  void setPage(int value) {
    setState(() {
      switch (value) {
        case 1:
          Navigator.pushNamed(context, '/register');
          break;
        case 2:
          Navigator.pushNamed(context, '/login');
          break;
        default:
          Navigator.popUntil(context, ModalRoute.withName('/'));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
                children: [
                  Text('Welcome to',
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                  Text('Inventory',
                      style:
                          TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                ],
              ),
              SvgPicture.asset(
                logoPath,
                semanticsLabel: 'Inventory Logo',
                width: 150,
                height: 150,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilledButton(
                    onPressed: () => setPage(1),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () => setPage(2),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
