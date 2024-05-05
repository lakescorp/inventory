import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory/views/error_message.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String logoPath = 'svg/logo/logo.svg';

  var _error = false;

  Widget _errorWidget = ErrorMessage(
    title: 'Error',
    message: 'An error occurred',
    icon: Icons.error,
    onFirstButton: () {},
    onSecondButton: () {},
    firstButtonName: '',
    secondButtonName: '',
  );

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

  void setError(Widget errorWidget) {
    setState(() {
      _error = true;
      _errorWidget = errorWidget;
      print('uPDATED MESSAGE error: $_error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Welcome to',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              const Text('Inventory',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
              SvgPicture.asset(
                logoPath,
                semanticsLabel: 'Inventory Logo',
                width: 150,
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FilledButton.tonal(
                        onPressed: () => setPage(1),
                        child: const Text('Sign Up',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF381E72)))),
                    const SizedBox(height: 10, width: 10),
                    TextButton(
                        onPressed: () => setPage(2),
                        child: const Text('Log In',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEADDFF)))),
                  ],
                ),
              ),
            ],
          ),
          _error ? _errorWidget : const SizedBox.shrink(),
        ]),
      ),
    );
  }
}
