import 'package:flutter/material.dart';

class ErrorMessageDialog extends StatelessWidget {
  final String title;
  final String message;
  final String firstButtonName;
  final String? secondButtonName;
  final IconData icon;
  final VoidCallback onFirstButton;
  final VoidCallback? onSecondButton;

  const ErrorMessageDialog({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    required this.onFirstButton,
    this.onSecondButton,
    required this.firstButtonName,
    this.secondButtonName,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Icon(
        icon,
        size: 50,
        color: Colors.white,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onFirstButton,
              child: Text(firstButtonName),
            ),
            if (secondButtonName != null)
              TextButton(
                onPressed: onSecondButton,
                child: Text(secondButtonName!),
              ),
          ],
        ),
      ],
    );
  }
}
